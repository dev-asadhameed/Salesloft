# frozen_string_literal: true

module Api
  module V1
    class PeopleController < BaseController
      before_action :params_required, only: :frequency_count_by_emails

      def index
        render json: people_list
      end

      def frequency_count_by_emails
        frequencies_count = FrequencyCount.new(email_addresses, order_params[:order])

        if frequencies_count.errors.any?
          render json: { errors: frequencies_count.errors.to_sentence }, status: :bad_request
        else
          render json: { frequencies_count: frequencies_count.generate }
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
