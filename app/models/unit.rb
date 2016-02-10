class Unit < ActiveRecord::Base

  belongs_to :measurement_type
  has_many :conversions, :finder_sql => proc {"SELECT * from conversions WHERE source_unit_id = #{self.id} OR target_unit_id = #{self.id};"}, :dependent => :destroy

  validates :name,:measurement_type, :presence => true
  validates :name, :uniqueness => {:case_sensitive => false }

end
