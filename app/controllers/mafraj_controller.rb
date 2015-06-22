class MafrajController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :generer_ressources
  before_action :fin_construction
  before_action :file_attente

  def index
  end

  def ameliorer
    message = current_user.mafraj.ameliorer params[:batiment]
    flash[:error] = message unless message.empty?

    redirect_to mafraj_index_path
  end

  def archiver
    case params[:ressource]
      when "fumee"
        current_user.mafraj.archiver("fumee")
      when "the"
        current_user.mafraj.archiver("the")
    end

    redirect_to :back
  end
end
