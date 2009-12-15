require 'spec_helper'

describe WelcomeController do
  before do
    login_as :alice
  end

  describe "handling GET /" do
    fixtures :articles, :kareki_entries

    before do
      get :index
    end

    it { response.should be_success }
    it { response.should render_template('index') }

    describe 'articles' do
      subject { assigns[:articles] }

      it { should have(1).item }
      it { subject.first.should be_publishing }
    end

    describe 'entries' do
      subject { assigns[:entries] }

      it { should have(1).item }
      it { should be_instance_of(WillPaginate::Collection) }
      it { subject.first.confirmation.should be_confirmed }
    end
  end
end
