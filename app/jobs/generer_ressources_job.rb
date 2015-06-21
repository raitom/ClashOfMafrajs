class GenererRessourcesJob < ActiveJob::Base
  queue_as :default

  def perform(*args)
    Mafraj.all{|m| m.generer_ressources}
  end
end
