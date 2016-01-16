class Clinic < ActiveRecord::Base
  validates_presence_of :name, :lat, :lng, :phone
  validates_uniqueness_of :phone, :name
  validates :phone, format: /^\+?[0-9 ]+\d$/i

  has_attached_file :image, styles: { thumb: '200x200>', medium: '370x270#'}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  geocoded_by :address, :latitude  => :lat, :longitude => :lng

  def address
    [street, city, state, country].compact.join(', ')
  end

  def as_json(options={})
    if options[:custom] === true
      {
        id: self.id,
        name: self.name,
        description: self.description,
        image: self.image.url(:medium),
        phone: self.phone
      }
    else
      super
    end
  end

end
