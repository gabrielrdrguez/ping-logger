class IpsController < ApplicationController
  protect_from_forgery with: :exception
   def index
     @ips = Ip.all
   end
  def create
    Ip.create(ip: create_ip_params[:ip], descricao: create_ip_params[:descricao])
    redirect_to ips_path
  end



  def create_ip_params
    params.require(:ip).permit(:ip, :descricao)
  end

  def destroy
    Ip.find(params[:id]).destroy
    redirect_to ips_path
  end

end
