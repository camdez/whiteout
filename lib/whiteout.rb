require "whiteout/version"

module Whiteout
  def self.clean(str)
    out = ""
    str.each_line do |line|
      out << line.gsub(/\s+$/, '') << "\n"
    end
    out
  end
end
