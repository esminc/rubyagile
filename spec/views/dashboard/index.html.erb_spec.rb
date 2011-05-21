# -*- coding: utf-8 -*-
require 'spec_helper'

describe "/dashboard/index" do
  before(:each) do
    login_as(:alice)

    @article = mock_model(Article, :title => 'a_title', :publishing? => true)
    @articles = assigns[:articles] = [@article]
    render 'dashboard/index'
    stub(template).render_status_for(anything) { "公開" }
  end

  it { response.should have_tag('div.articles') }
end
