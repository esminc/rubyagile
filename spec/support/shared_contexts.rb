# coding: utf-8

shared_context 'ログインしている', login: true do
  let(:user)           { Fabricate(:user) }
  let(:authentication) { Fabricate(:authentication, user: user) }

  before do
    OmniAuth.config.test_mode = true
    OmniAuth.config.add_mock authentication.provider, uid: authentication.uid

    visit "/auth/#{authentication.provider}"
  end

  after do
    OmniAuth.config.test_mode = false
  end
end
