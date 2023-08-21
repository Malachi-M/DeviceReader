# This controller manages the devices resource. It allows to list all devices and create a new device.
class DevicesController < ApplicationController
  @@devices = []

  # GET /devices
  # Returns a JSON array of all devices.
  def index
    render json: @@devices, status: :ok
  end

  # POST /devices
  # Creates a new device with the given parameters.
  # If the device is valid, it is added to the list of devices and returned as JSON.
  # If the device is invalid, an error message is returned as JSON.
  def create
    device = Device.new(device_params)

    readings = params.dig(device, :readings) || []
    
    readings.each do |reading|
      Reading.new(reading)
    end

    if device.valid?
      @@devices << device      
      render json: device, status: :created
    else
      render json: { errors: device.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  # Only allows the 'id' parameter to be passed in the request.
  def device_params
    params.require(:device).permit(:id, readings: [:timestamp, :count])
  end

end


# /devices/:id/readings/