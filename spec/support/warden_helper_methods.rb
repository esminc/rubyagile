# -*- coding: utf-8 -*-
module WardenHelperMethods
  def login_as(user)
    raise unless u = users(user)

    request.env['warden'].tap do |r|
      allow_message_expectations_on_nil
      r.stub(:user) { u }
      r.stub(:authenticated?) { true }
      r.stub(:raw_session)
    end

    u.id
  end

  def not_logged_in
    request.env['warden'].tap do |r|
      allow_message_expectations_on_nil
      r.stub(:user) { nil }
      r.stub(:authenticated?) { true }
      r.stub(:raw_session)
    end
  end
end
