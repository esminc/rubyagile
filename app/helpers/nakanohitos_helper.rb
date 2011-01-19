module NakanohitosHelper
  def link_to_nakanohito(nakanohito, icon_size = 24)
    return unless nakanohito
    link_to raw("#{image_tag(nakanohito.gravatar_url(:size => icon_size), :class => 'icon')} #{h(nakanohito.login)}"), nakanohito_path(nakanohito)
  end
end
