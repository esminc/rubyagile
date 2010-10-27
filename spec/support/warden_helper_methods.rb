module WardenHelperMethods
  def login_as(user)
    raise unless u = users(user)

    stub(request.env['warden']) {
      user { u }
      authenticated? { true }
      raw_session # logout で必要になるよ
    }

    u.id
  end

  def not_logged_in
    stub(request.env['warden']) {
      user { nil }
      authenticated? { false }
      raw_session # logout で必要になるよ
    }
  end
end
