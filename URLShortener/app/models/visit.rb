# == Schema Information
#
# Table name: visits
#
#  id           :bigint           not null, primary key
#  short_url_id :integer
#  user_id      :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Visit < ApplicationRecord

    def self.record_visit!(user, shortened_url)

        return Visit.create!(:user_id => user.id, :short_url_id => shortened_url.id)

    end

    belongs_to :visitor,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User

    belongs_to :view,
    primary_key: :id,
    foreign_key: :short_url_id,
    class_name: :ShortenedUrl

end
