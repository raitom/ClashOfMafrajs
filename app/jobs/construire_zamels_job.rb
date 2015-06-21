class ConstruireZamelsJob < ActiveJob::Base
  queue_as :default

  def perform(armee_id, nbre_zamels)
    armee = Armee.find(armee_id)
    armee.zamel += nbre_zamels
    armee.save
  end
end
