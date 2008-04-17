require File.expand_path("spec_helper", File.dirname(__FILE__))

require 'digest/sha1'

describe Story, "extended by acts_as_searchable_enhance" do
  before(:all) do
    logger = Object.new
    def logger.debug(*args)
      # do nothing
    end
    Story.logger = logger
  end

  it "should respond_to :fulltext_search" do
    Story.should respond_to(:fulltext_search)
  end

  it "should have callbak :update_index" do
    Story.after_update.should include(:update_index)
  end

  it "should have callbak :add_to_index" do
    Story.after_create.should include(:add_to_index)
  end

  it "attributes_to_store should include @cdate" do
    Story.attributes_to_store.should include("cdate")
  end

  it "attributes_to_store['@mdate'] should == updated_at" do
    Story.attributes_to_store["mdate"].should  == "updated_at"
  end

  describe "separate node by model classname" do
    before(:all) do
      OtherKlass = Class.new(ActiveRecord::Base)
      OtherKlass.class_eval do
        acts_as_searchable :ignore_timestamp => true
      end
    end

    it "OtherKlass.estraier_node.should == 'aas_e_test_other_klasses'" do
      OtherKlass.estraier_node.should == 'aas_e_test_other_klasses'
    end

    it "estraier_node should == 'aas_e_test_stories'" do
      Story.estraier_node.should == 'aas_e_test_stories'
    end

    it "condition should not include type_base attribute" do
      Story.new_estraier_condition.attrs.should_not include("type STREQ #{Story.to_s}")
    end
  end

  describe "extract matched_ids from fulltext_search" do
    fixtures :stories
    before do
      @story_ids = Story.find(:all, :limit=>2).map(&:id)

      @mock_results = @story_ids.map{|id| mock("ResultDocument_#{id}", :attr => id) }
      nres = EstraierPure::NodeResult.new(@mock_results, {})
      Story.estraier_connection.stub!(:search).and_return(nres)
    end

    it "matched_ids should == [story_ids]" do
      Story.matched_ids("hoge").should == @story_ids
    end

    it "matched_ids should call estraier_connection#search()" do
      Story.estraier_connection.should_receive(:search)
      Story.matched_ids("hoge")
    end
  end

  describe "matched_ids => [:id] and find_option=>{:condition => 'id = :id'}" do
    fixtures :stories
    before do
      stories = Story.find(:all)
      @story = stories.first
      Story.stub!(:matched_ids).and_return( stories.map(&:id) )
    end

    def fulltext_search
      finder_opt = {:conditions => ["id = ?", @story.id]}
      Story.fulltext_search("hoge", :find => finder_opt)
    end

    it "fulltext_search should not raise error AR::RecordNotFound" do
      lambda{ fulltext_search }.should_not raise_error(ActiveRecord::RecordNotFound)
    end

    it "fulltext_search should == [@story]" do
      fulltext_search.should == [@story]
    end

    it "fulltext_search should call matched_ids" do
      Story.should_receive(:matched_ids).and_return([@story.id])
      fulltext_search
    end
  end

  describe "new intefrface Model.find_fulltext(query, options={})" do
    fixtures :stories
    
    before do
      Story.stub!(:matched_ids).and_return([102, 101, 110])
    end

    it "find_fulltext('hoge', :order=>'updated_at DESC') should == [stories(:sanshiro), stories(:neko)]" do
      Story.find_fulltext('hoge', :order=>"updated_at DESC").should == Story.find([102,101])
    end
  end

  describe "search using real HyperEstraier (End-to-End test)" do
    fixtures :stories
    before(:all) do
      #Story.delete_all
      Story.create!(:title=>"むかしむかし", :body=>"あるところにおじいさんとおばあさんが")
      Story.reindex!
      sleep 5
    end

    after(:all) do
      Story.clear_index!
    end

    before(:each) do
      @story = Story.find_by_title("むかしむかし")
    end

    it "should searchable" do
      Story.fulltext_search('むかしむかし').should == [@story]
    end

    # asserts HE raw_match order
    it "should searchable with '記憶', orderd should work" do
      Story.matched_ids('記憶', :order => "@mdate NUMA").should == [102, 101]
      Story.matched_ids('記憶', :order => "@mdate NUMD").should == [101, 102]
    end

    it "should have(3).estraier_index" do
      Story.should have(3).estraier_index
    end
  end
end

