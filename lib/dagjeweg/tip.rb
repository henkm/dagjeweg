module Dagjeweg

  class Tip
    attr_accessor :id
    attr_accessor :name

    #
    # Initializer to transform a +Hash+ into an Tip object
    #
    # @param [Hash] args
    def initialize(args=nil)
      return if args.nil?
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end

    # returns a list of tips for given query
    def self.find(query="")

    end

    def self.find_by_id(dw_id="")

    end

    private

    def url(ext='')
      base_url + ext
    end

    def base_url
      "http://m.dagjeweg.nl/api/#{Config.api_key}/"
    end

  end
end
