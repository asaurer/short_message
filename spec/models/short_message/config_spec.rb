require 'spec_helper'

module ShortMessage
  describe "Config" do
    include ConfigHelper
    
    it "is accessible" do
      ShortMessage.should respond_to :configure
    end
    
    
    it "renders the id string" do
      load_default_config
      ShortMessage.config.id_string.should == "123456789abcdefghijklmnopq"
    end
  end
end
