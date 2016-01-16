class Physician < ActiveRecord::Base
  validates_presence_of :name, :phone, :country
  validates :phone, format: /^\+[0-9]{7,}/

  has_attached_file :image, styles: { thumb: '100x100>', medium: '370x270#'}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/
end
