require 'stringio'
require 'uwsgidsl'



module UWSGI

  module_function
  def post_fork_hook()
    puts "fork() called"
  end
end

puts UWSGI.respond_to?('post_fork_hook')

signal 17,'mule5' do |signum|
end

puts UWSGI::OPT.inspect


timer 2 do |signum|
  puts "ciao sono un dsl ruby: #{signum} #{UWSGI::OPT.inspect}"
end

timer 1,'mule1' do |signum|
  puts "1 second elapsed (signum #{signum})"
end

filemon '/tmp' do |signum|
  puts "/tmp has been modified"
end

cron 5,-1,-1,-1,-1 do |signum|
  puts "cron ready #{signum}"
end

cron 58,-1,-1,-1,-1 do |signum|
  puts "cron ready #{signum}"
end

begin
  foo_func
rescue
end

run lambda { |env| 
  puts env.inspect
  UWSGI.signal(17)
  [200, {'Content-Type'=>'text/plain'}, StringIO.new("Hello World!\n")] 
}
