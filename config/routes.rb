UnitConverter::Application.routes.draw do
  require 'api_constraints'

  root 'home#index'

  namespace :api, defaults: {format: 'json'} do
    scope module: :v1, constraints: ApiConstraints.new(version: 1, default: :true) do
      post 'convert_forward', to: 'conversions#convert_forward'
      post 'convert_backward', to: 'conversions#convert_backward'
      post 'change_measurement', to: 'conversions#change_measurement'
    end

  end


end
