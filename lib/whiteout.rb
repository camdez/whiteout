require "whiteout/version"
require "optparse"

module Whiteout
  def self.execute(*args)
    opts = OptionParser.new do |opts|
      opts.banner = "Usage: whiteout file1 [...]"

      opts.on('-h', '--help', 'Display this screen' ) do
        puts opts
        exit
      end
    end

    begin
      opts.parse!

      puts self.clean($stdin.read)
    rescue OptionParser::InvalidOption => e
      warn e
      puts opts
    end
  end

  def self.clean(str)
    str.gsub(/\s+$/, '') << "\n"
  end
end