__END__
class ActsAsSearchableTest < Test::Unit::TestCase
  fixtures :articles, :comments, :notifications
  @@indexed = false

  def test_defaults
    assert_equal 'test',      Comment.estraier_node

    assert_equal 'localhost', Comment.estraier_host
    assert_equal 1978,        Comment.estraier_port
    assert_equal 'admin',     Comment.estraier_user
    assert_equal 'admin',     Comment.estraier_password
    assert_equal [ :body ],   Comment.searchable_fields
  end
  
  def test_hooks_presence
    assert Article.after_update.include?(:update_index)
    assert Article.after_create.include?(:add_to_index)
    assert Article.after_destroy.include?(:remove_from_index)    
  end
  
  def test_connection
    assert_kind_of EstraierPure::Node, Article.estraier_connection
  end
  
  def test_reindex!
    Article.clear_index!
    @@indexed = false
    assert_equal 0, Article.estraier_index.size
    reindex!
    assert_equal Article.count, Article.estraier_index.size
  end
  
  def test_clear_index!
    Article.clear_index!
    assert_equal 0, Article.estraier_index.size
    @@indexed = false
  end
  
  def test_after_update_hook
    articles(:first).update_attribute :body, "updated via tests"
    doc = articles(:first).estraier_doc
    assert_equal articles(:first).id.to_s,    doc.attr('db_id')
    assert_equal articles(:first).class.to_s, doc.attr('type')
    assert Article.estraier_connection.get_doc(doc.attr('@id')).texts.include?(articles(:first).body)
  end
  
  def test_after_create_hook
    a = Article.create :title => "title created via tests", :body => "body created via tests", :tags => "ruby weblog"
    doc = a.estraier_doc
    assert_equal a.id.to_s,    doc.attr('db_id')
    assert_equal a.class.to_s, doc.attr('type')
    assert_equal a.tags,       doc.attr('custom_attribute')
    assert_equal a.title,      doc.attr('@title')
    assert_equal Article.estraier_connection.get_doc(doc.attr('@id')).texts, [ a.title, a.body ]
  end
  
  def test_after_destroy_hook
    articles(:first).destroy
    assert articles(:first).estraier_doc.blank?
  end
  
  def test_fulltext_search
    reindex!
    assert_equal 1, Article.fulltext_search('mauris', :count => true)
  end
  
  def test_fulltext_search_with_wildcard
    reindex!
    assert_equal 1, Article.fulltext_search('mau*').size
  end

  def test_fulltext_search_with_attributes
    reindex!
    assert_equal [articles(:third), articles(:second)], Article.fulltext_search('', :attributes => "custom_attribute STRINC rails")
  end

  def test_fulltext_search_with_attributes_array
    reindex!
    assert_equal [articles(:third)], Article.fulltext_search('', :attributes => ["custom_attribute STRINC rails", "@title STRBW lorem"])
  end

  def test_fulltext_search_with_number_attribute
    reindex!
    assert_equal [articles(:first)], Article.fulltext_search('', :attributes => "comments_count NUMGE 1")
  end

  def test_fulltext_search_with_date_attribute
    reindex!
    assert_equal [articles(:third)], Article.fulltext_search('ipsum', :attributes => "@cdate NUMLE #{1.year.from_now.xmlschema}")
  end

  def test_fulltext_search_with_ordering
    reindex!
    assert_equal %w(1 2 3), Article.fulltext_search('', :order => 'db_id NUMA', :raw_matches => true).collect { |d| d.attr('db_id') }
    assert_equal %w(3 2 1), Article.fulltext_search('', :order => 'db_id NUMD', :raw_matches => true).collect { |d| d.attr('db_id') }
  end

  def test_fulltext_search_with_pagination
    reindex!
    assert_equal %w(1 2), Article.fulltext_search('', :order => 'db_id NUMA', :raw_matches => true, :limit => 2).collect { |d| d.attr('db_id') }
    assert_equal %w(3 2), Article.fulltext_search('', :order => 'db_id NUMD', :raw_matches => true, :limit => 2).collect { |d| d.attr('db_id') }
    assert_equal %w(2 3), Article.fulltext_search('', :order => 'db_id NUMA', :raw_matches => true, :limit => 2, :offset => 1).collect { |d| d.attr('db_id') }
    assert_equal %w(2 1), Article.fulltext_search('', :order => 'db_id NUMD', :raw_matches => true, :limit => 2, :offset => 1).collect { |d| d.attr('db_id') }
  end

  def test_fulltext_search_with_no_results
    reindex!
    result = Article.fulltext_search('i do not exist')
    assert_kind_of Array, result
    assert_equal 0, result.size
  end
  
  def test_fulltext_search_with_find
    reindex!
    assert_equal %w(1 3), Article.fulltext_search('', :find => { :order => "title ASC" }).collect { |a| a.id.to_s }.first(2)
    assert_equal %w(2 3), Article.fulltext_search('', :find => { :order => "title DESC"}).collect { |a| a.id.to_s }.first(2)
  end
  
  def test_fulltext_with_invalid_find_parameters
    reindex!
    assert_nothing_raised { Article.fulltext_search('', :limit => 3, :find => { :limit => 1 } ) }
  end

  def test_act_if_changed
    assert ! comments(:first).changed?
    comments(:first).article_id = 123
    assert comments(:first).changed?
  end
  
  def test_act_changed_attributes
    assert ! articles(:first).changed?
    articles(:first).tags = "123" # Covers :attributes
    assert articles(:first).changed?
    
    assert ! articles(:second).changed?
    articles(:second).body = "123" # Covers :searchable_fields
    assert articles(:second).changed?
    
    assert articles(:second).save
    assert ! articles(:second).changed?
  end

  def test_fulltext_with_count
    reindex!
    assert_equal 3, Article.fulltext_search('', :count => true)
  end
  
  def test_type_base_condition
    assert ! Article.new_estraier_condition.attrs.include?("type_base STREQ #{Article.to_s}")
    assert CommentNotification.new_estraier_condition.attrs.include?("type_base STREQ #{Notification.to_s}")
  end
  
  def test_fulltext_search_with_sti
    reindex!
    assert_equal 2, Notification.fulltext_search('', :count => true)
    assert_equal 1, CommentNotification.fulltext_search('', :count => true)
    assert notifications(:second).estraier_doc.attr_names.include?("type_base")
  end

  protected
  
  def reindex!
    unless @@indexed
      Article.reindex!
      Notification.reindex!
      @@indexed = true
      sleep 10
    end
  end
end
