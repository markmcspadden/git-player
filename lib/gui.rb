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
    para contents, :margin => 0
  end
  
  def do_animation(diff, diff_lines)
    @last_line_changed = 0

    @go = animate() do
      diff_lines[2..-1].each do |line|
    
        if line =~ /^\-/
          line.slice!(0)
          diff.a_blob.data.split("\n").each_with_index do |a_line, idx|
            if a_line == line
              @last_line_changed = idx
          
              old_line = instance_variable_get("@a_#{idx}")
      
              alert("here")
              
              bold = false
              every(1) do
                if bold
                  bold = false
                  old_line.remove
                else
                  old_line.replace(strong(a_line))
                  bold = true
                end
            
                puts "here"
              #alert("after here")
              end
              
              sleep 5
              
            end
          end
        end
                
        if line =~ /^\+/
          line.slice!(0)
      
          insert_after_stack = instance_variable_get("@a_stack_#{@last_line_changed}")

          insert_after_stack.append do 
            code_line(line)
          end
        end
    
      end # diff_lines
    end # animate
  end

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
        
        diff.a_blob.data.split("\n").each_with_index do |line, idx|
          instance_variable_set("@a_stack_#{idx}", stack do
            instance_variable_set("@a_#{idx}", code_line(line))
          end)
        end
        
        diff.b_blob.data.split("\n").each_with_index do |line, idx|
          @b_stack = stack :hidden => true do
            instance_variable_set("@b_#{idx}", code_line(line))
          end
        end
        
        button("show b and hide a") do
          @a_stack.hidden = true
          @b_stack.hidden = false
        end
        

        
        button("diff step 1") do
          do_animation(diff, diff_lines)
        end
        
        button("do this") do        
          @animation = animate() do          
            @lines.replace "HI÷"
            @animation.stop
          end
        end
                
      end
      
    end # stack
    
  end # flow
end # app