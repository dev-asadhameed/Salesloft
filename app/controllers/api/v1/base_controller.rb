# frozen_string_literal: true

module Api
  module V1
    class BaseController < ApplicationController
      include ExceptionHandler

      before_action :params_required, only: %i[show create]

      protected

      def params_required; end

      def order_params
        params.permit(:order_by, :order)
      end
    end
  end
end
