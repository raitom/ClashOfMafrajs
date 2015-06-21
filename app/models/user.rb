# == Schema Information
#
# Table name: users
#
#  id                     :INTEGER          not null, primary key
#  email                  :varchar          default(""), not null
#  encrypted_password     :varchar          default(""), not null
#  reset_password_token   :varchar
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default(0), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :varchar
#  last_sign_in_ip        :varchar
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  after_create :create_mafraj

  has_one :mafraj

  def create_mafraj
    Mafraj.new(nom: self.email, user_id: self.id).save
  end

end
