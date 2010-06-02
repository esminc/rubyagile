module MembersHelper
  def link_to_member(member, icon_size = 24)
    return unless member
    link_to "#{image_tag(member.gravatar_url(:size => icon_size), :class => 'icon')} #{h(member.login)}", member_path(member)
  end
end
