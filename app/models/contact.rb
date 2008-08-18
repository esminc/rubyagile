class Contact < ActiveRecord::Base
  validates_presence_of :email, :message
  validates_format_of :email,
    :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :message => _("format is not valid")

  attr_accessor :bot
  alias :bot? :bot
  validates_acceptance_of :bot, :accept => '0', :message => _("must be checked off.")

  N_("Contact|Bot")

  def after_initialize
    @bot = 1
  end
end
