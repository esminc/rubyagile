class LoadFrontPage < ActiveRecord::Migration
  def self.up
    anon = User.create(:login => 'anonymous', :email => 'anon@example.com',
      :open_id_url => 'http://example.com/', :fullname => 'Anonymous User',
      :amazon_associate => 'kakutani-22', :member => false)
    Page.create(:name => 'FrontPage', :content => <<-EOS, :user => anon)
! FrontPage
this is front page for wiki.
    EOS
  end

  def self.down
    User.delete_all(['login = ?', 'anonymous'])
    Page.delete_all(['name = ?', 'FrontPage'])
  end
end
