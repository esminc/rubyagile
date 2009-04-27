class Contact < ActiveRecord::Base
  validates_presence_of :email, :message
  validates_format_of :email,
    :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :message => I18n.t("format is not valid")

  attr_accessor :bot
  alias :bot? :bot
  validates_acceptance_of :bot, :accept => '0', :message => I18n.t("must be checked off.")

  def after_initialize
    @bot = 1
  end
end
