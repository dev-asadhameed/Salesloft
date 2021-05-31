# frozen_string_literal: true

module ExceptionHandler
  extend ActiveSupport::Concern

  class SalesloftApiError < StandardError
  end

  included do
    rescue_from SalesloftApiError do |e|
      render json: { message: e.message }, status: :bad_request
    end
  end
end
