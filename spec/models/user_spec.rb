# -*- coding: utf-8 -*-
require 'spec_helper'

describe User do
  let(:user) { Fabricate(:user) }
  subject { user }

  describe '#accepted_rate' do
    context '何もないとき' do
      its(:accepted_rate) { should == 0.0 }
    end

    context '公開されている日記が3つあって、そのうちの1つが自分' do
      let(:mine)   { Fabricate(:feed, owner: user) }
      let(:others) { Fabricate(:feed) }

      before do
        Fabricate(:confirmed_entry, feed: mine)

        2.times do
          Fabricate(:confirmed_entry, feed: others)
        end
      end

      its(:accepted_rate) { should be_within(0.01).of(33.33) }
    end
  end
end
