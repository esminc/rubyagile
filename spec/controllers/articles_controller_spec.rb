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
      dont_allow(@article).save
      stub(Article).new { @article }
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
      @article = mock_model(Article)
      stub(Article).find { @article }
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
      stub(Article).new { @article }
    end

    describe "with successful save w/o publishing" do
      before do
        stub(Article).new(anything) { @article }
        mock(@article).save { true }
        post :create, :article => {:publishing => 0}
      end

      it { response.should redirect_to(article_url("1")) }

      it { @article.publishing.should be_false }
    end

    describe "with successful save w/o direct_post" do
      before do
        mock(Article).new(anything) { @article }
        mock(@article).save { true }
        post :create, :article => {:publishing => 1}
      end

      it { response.should redirect_to(article_url("1")) }
    end


    describe "with failed save" do
      before do
        mock(@article).save { false }
        post :create, :article => { :title => 'example', :body => 'hello' }
      end

      it { response.should render_template('new') }
    end

    describe "with preview" do
      before do
        dont_allow(@article).save
        post :create, :article => { :title => 'example', :body => 'hello' }, :preview => 'Preview'
      end
      it { response.should render_template('preview') }
    end

  end

  describe "handling PUT /articles/1" do
    before(:each) do
      @article = mock_model(Article, :to_param => "1")
      stub(Article).find { @article }
    end

    describe "with successful update" do
      before do
        mock(Article).find("1") { @article }
        stub(@article).update_attributes { true }
        put :update, :id => "1", :article => { :title => 'example', :body => 'hello' }
      end

      it { assigns(:article).should equal(@article) }
      it { response.should redirect_to(article_url("1")) }
    end

    describe "with failed update" do
      before do
        stub(@article).update_attributes { false }
        put :update, :id => "1", :article => { :title => 'example', :body => 'hello' }
      end

      it { response.should render_template('edit') }
    end

    describe "with preview" do
      before do
        dont_allow(@article).update_attribute
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
      mock(Article).find("1") { @article }
      mock(@article).destroy
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
        stub(@comment).save { true }
        stub(Article).find { @article }
        stub(Comment).parse_params { @comment }
        do_comment({:author => 'alice', :body => 'some body'})
      end

      it { response.should redirect_to(:controller => 'articles', :action => 'show', :id => @article.id) }
    end
  end

  describe "handling Atomfeed" do
    before do
      @articles = [mock_model(Article, :to_param => "1")]
      stub(Article).publishing { @articles }
      stub(@articles).newer_first { @articles }
      get "feed", :type => 'xml'
    end

    it { response.should render_template("feed") }
  end
end
