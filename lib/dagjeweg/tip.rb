module Dagjeweg

  class Tip
    attr_accessor :id, :active_on_dagjeweg_tickets, :ticket_payload, :name, :postal_code, :google_name, :show_name, :show_price, :address, :email, :city, :dw_id, :latitude, :longitude, :long_description, :phone, :image2, :image3, :image4, :image5, :image6, :image8, :image9, :image10, :image11, :image12, :image13, :dwurl, :from_time, :until_time, :open_comment, :price, :price_kids, :price_seniors, :price_toddlers, :price_comment, :description, :wheelchair, :wheelchair_toilet, :accessible, :accessible_comment, :periode, :weer, :rounded_cijfer, :beter_uit, :number_of_reviews, :eerste_paasdag, :tweede_paasdag, :goede_vrijdag, :bevrijdingsdag, :hemelvaartsdag, :eerste_pinksterdag, :tweede_pinksterdag, :eerste_kerstdag, :tweede_kerstdag, :oudejaarsdag, :nieuwjaarsdag, :koningsdag, :images, :show_reviews, :goud, :vip, :affiliate, :url, :ma, :di, :wo, :do, :vr, :za, :zo, :genre, :distance
    # attr_accessor :id, :name, :google_name, :show_name, :show_price, :address, :email, :city, :postal_code, :dw_id, :latitude, :longitude, :image, :show_image, :long_description, :url, :phone, :email, :image2, :image3, :image4, :image5, :image6, :image8, :image9, :image10, :image11, :image12, :image13, :dwurl, :ma, :di, :wo, :do, :vr, :za, :zo, :from_time, :until_time, :open_comment, :price, :price_kids, :price_seniors, :price_toddlers, :price_comment, :description, :show_reviews, :wheelchair, :wheelchair_toilet, :accessible, :accessible_comment, :periode, :weer, :rounded_cijfer, :number_of_reviews, :activities, :genre, :distance, :eerste_paasdag, :tweede_paasdag, :goede_vrijdag, :bevrijdingsdag, :hemelvaartsdag, :eerste_pinksterdag, :tweede_pinksterdag, :eerste_kerstdag, :tweede_kerstdag, :oudejaarsdag, :nieuwjaarsdag, :koningsdag

    # Initializer to transform a +Hash+ into an Tip object
    #
    # @param [Hash] args
    def initialize(args=nil)
      return if args.nil?
      args.each do |k,v|
        puts "Setting attr accessor for #{k}"
        singleton_class.class_eval { attr_accessor k }
        instance_variable_set("@#{k}", v) unless v.nil?
      end
      self.id = self.dw_id
      typecast_attrs
    end


    # returns a list of tips for given query
    def self.search(query="", per_page=50, page=1)
      search_tips = []
      unless search_tips.any?
        uri = Dagjeweg::Tip.api_url("search.json?q=#{URI.escape(query)}&per_page=#{per_page}&page=#{page}")
        json = Dagjeweg::Tip.get_json(uri)
        for object in json["tips"]
          search_tips << Dagjeweg::Tip.new(object)
        end
        return search_tips
      end
    end

    def self.find(dw_id="")
      uri = Dagjeweg::Tip.api_url("tips/#{dw_id}.json")
      json = Dagjeweg::Tip.get_json(uri)
      if json && json.is_a?(Hash)
        tip = new(json)
        return tip
      else
        puts "JSON:\n#{json }"
        raise DagjewegError.new("Tip met deze ID werd niet gevonden. Response: #{json}")
      end
    end

    # return a list of tips near location. Takes 3 params:
    # - lat
    # - lon
    # - number of tips
    def self.near(lat, lon, per_page)
      uri = Dagjeweg::Tip.api_url("tips.json?lat=#{lat}&lon=#{lon}&per_page=#{per_page}")
      json = Dagjeweg::Tip.get_json(uri)
      Dagjeweg::Tip.parse_json(json)
    end

    # returns a list of tips in the range of x kilometers of this instance
    def nearby(range=10)
      uri = Dagjeweg::Tip.api_url("tips/#{id.to_s}/nearby.json")
      json = Dagjeweg::Tip.get_json(uri)
      Dagjeweg::Tip.parse_json(json)
    end

    # returns a list of review objects
    def reviews
      reviews = []
      unless reviews.any?
        for object in show_reviews
          reviews << Dagjeweg::Review.new(
            tip_id: id, 
            reviewer: object["reviewer"], 
            title: object["titel"],
            body: object["body"], 
            duration: object["duur"], 
            rating: object["cijfer"].to_i, 
            review_date: object["review_date"], 
            visit_date: object["visit_date"]
          )
        end
      end
      return reviews
    end

    def weather
      weer
    end

    def period
      periode
    end

    
    private

    # Transform the json object in an Array of Tip instances
    def self.parse_json(json)
      a = []
      for object in json #["tips"]
        a << Dagjeweg::Tip.new(object)
      end
      return a
    end

    # Get the JSON object and return proper errors in scenarios where response code != 200 OK
    def self.get_json(uri)
      resp = Net::HTTP.get_response(URI.parse(uri))
      case resp.code.to_i
      when 200
        return JSON.parse(resp.body)
      when 404
        raise DagjewegError.new(self), "Tip met deze ID werd niet gevonden. (#{resp.code})"
      when 403
        raise DagjewegError.new(self), "Ongeldige API Key (#{resp.code})"
      else
        raise DagjewegError.new(self), "Onbekende fout (#{resp.code})"
      end
    end

    def self.api_url(ext='')
      self.base_url + ext
    end

    def self.base_url
      "https://api.dagjeweg.nl/api/#{Config.api_key}/"
    end

    def typecast_attrs
      # unless distance == ''
      #   self.distance = self.distance.to_f
      # end
      # self.price = price.to_i unless price == ''
      # self.price_kids = price_kids.to_i unless price_kids == ''
      # self.price_toddlers = price_toddlers.to_i unless price_toddlers == ''
      # self.price_seniors = price_seniors.to_i unless price_seniors == ''
    end

  end
end