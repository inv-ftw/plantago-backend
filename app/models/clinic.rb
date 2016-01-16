class Clinic < ActiveRecord::Base
  validates_presence_of :name, :lat, :lng, :phone

  has_attached_file :image, styles: { thumb: '100x100>', medium: '370x270#'}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  geocoded_by :address, :latitude  => :lat, :longitude => :lng

  def address
    [street, city, state, country].compact.join(', ')
  end

  def as_json(options={})
    if options[:custom] === true
      {
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
