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

  describe "tokenize_query" do
    it "tokenize_query('ruby vim').should == 'ruby AND vim'" do
      Story.tokenize_query('ruby vim').should == 'ruby AND vim'
    end

    it "tokenize_query('\"ruby on rails\" vim').should == 'ruby on rails AND vim'" do
      Story.tokenize_query('"ruby on rails" vim').should == 'ruby on rails AND vim'
    end

    it "tokenize_query('\"ruby on rails\"　vim').should == 'ruby on rails AND vim'" do
      Story.tokenize_query('"ruby on rails"　vim').should == 'ruby on rails AND vim'
    end
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

  describe "partial updating" do
    fixtures :stories
    before do
      @story = Story.find(:first)
      @story.stub!(:record_timestamps).and_return(false)
    end

    it "should update fulltext index when update 'title'" do
      Story.estraier_connection.should_receive(:put_doc).once
      @story.title = "new title"
      @story.save
    end

    it "should update fulltext index when update 'popularity'" do
      Story.estraier_connection.should_not_receive(:put_doc)
      @story.popularity = 20
      @story.save
    end
  end
end

