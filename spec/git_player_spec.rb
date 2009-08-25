require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GitPlayer do
  before(:each) do
    @repo_dir = "/Users/mark/Development/git_player_test"
    @gp = GitPlayer.new(:repo_dir => @repo_dir,
                          :start_commit => "bafs1234", 
                          :end_commit => "67dfjcv0")
  end
  
  describe "initialize" do
    before(:each) do
      @gp = GitPlayer.new(:repo_dir => @repo_dir,
                            :start_commit => "bafs1234", 
                            :end_commit => "67dfjcv0")
    end

    it "should set the repo dir from initalization params" do
      @gp.repo_dir.should == @repo_dir
    end    
    it "should set the start commit from initalization params" do
      @gp.start_commit.should == "bafs1234"
    end
    it "should set the end commit from initalization params" do
      @gp.end_commit.should == "67dfjcv0"
    end
  end # initialize
  
  describe "attributes" do
    it "should have a start_commit" do
      @gp.should respond_to("start_commit")
    end
    it "should have an end_commit" do
      @gp.should respond_to("end_commit")      
    end
    it "should have a repo dir" do
      @gp.should respond_to("repo_dir")
    end
  end
  
  describe "play" do
    before(:each) do
      @mock_repo = mock(Grit::Repo, :commits => [])
    end
    
    it "should fetch the repo" do
      Grit::Repo.should_receive(:new).with(@repo_dir).and_return(@mock_repo)
      
      @gp.play
    end
    
    it "should get the commits" do
      Grit::Repo.stub!(:new).and_return(@mock_repo)
      
      @mock_repo.should_receive(:commits)
      @gp.play
    end
    
    it "should return an array of commit objects" do
      @gp_play = @gp.play
      @gp_play.should be_a(Array)
      @gp_play.first.should be_a(Grit::Commit)
      
    end
  end # playback
  
end # GitPlayer