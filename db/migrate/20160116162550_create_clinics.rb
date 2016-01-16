class CreateClinics < ActiveRecord::Migration
  def change
    create_table :clinics do |t|
      t.string :name
      t.float :lat
      t.float :lng
      t.string :phone
      t.text :description

      t.timestamps null: false
    end
  end
end
