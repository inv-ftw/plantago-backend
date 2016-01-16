class Clinic < ActiveRecord::Base
  validates_presence_of :name, :lat, :lng, :phone
  validates_uniqueness_of :phone, :name
  validates :phone, format: /\+[0-9]{7,}/

  has_attached_file :image, styles: { thumb: '200x200>', medium: '370x270#'}
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  geocoded_by :country_address, :latitude  => :lat, :longitude => :lng

  before_save :set_address

  def country_address
    ''
  end

  def as_json(options={})
    if options[:custom] === true
      {
        id: self.id,
        name: self.name,
        description: self.description,
        image: self.image.url(:medium),
        phone: self.phone,
        lat: self.lat,
        lng: self.lng,
        address: self.address
      }
    else
      super
    end
  end

  private

  def set_address
    geo_result = Geocoder.search("#{self.lat},#{self.lng}").first
    self.address = geo_result.formatted_address
  end

end
