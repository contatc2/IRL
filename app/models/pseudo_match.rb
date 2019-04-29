class PseudoMatch < ApplicationRecord
  mount_uploader :match_two_picture, MatchPictureUploader
  belongs_to :helper, class_name: 'User', foreign_key: 'helper_id'
  belongs_to :match_one, class_name: 'User', foreign_key: 'match_one_id'
end
