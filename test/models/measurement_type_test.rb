require 'test_helper'

class MeasurementTypeTest < ActiveSupport::TestCase

  def not_valid_without_name
    measurement_type = MeasurementType.create()
    assert_equal false, measurement_type.valid?
    assert measurement_type.errors.messages[:name].include?("can't be blank")
  end


  def valid_with_name
    type = MeasurementType.create(:name => 'Temperature')
    assert type.valid?
  end

  def not_allow_measurement_types_with_same_name
    type = MeasurementType.create(:name => 'Temperature')
    assert_equal false, type.valid?
    assert type.errors.messages[:name].include?("Name already been taken")
  end

  def test_units_association
    mt = MeasurementType.first

    assert_difference "mt.units.count", +1 do
      millisecond = Unit.create(:name => "millisecond", :measurement_type => mt)
      assert millisecond.valid?
    end

    ids = mt.unit_ids
    mt.destroy

    ids.each do |id|
      assert_raise ActiveRecord::RecordNotFound do
        Unit.find(id)
      end
    end
  end

  

end
