class AmeliorerTheiereJob < ActiveJob::Base
  queue_as :default

  def perform(mafraj)
    mafraj.theiere += 1
    mafraj.save
  end
end
