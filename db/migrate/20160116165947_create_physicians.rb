class CreatePhysicians < ActiveRecord::Migration
  def change
    create_table :physicians do |t|
      t.string :name
      t.string :phone
      t.string :country

      t.timestamps null: false
    end
  end
end
