require "bundler/gem_tasks"

desc "Build manual"
task :build_man do
  sh "ronn -r5 --manual='Whiteout Manual' man/*.ronn"
end

desc "Show manual"
task :man => :build_man do
  exec "man man/whiteout.1"
end
