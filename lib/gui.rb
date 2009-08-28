Shoes.setup do
  gem 'grit'
end

require 'grit'


require '/Users/mark/Development/git-player/lib/git_player'

gp = GitPlayer.new(:repo_dir => "/Users/mark/Development/git_player_test")
commits = gp.play
commits = commits.reverse

Shoes.app do
  def code_line(contents="")
    para code(contents), :margin => 0
  end
  
  def do_animation(diff, diff_lines)
    @last_line_changed = 0

    @go = animate() do
      diff_lines[2..-1].each_with_index do |line, id|
    
        if line =~ /^\-/
          line.slice!(0)
          diff.a_blob.data.split("\n").each_with_index do |a_line, idx|
            if a_line == line
              @last_line_changed = idx
          
              old_line = instance_variable_get("@a_#{idx}")
      
              old_line.replace(strong(a_line))
              old_line.remove        
            end
          end
        end
                
        if line =~ /^\+/
          line.slice!(0)
      
          real_last_line_changed = @last_line_changed == 0 ? id : @last_line_changed
      
          insert_after_stack = instance_variable_get("@a_stack_#{real_last_line_changed}")

          insert_after_stack.append do 
            code_line(line)
          end
          
          @last_line_changed = id
        end
    
      end # diff_lines
    end # animate
  end # do_animation
  
  def load_commit(commit)
    @date.replace commit.date
    @author.replace commit.author.name
    @message.replace commit.message
    
    commit.diffs.each_with_index do |diff, diff_idx|                
      diff_lines = diff.diff.split("\n")
      
      @file_name.replace diff.a_path
      
      # chunks = diff_lines[2].gsub(/\s?@*\s?/, "")
      # matches = chunks.match(/(.*?)(\d*),(\d*)(.*?)(\d*),(\d*)/)
      # 
      # a_action = matches[1]
      # a_start = matches[2].to_i
      # a_chunk_size = matches[3].to_i
      # 
      # b_action = matches[4]
      # b_start = matches[5].to_i
      # b_chunk_size = matches[6].to_i
      # 
      # a_lines = diff.a_blob.data.split("\n")
      # 
      # (a_start..a_start+a_chunk_size).to_a.each do |i|
      #   a_lines[i-1] = em(a_lines[i-1].to_s)
      # end

      @working_file.clear
         
      # Actually add a stack for each code line
      diff.a_blob.data.split("\n").each_with_index do |line, idx|        
        instance_variable_set("@a_stack_#{idx}", @working_file.append do
          stack do
            instance_variable_set("@a_#{idx}", code_line(line))
          end
        end)
      end

      @working_diffs.clear
      
      @working_diffs.append do
        button("Commit #{commit.id} - Diff #{diff_idx}") do
          do_animation(diff, diff_lines)
        end
      end
              
    end # commit    
  end # do_commit
  
  flow do
    stack :width => "100%" do
      banner "Git Player"
    end # stack
    
    stack :width => "100%" do
      @date = para ""
      @author = para ""
      @message = para ""
      @file_name = para ""
    end # stack
    
    @working_file = stack do
      
    end
    
    @working_diffs = stack do
      
    end
    
    stack :width => "100%", :margin => "10px" do
      commits.each do |commit|
        button("Load Commit #{commit.id}") do
          load_commit(commit)
        end
      end
      
    end # stack
    
  end # flow
end # app