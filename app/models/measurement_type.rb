class MeasurementType < ActiveRecord::Base

  validates :name, {:presence => true}
  validates :name, :uniqueness => {:case_sensitive => false }

  has_many :units, :dependent => :destroy
  has_many :conversions

end
