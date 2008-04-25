require File.dirname(__FILE__) + '/../spec_helper'

describe Image do
  before(:each) do
    @image = Image.new
    @image.should_receive(:id).and_return(5)
    @image.filename = "designpatterns.img.jpg"
  end

  it 'file path should == /images/#{id}.#{extension}' do
    @image.filepath.should == "/images/5.jpg"
  end
end
