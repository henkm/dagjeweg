module Dagjeweg

  class Review
    attr_accessor :tip_id,:title, :reviewer, :body, :duration, :rating, :review_date, :visit_date

    #
    # Initializer to transform a +Hash+ into an Review object
    #
    # @param [Hash] args
    def initialize(args=nil)
      return if args.nil?
      args.each do |k,v|
        instance_variable_set("@#{k}", v) unless v.nil?
      end
    end


    private

  end
end
