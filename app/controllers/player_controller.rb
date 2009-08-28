class PlayerController < ApplicationController
  
  def play
    @gp = GitPlayer.new(:repo_dir => "/Users/mark/Development/git_player_test")
    @commit = @gp.commits(:order => "date ASC")[2]
  end
  
end