
# This class is the controller for the Devices resource. It handles the CRUD operations for the Devices resource.
class DevicesController < ApplicationController

  before_action :set_device, only: [:show, :latest_timestamp, :cumulative_count]
  
  # GET /devices
  # Returns a JSON array of all devices
  def index
    devices = devices_hash.values
    render json: devices, status: :ok
  end

  # GET /devices/:id
  # Returns a JSON object of the device with the specified id
  # If the device is not found, returns a JSON object with an error message and a 404 status code
  def show
    if @device
      render json: @device, staus: :ok
    else
      render json: { error: "Device not found" }, status: :not_found
    end
  end

  # POST /devices
  # Creates a new device with the specified id and readings
  # If the device already exists, updates the existing device with the new readings
  # Returns a JSON object of the created/updated device with a 201 status code
  # If the device is invalid, returns a JSON object with an error message and a 422 status code
  def create
    if devices_hash.key?(device_params[:id])
      device = devices_hash[device_params[:id]]
    else
      device = Device.new(device_params.except(:readings))
    end

    readings_array = device_params.fetch(:readings, [])
    readings_array.each do |reading|
      existing_reading = device.readings.find { |r| r.timestamp == reading[:timestamp] }
    
      if !existing_reading
        reading = Reading.new(reading)
        device.readings << reading if reading.valid?
      end
    end

    if device.valid?
      devices_hash[device.id] = device      
      render json: device, status: :created
    else
      render json: { errors: device.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # GET /devices/:id/latest_timestamp
  # Returns a JSON object with the latest timestamp for the device with the specified id
  # If the device is not found, returns a JSON object with an error message and a 404 status code
  # If the device has no readings, returns a JSON object with an error message and a 404 status code
  def latest_timestamp
    latest_reading = @device.readings.max_by { |reading| reading.timestamp }
    if latest_reading
      render json: { latest_timestamp: latest_reading.timestamp}
    else
      render json: { error: "No readings for this device" }, status: :not_found
    end
  end

  # GET /devices/:id/cumulative_count
  # Returns a JSON object with the cumulative count for the device with the specified id
  # If the device is not found, returns a JSON object with an error message and a 404 status code
  def cumulative_count
    

    total_count = @device.readings.sum { |r| r.count }
    render json: { cumulative_count: total_count }
  end

  private

  def devices_hash
    @@devices ||= {}
  end

  def set_device
    @device = devices_hash[params[:id]]

    unless @device
      render json: { error: "Device not found" }, status: :not_found
      return
    end
  end

  # Strong parameters for the device resource
  def device_params
    params.require(:device).permit(:id, readings: [:timestamp, :count])
  end
end
