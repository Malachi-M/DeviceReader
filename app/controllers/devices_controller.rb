class DevicesController < ApplicationController
  @@devices = []

  def index
    render json: @@devices, status: :ok
  end

  def create
    device = Device.new(device_params)
    if device.valid?
      @@devices << device
      render json: device, status: :created
    else
      render json: { errors: device.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def device_params
    params.require(:device).permit(:id)
  end

end
