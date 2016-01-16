class AddImageToPhysician < ActiveRecord::Migration
  def up
    add_attachment :physicians, :image
  end

  def down
    remove_attachment :physicians, :image
  end
end
