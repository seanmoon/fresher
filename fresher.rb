require 'rubygems'
require 'sinatra'
require 'sinatra/jsonp'

unless ARGV[0]
  puts "Provide a path to watch: ruby fresher.rb /Users/you/Sites"
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

  def watch
    `./bin/fsevent_watch #{ARGV[0]}`
    @changed = true
    puts "Change detected"
    self.watch
  end
end

f = FSEventRefresh.new
Thread.new do
  f.watch
end

get '/status' do
  data = ["#{f.changed?}"];
  JSONP data
end
