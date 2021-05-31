# frozen_string_literal: true

module Api
  module V1
    class PeopleController < BaseController
      def index
        render json: people_list
      end

      def frequency_count_by_emails
        frequency_counter = FrequencyCounter.new(email_addresses, order_params[:order])

        if frequency_counter.errors.any?
          render json: { errors: frequency_counter.errors.to_sentence }, status: :bad_request
        else
          render json: { frequencies_count: frequency_counter.generate }
        end
      end

      private

      def people_list
        @people_list ||= begin
          response = Salesloft.get_people
          raise(SalesloftApiError, response['error']) if response['error'].present?

          response
        end
      end

      def email_addresses
        people_list['data']&.map {|p| p['email_address']}
      end
    end
  end
end
