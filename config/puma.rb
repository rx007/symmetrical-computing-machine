case @options[:environment]
when /production/
    puts "config puma for production"
    stdout_redirect 'log/app.log', 'log/app.log', true

    daemonize true

    bind 'unix://run/puma.sock'

    # min and max number of threads to use to answer
    threads 0, 4

    # start 2 process
    workers 1
    preload_app!

when /development/
    puts "config puma for development"

    daemonize false

    threads 0, 1
    workers 1

    bind 'tcp://0.0.0.0:9991'
end

# Load “path” as a rackup file.
rackup 'config.ru'

pidfile 'run/puma.pid'
state_path 'run/puma.state'

# disable logging from puma. app will take log
quiet
