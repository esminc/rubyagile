require File.dirname(__FILE__) + '/../spec_helper'

describe ArticlesController do
  before(:each) do
    login_as(:valid)
  end

  describe "handling GET /articles" do

    before(:each) do
      @article = mock_model(Article, :null_object => true)
      Article.stub!(:find).and_return([@article])
    end

    def do_get
      get :index
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render index template" do
      do_get
      response.should render_template('index')
    end

    it "should find all articles" do
      Article.should_receive(:find).with(:all, :order => "created_at DESC").and_return([@article])
      do_get
    end

    it "should assign the found articles for the view" do
      do_get
      assigns[:articles].should == [@article]
    end
  end

  describe "handling GET /articles/1" do

    before(:each) do
      @article = mock_model(Article)
      Article.stub!(:find).and_return(@article)
    end

    def do_get
      get :show, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render show template" do
      do_get
      response.should render_template('show')
    end

    it "should find the article requested" do
      Article.should_receive(:find).with("1").and_return(@article)
      do_get
    end

    it "should assign the found article for the view" do
      do_get
      assigns[:article].should equal(@article)
    end
  end

  describe "handling GET /articles/new" do

    before(:each) do
      @article = mock_model(Article)
      Article.stub!(:new).and_return(@article)
    end

    def do_get
      get :new
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render new template" do
      do_get
      response.should render_template('new')
    end

    it "should create an new article" do
      Article.should_receive(:new).and_return(@article)
      do_get
    end

    it "should not save the new article" do
      @article.should_not_receive(:save)
      do_get
    end

    it "should assign the new article for the view" do
      do_get
      assigns[:article].should equal(@article)
    end
  end

  describe "handling GET /articles/1/edit" do

    before(:each) do
      @article = mock_model(Article)
      Article.stub!(:find).and_return(@article)
    end

    def do_get
      get :edit, :id => "1"
    end

    it "should be successful" do
      do_get
      response.should be_success
    end

    it "should render edit template" do
      do_get
      response.should render_template('edit')
    end

    it "should find the article requested" do
      Article.should_receive(:find).and_return(@article)
      do_get
    end

    it "should assign the found Article for the view" do
      do_get
      assigns[:article].should equal(@article)
    end
  end

  describe "handling POST /articles" do

    before(:each) do
      @article = mock_model(Article, :to_param => "1")
      @article.should_receive(:user=).with(any_args)
      Article.stub!(:new).and_return(@article)
    end

    describe "with successful save" do

      def do_post
        @article.should_receive(:save).and_return(true)
        post :create, :article => {}
      end

      it "should create a new article" do
        Article.should_receive(:new).with(any_args).and_return(@article)
        do_post
      end

      it "should redirect to the new article" do
        do_post
        response.should redirect_to(article_url("1"))
      end

    end

    describe "with failed save" do

      def do_post
        @article.should_receive(:save).and_return(false)
        post :create, :article => {}
      end

      it "should re-render 'new'" do
        do_post
        response.should render_template('new')
      end

    end

    describe "with preview" do
      def do_post
        @article.should_not_receive(:save)
        post :create, :article => {}, :preview => 'Preview'
      end

      it "should render 'preview'" do
        do_post
        response.should render_template('preview')
      end
    end

  end

  describe "handling PUT /articles/1" do

    before(:each) do
      @article = mock_model(Article, :to_param => "1")
      Article.stub!(:find).and_return(@article)
    end

    describe "with successful update" do

      def do_put
        @article.should_receive(:update_attributes).and_return(true)
        put :update, :id => "1"
      end

      it "should find the article requested" do
        Article.should_receive(:find).with("1").and_return(@article)
        do_put
      end

      it "should update the found article" do
        do_put
        assigns(:article).should equal(@article)
      end

      it "should assign the found article for the view" do
        do_put
        assigns(:article).should equal(@article)
      end

      it "should redirect to the article" do
        do_put
        response.should redirect_to(article_url("1"))
      end

    end

    describe "with failed update" do

      def do_put
        @article.should_receive(:update_attributes).and_return(false)
        put :update, :id => "1"
      end

      it "should re-render 'edit'" do
        do_put
        response.should render_template('edit')
      end

    end

    describe "with preview" do
      def do_put
        @article.stub!(:title=)
        @article.stub!(:body=)
        @article.should_not_receive(:update_attributes)
        put :update, :article => {}, :preview => 'Preview'
      end

      it "should render 'preview'" do
        do_put
        response.should render_template('preview')
      end
    end

  end

  describe "handling DELETE /articles/1" do

    before(:each) do
      @article = mock_model(Article, :destroy => true)
      Article.stub!(:find).and_return(@article)
    end

    def do_delete
      delete :destroy, :id => "1"
    end

    it "should find the article requested" do
      Article.should_receive(:find).with("1").and_return(@article)
      do_delete
    end

    it "should call destroy on the found article" do
      @article.should_receive(:destroy)
      do_delete
    end

    it "should redirect to the articles list" do
      do_delete
      response.should redirect_to(articles_url)
    end
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

end
