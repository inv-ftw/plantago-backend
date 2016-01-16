class ClinicsController < ApplicationController

  def index
    lat = params[:lat].to_f
    lng = params[:lng].to_f

    clinics = Clinic.near([lat, lng], 20, :units => :km).limit(20)
    respond_to do |format|
      format.json {render json: {clinics: clinics.as_json(custom: true)}, status: :ok}
      format.html {render nothing: true}
    end
  end
end