require 'rubygems'
require 'git'


class GitPlayer
  
  attr_accessor :start_commit, :end_commit
  
  # GitPlayer.new(:start_commit => "bafs1234", :end_commit => "67dfjcv0")
  def initialize(attrs={})
    attrs.each_pair do |k,v|
      instance_variable_set("@#{k}", v)
    end
  end
  
end