require 'spec_helper'

describe Dagjeweg::Tip do
  before(:each) do

  end

  describe "invalid credentials" do

    it "raises error when credentials are wrong" do
      Dagjeweg::Config.api_key = "1234"
      VCR.use_cassette("request-tips-without-credentials") do
        expect { Dagjeweg::Tip.find(52) }.to raise_error(DagjewegError, "Ongeldige API Key (403)")
      end
    end

  end

  describe "valid credentials" do

	  before(:all) do
	  	Dagjeweg.set_credentials_from_environment
	  end

	  describe "#find" do
	    it "returns a tip object with ID of given id when credentials are correct" do
	    	VCR.use_cassette("request-tips-with-credentials") do
	    		tip = Dagjeweg::Tip.find(52)
	    		expect(tip).to be_kind_of(Dagjeweg::Tip)
	        expect(tip.id).to eq(52)
	      end
	    end
		end  

	  describe "#search" do

	  	before(:all) do
	    	# VCR.use_cassette("request-reviews") do
	    	# 	@tip = Dagjeweg::Tip.find(22)
	    	# 	@review = @tip.reviews.first
	     #  end
	  	end
	 
	    it "returns relevant tips for query" do
	    	VCR.use_cassette("request-query") do
	    		tips = Dagjeweg::Tip.search("dolfinarium")
		    	expect(tips.count).to be > 0
		    	expect(tips.first.id).to eq(22) #DagjeWeg ID van dolfinarium
		    end
	    end

		end  

	  describe "#nearby" do
	  	before(:all) do
	    	VCR.use_cassette("request-tips-with-credentials") do
	    		@tip = Dagjeweg::Tip.find(52)
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
	    		expect(nearby_tips[5].distance).to be_between(0.0, 10.0)
	      end

	    end
		end  

	  describe "#near" do
	    it "returns a list of tips near a geolocation" do
	      VCR.use_cassette("request-tips-near") do
	    		nearby_tips = Dagjeweg::Tip.near(52.3702160, 4.8951680, 20)
	    		expect(nearby_tips.count).to be 20
	    		expect(nearby_tips.first).to be_kind_of(Dagjeweg::Tip)
	      end
	    end
		end  

	  describe "#reviews" do

	  	before(:all) do
	    	VCR.use_cassette("request-reviews") do
	    		@tip = Dagjeweg::Tip.find(22)
	    		@review = @tip.reviews.first
	      end
	  	end
	 
	    it "returns a list of reviews for a tip" do
	    	expect(@tip.reviews.count).to be > 20
	    end

	    it "has a reviewers name" do
	    	expect(@review.reviewer).to include("Beoordeling gegeven door")
	    end

		end  
	end
end
