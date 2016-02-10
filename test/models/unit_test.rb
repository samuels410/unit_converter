require 'test_helper'

class UnitTest < ActiveSupport::TestCase

  def setup
    @mt = measurement_types(:temperature)
  end

  def should_not_valid_without_name
    unit = Unit.create(:measurement_type => @mt)
    assert_equal false, unit.valid?
    assert unit.errors.messages[:name].include?("unit name should not be blank")
  end

  def should_valid_with_name
    unit = Unit.create(:measurement_type => @mt, :name => 'foobar')
    assert_equal true, unit.valid?, unit.errors.messages
  end

  def should_validate_uniqueness_of_name
    unit = Unit.create(:measurement_type => @mt, :name => 'Celsius')
    assert_equal false, unit.valid?
    assert unit.errors.messages[:name].include?("has already been taken")
  end

  def validate_presence_of_measurement_type
    unit = Unit.create(:measurement_type => nil, :name => 'foo')
    assert_equal false, unit.valid?
    assert unit.errors.messages[:measurement_type].include?("can't be blank")
  end


  def test_conversions_association
    minute = units(:minute)
    assert_equal 1, minute.conversions.count

    assert_difference "minute.conversions.count", +1 do
      conv = Conversion.create(:source_unit_id => 3, :target_unit_id => 4, :forward_formula => 'foo', :backward_formula => 'bar', :measurement_type => measurement_types(:time))
      assert conv.valid?
    end
    assert_difference "minute.conversions.count", -1 do
      Conversion.last.destroy
    end

    ids = minute.conversion_ids
    minute.destroy
    ids.each do |id|
      assert_raise ActiveRecord::RecordNotFound do
        Conversion.find(id)
      end
    end
  end

end
