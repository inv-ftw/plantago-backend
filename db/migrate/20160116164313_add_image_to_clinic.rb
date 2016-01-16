class AddImageToClinic < ActiveRecord::Migration
  def up
    add_attachment :clinics, :image
  end

  def down
    remove_attachment :clinics, :image
  end
end
