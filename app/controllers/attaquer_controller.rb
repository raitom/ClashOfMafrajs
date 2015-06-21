class AttaquerController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!
  before_action :generer_ressources

  def index
    @mafraj = Mafraj.where.not(user_id: current_user.id).order("RANDOM()").limit(1)
    @mafraj = @mafraj.first unless @mafraj.nil?
  end

  def preparation
    @zamels = params[:zamels].to_i
    @user_id_attaque = params[:user_id_attaque]

    unless @zamels.nil?
      if @zamels > current_user.mafraj.armee.zamel
        flash[:error] = "Pas assez de zamels"
        redirect_to :back
      end
    end
  end

  def attaquer
    zamels = params[:zamels]
    user_id_attaque = params[:user_id_attaque]
    mafraj = current_user.mafraj
    armee = mafraj.armee

    if !zamels.nil? && !user_id_attaque.nil?
      zamels = zamels.to_i

      if zamels > mafraj.armee.zamel
        flash[:error] = "Pas assez de zamels. N'essaye pas de tricher ou ton compte sera transformé en nigger."
      else
        user_id_attaque = user_id_attaque.to_i

        armee.zamel -= zamels
        armee.save

        AttaquerMafrajJob.set(wait: 5.minutes).perform_later(current_user.id, zamels, user_id_attaque)

        flash[:success] = "Attaque lancée ! Résultat dans 5 minutes"
      end
    else
      flash[:error] = "Erreur lors de l'attaque du Mafraj. Le créateur de ce jeu est sûrement un nigger."
    end

    redirect_to attaquer_index_path
  end
end
