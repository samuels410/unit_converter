class CreateUnits < ActiveRecord::Migration
  def change
    create_table :units do |t|
      t.belongs_to :measurement_type
      t.string :name
      t.timestamps
    end
  end
end
