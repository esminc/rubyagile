# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  def site_name
    "Ruby x Agile"
  end

  def nakanohito_name(nakanohito)
    nakanohito.fullname.present? ? "#{nakanohito.login} (#{nakanohito.fullname})" : nakanohito.login
  end
end
