module MembersHelper
  def link_to_memeber(member)
    return unless member
    link_to h(member.login), member_path(member)
  end
end
