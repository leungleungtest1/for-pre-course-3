require 'spec_helper'

describe Video do 
  it "save itself" do
    video = Video.new(title: "cook dinner", description: "I love cokking!")
    video.save
    Video.last.title.should == "cook dinner"
  end
end