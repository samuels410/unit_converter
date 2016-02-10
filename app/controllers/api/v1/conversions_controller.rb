module Api
  module V1
    class ConversionsController < ApplicationController
      before_filter :get_conversion, except: :change_measurement
      respond_to :json

      def convert_forward
          @result = @conversion.forward_conversion(params[:value].to_f)
          render_response(@result)
      end

      def convert_backward
          @result = @conversion.backward_conversion(params[:value].to_f)
          render_response(@result)
      end

      def change_measurement
        @measurement_type = MeasurementType.find(params[:id])
        conversion = @measurement_type.conversions.first
        data = {source_unit_name: conversion.source_unit,target_unit_name: conversion.target_unit}
        render_response(data)
      end

      def render_response(result)
        respond_to do |format|
          format.json { render :json => result }
        end
      end

      def get_conversion
        @conversion = Conversion.find(params[:id])
      end

    end
  end
end
