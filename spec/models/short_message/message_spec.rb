# encoding: utf-8
require 'spec_helper'

module ShortMessage
  describe "Status Text 1 EN" do
    it "responds with full english text" do
      I18n.locale = :en
      FactoryGirl.build(:message, :status_code => 1).status_text.should == "delivered"
    end
  end
  
  describe "Status Text 1 DE" do
    it "responds with full german text" do
      I18n.locale = :de
      FactoryGirl.build(:message, :status_code => 1).status_text.should == "zugestellt"
    end
  end
  
  describe "Status Text 100 EN" do
    it "responds with full english text" do
      I18n.locale = :en
      FactoryGirl.build(:message, :status_code => 100).status_text.should == "created"
    end
  end
  
  describe "Status Text 100 DE" do
    it "responds with full german text" do
      I18n.locale = :de
      FactoryGirl.build(:message, :status_code => 100).status_text.should == "erstellt"
    end
  end
  
  describe "deliver params array" do
    include ConfigHelper
    
    it "generates smoothly" do
      load_default_config
      message = FactoryGirl.build(:message, :sender => "0041791234567", :recipient => "0041799876543", :text => "test ä&!")
      
      message.send(:build_deliver_params_string).should == "UserID=1234&CCUID=1234&ID=123456789abcdefghijklmnopq&sender=0041791234567&receipient=0041799876543&message=test+%E4%26%21"
    end
  end
  
  describe "recharge params array" do
    include ConfigHelper
    
    it "generates smoothly" do
      load_default_config
      Message.new.send(:build_recharge_params_string, 20).should == "UserIDFS=1234&CCUID=1234&pay=1&amount=20&idstring=123456789abcdefghijklmnopq"
    end
  end
end
