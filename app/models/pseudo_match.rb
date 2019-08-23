class PseudoMatch < ApplicationRecord
  mount_uploader :match_two_picture, MatchPictureUploader
  belongs_to :helper, class_name: 'User', foreign_key: 'helper_id'
  belongs_to :match_one, class_name: 'User', foreign_key: 'match_one_id'
  has_one :match

  validates :match_two_email, presence: true
  validates :match_two_first_name, presence: true

  validates :match_two_facebook, presence: true, unless: :match_two_linkedin
  validates :match_two_linkedin, presence: true, unless: :match_two_facebook

  def status
    match_one_accepted == false ? 'Rejected' : 'Pending'
  end
end
