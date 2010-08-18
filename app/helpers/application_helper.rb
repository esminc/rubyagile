# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def site_name
    "Ruby x Agile"
  end

  def member_name(member)
    member.fullname.present? ? "#{member.login} (#{member.fullname})" : member.login
  end
end
