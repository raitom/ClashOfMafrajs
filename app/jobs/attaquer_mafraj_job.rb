class AttaquerMafrajJob < ActiveJob::Base
  queue_as :default

  def perform(user_id_attaquant, zamels, user_id_attaque)
    puts zamels
    puts user_id_attaquant
    puts user_id_attaque

    mafraj_attaquant = Mafraj.where(user_id: user_id_attaquant).first
    mafraj_attaque = Mafraj.where(user_id: user_id_attaque).first

    armee_attaquant = Armee.where(mafraj_id: mafraj_attaquant.id).first
    armee_attaque = Armee.where(mafraj_id: mafraj_attaque.id).first

    zamels = zamels.to_i

    if zamels > (armee_attaque.zamel * 2)
      mafraj_attaquant.kebab += 1
      mafraj_attaque.kebab -= 1 if mafraj_attaque.kebab > 0

      the_a_voler = mafraj_attaque.the - (zamels * 5)
      fumee_a_voler = mafraj_attaque.fumee - (zamels * 5)

      the_a_voler = mafraj_attaque.the if the_a_voler <= 0
      fumee_a_voler = mafraj_attaque.fumee if fumee_a_voler <= 0

      mafraj_attaquant.the += the_a_voler
      mafraj_attaquant.fumee += fumee_a_voler
      armee_attaquant.zamel += zamels

      mafraj_attaque.the -= the_a_voler
      mafraj_attaque.fumee -= fumee_a_voler
      armee_attaque.zamel = (armee_attaque.zamel / 2).to_i

      mafraj_attaque.save
      armee_attaque.save

      mafraj_attaquant.save
      armee_attaquant.save
    else
      mafraj_attaquant.kebab -= 1 if mafraj_attaquant.kebab > 0
      mafraj_attaque.kebab += 1

      armee_attaque.zamel += (zamels / 2).to_i

      mafraj_attaquant.save
      mafraj_attaque.save
      armee_attaque.save
    end
  end
end
