require 'spec_helper'

describe Dagjeweg::Tip do
  before(:each) do

  end

  describe "#find_by_id" do

    it "raises error when credentials are wrong" do
      Dagjeweg::Config.api_key = "1234"
      VCR.use_cassette("request-tips-without-credentials") do
        expect { Dagjeweg::Tip.find(52) }.to raise_error(DagjewegError, "Login failed.")
      end
    end
	end  

end
