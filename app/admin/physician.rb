ActiveAdmin.register Physician do
  permit_params :name, :phone, :country, :image

  index do
    id_column
    column :name
    column :phone
    column :country
    column :image do |post|
      image_tag post.image.url(:thumb)
    end
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :phone
      f.input :country
      f.input :image, as: :file
    end
    f.actions
  end

  show do |ad|
    attributes_table do
      row :image do
        image_tag(ad.image.url(:thumb))
      end
      row :name
      row :phone
      row :country
      row :created_at
      row :updated_at
    end
  end

end