class HighscoreController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :generer_ressources

  def index
    @mafraj = Mafraj.all.order('kebab desc')
  end
end
