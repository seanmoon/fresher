require 'rubygems'
require 'sinatra'
require 'sinatra/jsonp'

class FSEventRefresh 
  attr_reader :changed

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
    `./bin/fsevent_watch /Users/seanm/Sites`
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
