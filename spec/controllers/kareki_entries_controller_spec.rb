require 'spec_helper'

describe KarekiEntriesController do

  describe "GET /index" do
    context "not logged in" do
      before do
        not_logged_in
        get :index
      end

      subject { response }
      it { should redirect_to(new_session_url) }
    end

    context "logged in" do
      fixtures :users

      before do
        login_as :alice
        mock(KarekiEntry).all(:order => 'created_at DESC') { ["a entry"] }
        get :index
      end

      subject{ assigns[:entries] }
      it{ should == ["a entry"] }
    end
  end
end
