require 'spec_helper'

describe "/nakanohitos/show" do
  before :each do
    feed = KarekiFeed.make_unsaved
    stub(feed).before_save
    @entry = KarekiEntry.make(:feed => feed, :published_at => DateTime.now, :confirmation => "confirmed")
    @article = Article.make(:publishing => true)
    user = User.make(:articles => [@article], :feeds => [feed])
    user.save!
    assigns[:nakanohito] = user
    render
  end

  it "should have links of recent articles" do
    response.should have_tag("ul#articles") do |ul|
      ul.should have_tag("li") do |li|
        li.should have_tag("a[href='#{article_path(@article)}']")
        li.should have_tag("a", @article.title)
      end
    end
  end

  it "should have links of recent entries" do
    response.should have_tag("ul#entries") do |ul|
      ul.should have_tag("li") do |li|
        li.should have_tag("a[href='#{@entry.link}']")
        li.should have_tag("a", @entry.title)
      end
    end
  end
end
