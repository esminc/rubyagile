# -*- coding: utf-8 -*-
class ContactMailer < ActionMailer::Base

  def message(contact)
    @subject    = "[自動送信]永和システムマネジメントへのお問い合わせ(#{Time.now.to_i})"
    @body["contact"] = contact
#    @recipients = contact.email
    @bcc = ::MAIL_CONF[:bcc]
    @from       = "rubyagile@esm.co.jp"
    @sent_on    = contact.created_at
    @headers    = {}
  end
end
