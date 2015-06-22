# == Schema Information
#
# Table name: file_attentes
#
#  id         :INTEGER          not null, primary key
#  mafraj_id  :integer
#  type       :varchar
#  message    :text
#  date_fin   :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class FileAttente < ActiveRecord::Base
  belongs_to :mafraj
end
