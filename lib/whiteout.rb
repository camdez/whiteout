require "whiteout/version"
require "optparse"
require "tempfile"
require "fileutils"

module Whiteout
  def self.execute(*args)
    recurse = false
    verbose = false

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: whiteout file1 [...]"

      opts.on('-h', '--help', 'Display this screen') do
        puts opts
        exit
      end

      opts.on('-r', '--recursive', 'Process all files under each directory, recursively') do
        recurse = true
      end

      opts.on('-v', '--verbose', 'Be verbose, naming files as they are being processed') do
        verbose = true
      end
    end

    begin
      opts.parse!(args)
    rescue OptionParser::InvalidOption => e
      abort "#{e}\n#{opts}"
    end

    if !$stdin.tty? || args[0] == '-'
      puts self.clean($stdin.read)
    else
      abort opts.to_s if args.empty?

      self.input_list(args, recurse).each do |file|
        self.clean_file(file, verbose)
      end
    end
  end

  class InvalidByteSequenceError < StandardError
    attr_reader :original

    def initialize(msg, original = nil)
      super(msg)
      @original = original
    end
  end

  def self.clean_file(file, verbose = false)
    File.open(file) do |infile|
      puts file if verbose

      outfile = Tempfile.new('whiteout')

      begin
        infile.each do |line|
          outfile.write(self.clean(line))
        end
      rescue InvalidByteSequenceError
        warn "#{file} is a binary file; not processing"
        outfile.close
        outfile.unlink
      else
        outfile.chmod(infile.stat.mode)
        outfile.close
        FileUtils.mv(outfile, infile)
      end
    end
  end

  def self.clean(str)
    str.gsub(/[ \t]+$/, '')
  rescue ArgumentError => e
    if e.message == "invalid byte sequence in UTF-8"
      raise InvalidByteSequenceError.new(e.message, e)
    else
      raise e
    end
  end

  def self.input_list(file_args, recurse)
    to_process = file_args
    ret = []

    to_process.each do |file|
      abort "Can't find #{file}" unless File.exists?(file)

      if File.directory?(file)
        if recurse
          Dir[file + "/**/*"].each do |subfile|
            to_process << subfile
          end
        else
          abort "#{file} is a directory; not processing without -r option"
        end
      else
        ret << file
      end
    end

    ret
  end
end
