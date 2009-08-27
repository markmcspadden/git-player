Shoes.setup do
  gem 'grit'
end

require 'grit'


require '/Users/mark/Development/git-player/lib/git_player'

gp = GitPlayer.new(:repo_dir => "/Users/mark/Development/git_player_test")
commits = gp.play
commits = commits.reverse

def code_line(contents="")
  para contents, :margin => 0
end

Shoes.app do
  commit = commits[2]
  
  flow do
    stack :width => "100%" do
      banner "Hello."
    end # stack
    
    stack :width => "100%" do
      @date = para commit.date
      @author = para commit.author.name
      @message = para commit.message
      # button("Update") do
      #   @line2.replace "Pardon?"
      # end
    end # stack
    
    stack :width => "100%" do
      @lines = para "" #commit.tree.contents.first.data
    end # stack
    
    stack :width => "100%" do
      commit.diffs.each do |diff|
        @lines.replace diff.a_blob.data
        
        diff_lines = diff.diff.split("\n")
        
        chunks = diff_lines[2].gsub(/\s?@*\s?/, "")
        matches = chunks.match(/(.*?)(\d*),(\d*)(.*?)(\d*),(\d*)/)
        
        a_action = matches[1]
        a_start = matches[2].to_i
        a_chunk_size = matches[3].to_i
        
        b_action = matches[4]
        b_start = matches[5].to_i
        b_chunk_size = matches[6].to_i
        
        a_lines = diff.a_blob.data.split("\n")
        
        (a_start..a_start+a_chunk_size).to_a.each do |i|
          a_lines[i-1] = em(a_lines[i-1].to_s)
        end
        
        button("#{diff.a_path}_before") do        
          @lines.replace diff.a_blob.data
        end
        button("#{diff.b_path}_after") do        
          @lines.replace diff.b_blob.data
        end
        button("#{diff.b_path}_diff") do
          @lines.replace diff.diff
        end
        button("step1") do          
          @lines.replace a_lines
        end        
      end
      
    end # stack
    
  end # flow
end # app