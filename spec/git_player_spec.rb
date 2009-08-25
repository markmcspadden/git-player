require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

describe GitPlayer do
  before(:each) do
    @gp = GitPlayer.new
  end
  
  describe "initialize" do
    before(:each) do
      @gp = GitPlayer.new(:start_commit => "bafs1234", :end_commit => "67dfjcv0")
    end
    
    it "should set the start commit from initalization params" do
      @gp.start_commit.should == "bafs1234"
    end
    it "should set the start commit from initalization params" do
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
  end
  
  describe "play" do
    it "should description" do
      
    end
  end # playback
  
end # GitPlayer