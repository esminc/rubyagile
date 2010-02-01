class Contact < ActiveRecord::Base
  validates_presence_of :email, :message
  validates_format_of :email,
    :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :allow_blank => true

  attr_accessor :bot
  alias :bot? :bot
  validates_acceptance_of :bot, :accept => '0', :message => '対策のチェックボックスをオフにしてください。お手数をおかけします。'

  def after_initialize
    @bot = 1
  end
end
