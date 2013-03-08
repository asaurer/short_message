require "spec_helper"

module ShortMessage
  describe Mailer do
    describe "reload notification" do
      ShortMessage.configure do |config|
        config.reload_notification_email = "webmaster@your-domain.com"
        config.default_mail_sender = "webmaster@your-domain.com"
      end
      
      amount = 20
      
      let(:mail) { ShortMessage::Mailer.recharge_notification amount }
      
      it "renders the subject" do
        mail.subject.should == "SMS credit recharged"
      end
      
      it "renders the sender email" do
        mail.from.should == ["webmaster@your-domain.com"]
      end
      
      it "renders the recipient email" do
        mail.to.should == ["webmaster@your-domain.com"]
      end
      
      it "contains the amount in the body" do
        mail.body.encoded.should match(amount.to_s)
      end
    end
    
    describe "voucher notification" do
      ShortMessage.configure do |config|
        config.user_id = "123456789abcdefghijklmnopq"
        config.voucher_notification_email = "give-me-money@your-domain.com"
        config.default_mail_sender = "webmaster@your-domain.com"
      end
      
      amount = 20
      
      let(:mail) { ShortMessage::Mailer.voucher_notification amount }
      
      it "renders the subject" do
        mail.subject.should == "SMS credit recharged, please create a voucher"
      end
      
      it "renders the sender email" do
        mail.from.should == ["webmaster@your-domain.com"]
      end
      
      it "renders the recipient email" do
        mail.to.should == ["give-me-money@your-domain.com"]
      end
      
      it "contains the amount in the body" do
        mail.body.encoded.should match(amount.to_s)
      end
      
      it "contains the customer in the body" do
        mail.body.encoded.should match(amount.to_s)
      end
    end
  end
end
