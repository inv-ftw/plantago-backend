class AddCountryToClinic < ActiveRecord::Migration
  def change
    add_column :clinics, :country, :string
  end
end
