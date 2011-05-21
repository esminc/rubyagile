require 'spec_helper'

describe Image do
  before(:each) do
    @image = Image.new
    @image.stub(:id) { 5 }
    @image.should_receive(:id)
    @image.filename = "designpatterns.img.jpg"
  end

  it 'file path should == /images/#{id}.#{extension}' do
    @image.filepath.should == "/images/5.jpg"
  end
end
