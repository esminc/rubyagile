# -*- coding: utf-8 -*-
require 'spec_helper'

describe KarekiEntriesHelper do
  describe '#replace_img_to_anchor' do
    context 'flickr の画像がある' do
      before do
        @fragment = <<-HTML
<h3>東京Ruby会議03</h3><p><a href="http://www.flickr.com/photos/kakutani/4395240536/"><img title="DSC_0290.jpg" alt="DSC_0290.jpg" src="http://farm5.static.flickr.com/4008/4395240536_713bbaba3f_m.jpg" class="flickr" width="240" height="161"></a></p>
        HTML
      end

      it 'リンクに置き換えられること' do
        helper.replace_img_to_anchor(@fragment).should == <<-HTML
<h3>東京Ruby会議03</h3><p>
  <a href="http://www.flickr.com/photos/kakutani/4395240536/">DSC_0290.jpg</a>
</p>
        HTML
      end
    end

    context "flickerのリンクがある" do
      before do
        @fragment = <<-HTML
<h3>東京Ruby会議03</h3><p><a href="http://www.flickr.com/photos/kakutani/4395240536/">写真リンク</a></p>
        HTML
      end

      it do
        expect {
          helper.replace_img_to_anchor(@fragment)
        }.to_not raise_exception(StandardError)
      end
    end

    context 'はてなフォトライフの画像がある' do
      before do
        @fragment = <<-HTML
<p><a href="http://f.hatena.ne.jp/takkan_m/20100301002048" class="hatena-fotolife" target="_blank"><img src="http://f.hatena.ne.jp/images/fotolife/t/takkan_m/20100301/20100301002048.jpg" alt="f:id:takkan_m:20100301002048j:image" title="f:id:takkan_m:20100301002048j:image" class="hatena-fotolife"></a></p>
        HTML
      end

      it 'リンクに置き換えられること' do
        helper.replace_img_to_anchor(@fragment).should == <<-HTML
<p>
  <a href="http://f.hatena.ne.jp/takkan_m/20100301002048" class="hatena-fotolife" target="_blank">f:id:takkan_m:20100301002048j:image</a>
</p>
        HTML
      end
    end
  end
end
