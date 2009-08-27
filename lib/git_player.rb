require 'rubygems'
require 'grit'

class GitPlayer
  
  attr_accessor :repo_dir, :start_commit, :end_commit
  
  # GitPlayer.new(:repo_dir => "/Users/mark/Development/git_player_test",
  #               :start_commit => "bafs1234", 
  #               :end_commit => "67dfjcv0")
  def initialize(attrs={})
    attrs.each_pair do |k,v|
      instance_variable_set("@#{k}", v)
    end
  end
  
  def repo
    @repo ||= Grit::Repo.new(repo_dir)
  end
  
  def play
    commits = repo.commits
    
    puts repo
    puts commits
    commits
  end
  
end