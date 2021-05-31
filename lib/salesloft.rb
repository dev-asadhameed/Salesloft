# frozen_string_literal: true

require 'httparty'

module Salesloft
  class << self
    def get_people
      HTTParty.get("#{ENV['SALESLOFT_API_URL']}/#{ENV['SALESLOFT_API_VERSION']}/#{SALESLOFT_GET_PEOPLE_PATH}",
                              headers: default_headers)
              .parsed_response
    end

    private

    SALESLOFT_GET_PEOPLE_PATH = 'people'

    private_constant :SALESLOFT_GET_PEOPLE_PATH

    def default_headers
      {
        'Content-Type': 'application/json',
        'Authorization': "Bearer #{ENV['SALESLOFT_API_TOKEN']}"
      }
    end
  end
end
