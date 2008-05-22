class Contact < ActiveRecord::Base
  validates_presence_of :email, :message
  validates_format_of :email,
    :with =>  /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i,
    :message => _("format is not valid")
end
