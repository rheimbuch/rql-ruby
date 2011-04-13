require 'spec_helper'


describe Rql::Parser do
  it "should load the js source for the parser" do
    js = nil
    lambda{ js = Rql::Parser.source }.should_not raise_error
    js.should_not be_nil
    js.should_not be_empty
  end

  it "should compile the javascript parser" do
    runtime = mock("runtime")
    runtime.should_receive(:compile).once.with(Rql::Parser.source)
    
    parser = Rql::Parser.new(runtime)
  end

  describe "query parsing" do
    before(:each) do
      @parser = Rql::Parser.new
    end

    it "should have a parseQuery method" do
      @parser.should respond_to(:parseQuery)
    end
    
    it "should parse the empty string" do
      result = nil
      lambda{result = @parser.parseQuery("")}.should_not raise_error
      result.should_not be_nil
      result.should be_a_kind_of(Hash)
      result["name"].should == "and"
      result["args"].should be_a_kind_of(Array)
      result["args"].should be_empty
    end
    
  end
end


