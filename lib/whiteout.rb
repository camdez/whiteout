require "whiteout/version"
require "optparse"

# TODO add man page

module Whiteout
  def self.execute(*args)
    recurse = false

    opts = OptionParser.new do |opts|
      opts.banner = "Usage: whiteout file1 [...]"

      opts.on('-h', '--help', 'Display this screen') do
        puts opts
        exit
      end

      opts.on('-r', '--recursive', 'Clean all files under each directory, recursively') do
        recurse = true
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
        contents = File.read(file)

        # TODO consider writing to a temporary file and moving into place
        File.open(file, 'w') do |f|
          f.write(self.clean(contents))
        end
      end
    end
  end

  def self.clean(str)
    str.gsub(/[ \t]+$/, '')
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
