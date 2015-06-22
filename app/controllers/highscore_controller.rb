class HighscoreController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :generer_ressources
  before_action :file_attente

  def index
    @mafraj = Mafraj.all.order('kebab desc')
  end
end
