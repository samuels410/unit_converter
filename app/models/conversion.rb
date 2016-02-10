class Conversion < ActiveRecord::Base

  belongs_to :source_unit, :class_name => 'Unit'
  belongs_to :target_unit, :class_name => 'Unit'
  belongs_to :measurement_type

  validates :forward_formula, :presence => true
  validates :backward_formula, :presence => true
  validates :measurement_type, :presence => true


  def forward_conversion(input)
    return "Please enter a numeric value" unless is_numerical?(input)
    begin
      input = Float(input)
      eval(forward_formula).round(6)
    rescue
      return "Incorrect Formula"
    end
  end

  def backward_conversion(input)
    return "Please enter a numeric value" unless is_numerical?(input)
    begin
      input = Float(input)
      eval(backward_formula).round(6)
    rescue
      "Incorrect Formula"
    end
  end

  def is_numerical?(input)
    true if Float(input) rescue false
  end

  def forward_formula_name
    "#{source_unit.name} to #{target_unit.name}"
  end

  def backward_formula_name
    "#{target_unit.name} to #{source_unit.name}"
  end


end
