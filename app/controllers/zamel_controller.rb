class ZamelController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :generer_ressources

  def index
  end

  def construire
    zamels = params[:zamels].to_i
    mafraj = current_user.mafraj

    if zamels > 0
      if mafraj.the >= zamels * 10 && mafraj.fumee >= zamels * 10
        mafraj.enlever_the(zamels * 10)
        mafraj.enlever_fumee(zamels * 10)
        ConstruireZamelsJob.set(wait: zamels.minutes).perform_later(mafraj.armee.id, zamels)
        flash[:success] = "Les zamels arriveront dans #{zamels} minutes !"
      else
        flash[:error] = "Pas assez de ressources"
      end
    end

    redirect_to zamel_index_path
  end
end
