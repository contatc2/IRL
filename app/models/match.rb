class Match < ApplicationRecord
  belongs_to :helper, class_name: 'User', foreign_key: 'helper_id'
  belongs_to :match_one, class_name: 'User', foreign_key: 'match_one_id'
  belongs_to :match_two, class_name: 'User', foreign_key: 'match_two_id'

  def status
    if match_one_accepted && match_two_accepted
      'Accepted'
    else
      'Pending'
    end
  end
end
