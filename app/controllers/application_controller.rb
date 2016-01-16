class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception


  def landing

  end

  def info
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    geo_result = Geocoder.search("#{lat},#{lng}").first

    country = geo_result.address_components.last['long_name']
    formatted_address = geo_result.formatted_address
    physician = Physician.where(country: country)

    p = {
      name: '',
      phone: '',
      image: ''
    }

    if physician.any?
      p.name = physician.name
      p.phone = physician.name
      p.image = physician.image.url(:thumb)
    end

    info = {
      physician: {
        name: p.name,
        phone: p.phone,
        image: p.image
      },
      emergency_number: '112',
      formatted_address: formatted_address
    }

    respond_to do |format|
      format.json {render json: {info: info.to_json}, status: :ok}
    end
  end
end
