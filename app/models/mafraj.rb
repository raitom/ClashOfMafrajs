# == Schema Information
#
# Table name: mafrajs
#
#  id                     :INTEGER          not null, primary key
#  user_id                :integer          not null
#  nom                    :varchar
#  theiere                :integer          default(0)
#  chicha                 :integer          default(0)
#  the                    :integer          default(0)
#  fumee                  :integer          default(0)
#  zamel                  :integer          default(0)
#  nigger                 :integer          default(1)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  kebab                  :integer          default(0)
#  niveau                 :integer          default(1)
#  the_a_recolter         :float            default(0.0)
#  fumee_a_recolter       :float            default(0.0)
#  derniere_recolte_fumee :datetime         default(Mon, 22 Jun 2015 09:14:06 UTC +00:00)
#  derniere_recole_the    :datetime         default(Mon, 22 Jun 2015 09:14:06 UTC +00:00)
#  date_fin_construction  :datetime
#  type_construction      :varchar
#

class Mafraj < ActiveRecord::Base
  belongs_to :user
  has_one :armee
  has_many :file_attente

  after_create :creer_armee

  def creer_armee
    Armee.new(mafraj_id: self.id).save
  end

  def temps_construction lvl
    return 0 if lvl == 0
    (Math.exp(lvl) / 4.0).to_i
  end

  def production lvl
    return 0 if lvl == 0
    lvl ** 2
  end

  def cout_construction lvl
    return 0 if lvl == 0
    lvl ** 3
  end

  def generer_ressources
    nbr_secondes_fumee = (Time.now - self.derniere_recolte_fumee).to_i
    nbr_secondes_the = (Time.now - self.derniere_recole_the).to_i

    self.the_a_recolter += (self.production(self.theiere) / 60.0 ) * nbr_secondes_the
    self.fumee_a_recolter += (self.production(self.chicha) / 60.0) * nbr_secondes_fumee

    self.derniere_recole_the = Time.now
    self.derniere_recolte_fumee = Time.now

    self.save
  end

  def archiver ressource
    case ressource
      when "the"
        self.the += self.the_a_recolter.to_i
        self.the_a_recolter = 0
      when "fumee"
        self.fumee += self.fumee_a_recolter.to_i
        self.fumee_a_recolter = 0
    end

    self.save
  end

  def ameliorer batiment
    case batiment
      when "theiere"
        lvl = self.theiere
        cout_fumee = cout_construction(lvl)
        cout_the = 0
      when "chicha"
        lvl = self.chicha
        cout_fumee = 0
        cout_the = cout_construction(lvl)
      when "mafraj"
        lvl = self.niveau
        cout_the = cout_construction(lvl)
        cout_fumee = cout_construction(lvl)
    end

    temps = temps_construction(lvl)

    if self.the >= cout_the && self.fumee >= cout_fumee
      if self.date_fin_construction.nil?
        self.type_construction = batiment
        self.date_fin_construction = Time.now + temps.minutes
        self.the -= cout_the
        self.fumee -= cout_fumee
        self.save
      else
        return "Construction en cours, les niggers travaillent."
      end
    else
      return "Pas assez de ressources."
    end
  end

  def enlever_the the
    self.the -= the
    self.save
  end

  def enlever_fumee fumee
    self.fumee -= fumee
    self.save
  end


  def self.perform(user_id_attaquant, zamels, user_id_attaque)
    attaquant = User.find(user_id_attaquant)
    attaque = User.find(user_id_attaque)

    mafraj_attaquant = attaquant.mafraj
    mafraj_attaque = attaque.mafraj

    armee_attaquant = mafraj_attaquant.armee
    armee_attaque = mafraj_attaque.armee

    zamels = zamels.to_i

    if zamels > (armee_attaque.zamel * 2)
      mafraj_attaquant.kebab += 1
      mafraj_attaque.kebab -= 1 if attaque.mafraj.kebab > 0

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
