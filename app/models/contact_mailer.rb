# -*- coding: utf-8 -*-
class ContactMailer < ActionMailer::Base

  def message(contact)
    @subject    = "[自動送信]永和システムマネジメントへのお問い合わせ(#{Time.now.to_i})"
    @body["contact"] = contact
    @recipients = contact.email
    # FIXME ugly.
    if RAILS_ENV == "production"
      @bcc = "rubyagile@esm.co.jp"
    end
    @from       = "rubyagile@esm.co.jp"
    @sent_on    = contact.created_at
    @headers    = {}
  end
end
