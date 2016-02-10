class CreateConversions < ActiveRecord::Migration
  def change
    create_table :conversions do |t|
      t.belongs_to :measurement_type
      t.integer  :source_unit_id
      t.integer  :target_unit_id
      t.string   :forward_formula
      t.string   :backward_formula
      t.timestamps
    end
  end
end
