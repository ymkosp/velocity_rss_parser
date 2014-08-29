class Feed < ActiveRecord::Base
  validates :feed_url, :url => "true"

end
