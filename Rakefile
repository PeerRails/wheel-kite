require "./server/app"

desc "Help Command"
task :help do
  puts "Help Commands:\nrake up\t - start server\nrake down\t - stop server\nrake routse\t - show routes"
end

desc "API Routes"
task :routes do
  App::API.routes.each do |api|
    method = api.request_method.ljust(10)
    path = api.path
    puts "     #{method} #{path}"
  end
end


desc "Run Server"
task :up do
  port = ENV["RACK_PORT"] || "9000"
  host = ENV["RACK_HOST"] || "0.0.0.0"
  Rack::Server.start :app => App::API, :Host => host, :Port => port, :daemonize => true, :pid => "#{Dir.pwd}/grape.pid"
end

desc "Stop Server"
task :stop do
  Process.kill(15, File.read("#{Dir.pwd}/grape.pid").to_i)
end

desc "Restar Server"
task :restart do
  Rake::Task['stop'].invoke if File.exists? "#{Dir.pwd}/grape.pid"
  sleep(1)
  Rake::Task['up'].invoke
end

task default: [:help]
