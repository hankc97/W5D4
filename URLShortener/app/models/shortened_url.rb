# == Schema Information
#
# Table name: shortened_urls
#
#  id         :bigint           not null, primary key
#  short_url  :string
#  long_url   :string
#  user_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class ShortenedUrl < ApplicationRecord
    validates :short_url, presence: true, uniqueness: true
    validates :user_id, presence: true
    validates :long_url, presence: true

    belongs_to :submitter,
    primary_key: :id,
    foreign_key: :user_id,
    class_name: :User
    
    def self.random_code
        
        short_url = SecureRandom.urlsafe_base64 
        while ShortenedUrl.exists?(:short_url => short_url)
            short_url = SecureRandom.urlsafe_base64 
        end
    return short_url
    end

    def self.short_url_factory(user, long_url)
        ShortenedUrl.create!(:user_id => user.id, :long_url => long_url, :short_url => ShortenedUrl.random_code)
    end
end
