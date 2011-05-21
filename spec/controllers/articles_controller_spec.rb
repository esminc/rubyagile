require 'spec_helper'

describe ArticlesController do
  before(:each) do
    login_as(:alice)
  end

  describe "handling GET /articles" do
    fixtures :articles
    before(:each) do
      get :index
    end
    it { response.should be_success }
    it { response.should render_template('index') }
    it "should assign the found articles for the view" do
      assigns[:articles].should have(1).entries
    end

    it { assigns[:articles].first.publishing.should be_true }
  end

  describe "handling GET /articles/1" do
    fixtures :articles

    context "happy case" do
      before(:each) do
        get :show, :id => articles(:hikidoc_sample)
      end
      subject{ response }

      it { should be_success }
      it { should render_template('show') }
      it "should assign the found article for the view" do
        assigns[:article].should == articles(:hikidoc_sample)
      end
    end

    context "(sad) accessed to draft without logging in" do
      before do
        not_logged_in
      end

      it do
        expect {
          get :show, :id => articles(:draft)
        }.to raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "handling GET /articles/new" do
    before(:each) do
      @article = Article.new
      @article.should_not_receive(:save)
      Article.stub(:new) { @article }
      get :new
    end

    it { @article.user.should == users(:alice) }
    it { response.should be_success }
    it { response.should render_template('new') }

    it "should assign the new article for the view" do
      assigns[:article].should equal(@article)
    end
  end

  describe "handling GET /articles/1/edit" do
    before(:each) do
      @article = Article.new
      Article.stub(:find) { @article }
      get :edit, :id => "1"
    end

    it { response.should be_success }
    it { response.should render_template('edit') }
    it "should assign the found Article for the view" do
      assigns[:article].should equal(@article)
    end
  end

  describe "handling POST /articles" do
    before(:each) do
      @article = mock_model(Article, :to_param => "1")
      Article.stub(:new) { @article }
    end

    describe "with successful save w/o publishing" do
      before do
        Article.stub(:new, anything) { @article }
        @article.stub(:save) { true }
        @article.should_receive(:save)
        post :create, :article => {:publishing => 0}
      end

      it { response.should redirect_to(article_url("1")) }

      it { @article.publishing.should be_false }
    end

    describe "with successful save w/o direct_post" do
      before do
        Article.stub(:new, anything) { @article }
        @article.stub(:save) { true }
        @article.should_receive(:save)
        post :create, :article => {:publishing => 1}
      end

      it { response.should redirect_to(article_url("1")) }
    end


    describe "with failed save" do
      before do
        @article.stub(:save) { false }
        @article.should_receive(:save)
        post :create, :article => { :title => 'example', :body => 'hello' }
      end

      it { response.should render_template('new') }
    end

    describe "with preview" do
      before do
        @article.should_not_receive(:save)
        post :create, :article => { :title => 'example', :body => 'hello' }, :preview => 'Preview'
      end
      it { response.should render_template('preview') }
    end

  end

  describe "handling PUT /articles/1" do
    before(:each) do
      @article = mock_model(Article, :to_param => "1")
      Article.stub(:find) { @article }
    end

    describe "with successful update" do
      before do
        Article.stub(:find, "1") { @article }
        Article.should_receive(:find).with("1")
        @article.stub(:update_attributes) { true }
        put :update, :id => "1", :article => { :title => 'example', :body => 'hello' }
      end

      it { assigns(:article).should equal(@article) }
      it { response.should redirect_to(article_url("1")) }
    end

    describe "with failed update" do
      before do
        @article.stub(:update_attributes) { false }
        put :update, :id => "1", :article => { :title => 'example', :body => 'hello' }
      end

      it { response.should render_template('edit') }
    end

    describe "with preview" do
      before do
        @article.should_receive(:update_attribute)
        put :update, :article => { :title => 'example', :body => 'hello.' }, :preview => 'Preview'
      end

      it { @article.title.should == 'example' }
      it { @article.body.should == 'hello.' }
      it { response.should render_template('preview') }
    end
  end

  describe "handling DELETE /articles/1" do
    before(:each) do
      @article = mock_model(Article, :destroy => true)
      Article.stub(:find, "1") { @article }
      Article.should_receive(:find).with("1")
      @article.should_receive(:destroy)
      delete :destroy, :id => "1"
    end

    it { response.should redirect_to(articles_url) }
  end

  describe "handling Atomfeed" do
    before do
      @articles = [mock_model(Article, :to_param => "1")]
      Article.stub(:publishing) { @articles }
      @articles.stub(:newer_first) { @articles }
      get "feed", :type => 'xml'
    end

    it { response.should render_template("feed") }
  end
end
