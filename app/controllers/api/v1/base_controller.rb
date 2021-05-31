# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include ExceptionHandler

      protected

      def order_params
        params.permit(:order_by, :order)
      end
    end
  end
end
