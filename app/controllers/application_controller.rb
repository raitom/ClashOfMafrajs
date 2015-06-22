class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  private
  def generer_ressources
    current_user.mafraj.generer_ressources
  end

  def fin_construction
    mafraj = current_user.mafraj

    unless mafraj.type_construction.nil?
      if mafraj.date_fin_construction <= Time.now
        mafraj.date_fin_construction = nil

        case mafraj.type_construction
          when "theiere"
            mafraj.theiere += 1
          when "chicha"
            mafraj.chicha += 1
          when "mafraj"
            mafraj.niveau += 1
        end

        mafraj.type_construction = nil
        mafraj.save
      else
        temps_restant = ((mafraj.date_fin_construction - Time.now) / 60.0)
        flash[:success] = "Construction en cours : #{mafraj.type_construction}, temps restant : #{temps_restant.round(2)} minutes"
      end
    end
  end

  def file_attente
    @file_attente = FileAttente.where(mafraj_id: current_user.mafraj.id)
  end
end
