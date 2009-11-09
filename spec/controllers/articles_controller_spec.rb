require File.dirname(__FILE__) + '/../spec_helper'

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
      before(:each) do
        logout
      end

      it do
        expect{ get :show, :id => articles(:draft) }.should \
          raise_error ActiveRecord::RecordNotFound
      end
    end
  end

  describe "handling GET /articles/new" do
    before(:each) do
      @article = mock_model(Article)
      Article.should_receive(:new).and_return(@article)
      @article.should_receive(:user=).with(users(:alice))
      get :new
    end

    it { response.should be_success }
    it { response.should render_template('new') }
    it { @article.should_not_receive(:save) }

    it "should assign the new article for the view" do
      assigns[:article].should equal(@article)
    end
  end

  describe "handling GET /articles/1/edit" do
    before(:each) do
      @article = mock_model(Article)
      Article.should_receive(:find).and_return(@article)
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
      Article.stub!(:new).and_return(@article)
    end

    describe "with successful save w/o publishing" do
      before do
        Article.should_receive(:new).with(any_args).and_return(@article)
        @article.should_receive(:save).and_return(true)
        post :create, :article => {:publishing => 0}
      end

      it { response.should redirect_to(article_url("1")) }

      it { @article.should_not_receive(:publishing=) }
    end

    describe "with successful save w/o direct_post" do
      before do
        Article.should_receive(:new).with(any_args).and_return(@article)
        @article.should_receive(:save).and_return(true)
        post :create, :article => {:publishing => 1}
      end

      it { response.should redirect_to(article_url("1")) }
    end


    describe "with failed save" do
      before do
        @article.should_receive(:save).and_return(false)
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
      Article.stub!(:find).and_return(@article)
    end

    describe "with successful update" do
      before do
        Article.should_receive(:find).with("1").and_return(@article)
        @article.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1", :article => { :title => 'example', :body => 'hello' }
      end

      it { assigns(:article).should equal(@article) }
      it { response.should redirect_to(article_url("1")) }
    end

    describe "with failed update" do
      before do
        @article.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1", :article => { :title => 'example', :body => 'hello' }
      end

      it { response.should render_template('edit') }
    end

    describe "with preview" do
      before do
        @article.stub!(:title=)
        @article.stub!(:body=)
        @article.should_not_receive(:update_attributes)
        put :update, :article => { :title => 'example', :body => 'hello.' }, :preview => 'Preview'
      end

      it { response.should render_template('preview') }
    end
  end

  describe "handling DELETE /articles/1" do
    before(:each) do
      @article = mock_model(Article, :destroy => true)
      Article.should_receive(:find).with("1").and_return(@article)
      @article.should_receive(:destroy)
      delete :destroy, :id => "1"
    end

    it { response.should redirect_to(articles_url) }
  end

  describe "handling POST /articles/comment/1" do
    def do_comment(params)
      post :comment, :comment => params
    end

    describe "with valid comment" do
      before do
        @article = mock_model(Article, :to_parm => "1")
        @comment = mock_model(Comment)
        @comment.should_receive(:save).and_return(true)
        Article.stub!(:find).and_return(@article)
        Comment.should_receive(:parse_params).and_return(@comment)
        do_comment({:author => 'alice', :body => 'some body'})
      end

      it { response.should redirect_to(:controller => 'articles', :action => 'show', :id => @article.id) }
    end
  end

  describe "handling Atomfeed" do
    before do
      @articles = [mock_model(Article, :to_param => "1")]
      Article.should_receive(:publishing).and_return(@articles)
      @articles.should_receive(:newer_first).and_return(@articles)
      get "feed", :type => 'xml'
    end

    it { response.should render_template("feed") }
  end
end
