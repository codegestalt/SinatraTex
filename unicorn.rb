# set path to app that will be used to configure unicorn, 
# note the trailing slash in this example
@dir = "/var/www/tex2png/"

worker_processes 1
working_directory @dir

system("export PATH=/usr/local/texlive/2013/bin/x86_64-linux:$PATH")
puts system("which latex")

timeout 30

# Specify path to socket unicorn listens to, 
# we will use this in our nginx.conf later
listen "#{@dir}tmp/sockets/unicorn.sock", :backlog => 64

# Set process id path
pid "#{@dir}tmp/pids/unicorn.pid"

# Set log file paths
stderr_path "#{@dir}log/unicorn.stderr.log"
stdout_path "#{@dir}log/unicorn.stdout.log"
