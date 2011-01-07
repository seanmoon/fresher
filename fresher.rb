unless ARGV[0]
  puts "Provide a path to watch: ruby fresher.rb /Users/you/Sites"
  puts "  also edit this script to run the desired command"
  exit 1
end

class FSEventRefresh
  def initialize
    @changed = false
  end

  def changed?
    if @changed
      @changed = false
      true
    else
      false
    end
  end

  def watch(dir)
    `./bin/fsevent_watch #{dir}`
    @changed = true
    self.watch(dir)
  end
end

f = FSEventRefresh.new
Thread.new do
  f.watch(ARGV[0])
end

f2 = FSEventRefresh.new
if ARGV[1]
  Thread.new do
    f2.watch(ARGV[1])
  end
end

loop do
  if f.changed? || f2.changed?
    IO.popen("clear; echo YOUR COMMAND HERE") do |io|
      io.each_line do |line|
        puts line
      end
    end
  end
  Kernel.sleep 0.1
end
