class HomeController < ApplicationController

  def index

    @measurement_types = MeasurementType.all
    @measurement_type = MeasurementType.first
    @conversion = @measurement_type.conversions.first

  end

end
