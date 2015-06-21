# == Schema Information
#
# Table name: armees
#
#  id         :INTEGER          not null, primary key
#  mafraj_id  :integer
#  zamel      :integer          default(0)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Armee < ActiveRecord::Base
  belongs_to :mafraj
end
