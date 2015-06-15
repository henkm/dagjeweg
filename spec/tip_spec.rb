require 'spec_helper'

describe Dagjeweg::Tip do
  before(:each) do

  end

  describe "invalid credentials" do

    it "raises error when credentials are wrong" do
      Dagjeweg::Config.api_key = "1234"
      VCR.use_cassette("request-tips-without-credentials") do
        expect { Dagjeweg::Tip.find_by_id(52) }.to raise_error(DagjewegError, "Ongeldige API Key (403)")
      end
    end

  end

  describe "valid credentials" do

	  before(:all) do
	  	Dagjeweg.set_credentials_from_environment
	  end

	  describe "#find_by_id" do
	    it "returns a tip object with ID of given id when credentials are correct" do
	    	VCR.use_cassette("request-tips-with-credentials") do
	    		tip = Dagjeweg::Tip.find_by_id(52)
	    		expect(tip).to be_kind_of(Dagjeweg::Tip)
	        expect(tip.id).to eq(52)
	      end
	    end
		end  

	  describe "#nearby" do
	  	before(:all) do
	    	VCR.use_cassette("request-tips-with-credentials") do
	    		@tip = Dagjeweg::Tip.find_by_id(52)
	      end
	  	end

	    it "returns a list of nearby tips" do
	      VCR.use_cassette("request-nearby-tips") do
	    		nearby_tips = @tip.nearby(10)
	    		expect(nearby_tips.count).to be > 20
	    		expect(nearby_tips.first).to be_kind_of(Dagjeweg::Tip)
	      end
	    end

	    it "has a distance attribute" do
	      VCR.use_cassette("request-nearby-tips") do
	    		nearby_tips = @tip.nearby(10)
	    		expect(nearby_tips.first.distance).to be < 0.8
	      end

	    end
		end  

	  describe "#near" do
	    it "returns a list of tips near a geolocation" do
	      VCR.use_cassette("request-tips-near") do
	    		nearby_tips = Dagjeweg::Tip.near(lat: 52.3702160, lon: 4.8951680)
	    		expect(nearby_tips.count).to be > 20
	    		expect(nearby_tips.first).to be_kind_of(Dagjeweg::Tip)
	      end
	    end
		end  


	end
end
