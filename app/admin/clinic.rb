ActiveAdmin.register Clinic do
  permit_params :name, :lat, :lng, :description, :phone, :image

  index do
    id_column
    column :name
    column :description
    column :phone
    column :lat
    column :lng
    column :image do |post|
      image_tag post.image.url(:thumb)
    end
    column :updated_at
    actions
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :description
      f.input :phone
      f.input :lat
      f.input :lng
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
      row :description
      row :phone
      row :lat
      row :lng
      row :created_at
      row :updated_at
    end
  end


end