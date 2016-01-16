class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers


  def landing

  end

  def info
    lat = params[:lat].to_f
    lng = params[:lng].to_f
    geo_result = Geocoder.search("#{lat},#{lng}").first

    country = geo_result.address_components.last['short_name']
    formatted_address = geo_result.formatted_address
    physician = Physician.where(country: country)

    p = {
      name: '',
      phone: '',
      image: ''
    }

    if physician.any?
      p[:name] = physician.first.name
      p[:phone] = physician.first.phone
      p[:image] = physician.first.image.url(:thumb)
    end

    info = {
      physician: {
        name: p[:name],
        phone: p[:phone],
        image: p[:image]
      },
      emergency_number: '+380674453282',
      formatted_address: formatted_address
    }

    respond_to do |format|
      format.json {render json: {info: info}, status: :ok}
    end
  end

  private

  def cors_set_access_control_headers
    headers['Access-Control-Allow-Origin'] = '*'
    headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
    headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token'
    headers['Access-Control-Max-Age'] = "1728000"
    # headers['Access-Control-Allow-Credentials'] = 'true'
  end

  def cors_preflight_check
    if request.method == 'OPTIONS'
      headers['Access-Control-Allow-Origin'] = '*'
      headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, DELETE, OPTIONS'
      headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-Prototype-Version, Token'
      headers['Access-Control-Max-Age'] = '1728000'

      render :text => '', :content_type => 'text/plain'
    end
  end

end
