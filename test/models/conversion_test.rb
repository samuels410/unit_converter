require 'test_helper'

class ConversionTest < ActiveSupport::TestCase

  def setup
    @mt = measurement_types(:temperature)
  end


  def should_not_allow_conversion_of_different_measurement_types
    c = Conversion.new(:source_unit => units(:celsius), :target_unit => units(:time), :forward_formula => 'foo', :backward_formula => 'bar' )
    assert_equal false, c.valid?
  end

  def should_not_be_valid_at_create_if_that_relationship_is_already_established
    conv = Conversion.create(:forward_formula => "input*9/5+32",
                             :backward_formula => "(input - 32)* 5/9",
                             :source_unit => units(:celsius),
                             :target_unit => units(:fahrenheit),
                             :measurement_type => @mt)
    assert_equal false, conv.valid?
    assert conv.errors[:base].include?("Conversion between these 2 units already exists")
  end

  def should_not_be_valid_at_create_if_a_reverse_relationship_is_already_established
    conv = Conversion.create(:forward_formula => "input*9/5+32",
                             :backward_formula => "(input - 32)* 5/9",
                             :source_unit => units(:fahrenheit),
                             :target_unit => units(:celsius),
                             :measurement_type => @mt)
    assert_equal false, conv.valid?
    assert conv.errors[:base].include?("Conversion between these 2 units already exists")
  end


  def not_be_valid_if_its_a_conversion_between_same_units
    conv = Conversion.create(:forward_formula => 'foobar',
                             :backward_formula => 'barfoo',
                             :source_unit => units(:fahrenheit),
                             :target_unit => units(:fahrenheit),
                             :measurement_type => @mt)
    assert_equal false, conv.valid?
    assert conv.errors[:base].include? "Conversion between same units is not possible"
  end

  def forward_conversion
    conv = conversions(:cel_to_fah)
    assert_equal 33.8, conv.forward_conversion(1)
  end

  def backward_conversion
    conv = conversions(:cel_to_fah)
    assert_equal -17.222222, conv.backward_conversion(1)
  end

  def forward_conversion_non_numeric
    conv = conversions(:cel_to_fah)
    assert_equal "You did not enter a number", conv.forward_conversion('foo')
  end


  def test_backward_conversion_non_numeric
    conv = conversions(:cel_to_fah)
    assert_equal "Please enter a numeric value", conv.forward_conversion('foo')
  end

  def test_backward_conversion_formula_is_bogus
    conv = conversions(:cel_to_fah)
    conv.update_attributes(:backward_formula => 'fuu')
    assert_equal "Incorrect Formula", conv.backward_conversion(12)
  end

  def test_forward_formula_name
    assert_equal "Celsius to Fahrenheit", Conversion.first.forward_formula_name
  end

  def test_backward_formula_name
    assert_equal "Fahrenheit to Celsius", Conversion.first.backward_formula_name
  end


end
