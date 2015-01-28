class Url < ActiveRecord::Base
  belongs_to :user
  validates :short_url, uniqueness: true
  # Remember to create a migration!
  before_save(on: :create) do
    uri?(self.long_url)
  end

  def uri?(string)
    uri = URI.parse(string)
    %w( http https ).include?(uri.scheme)
  rescue URI::BadURIError
    false
  rescue URI::InvalidURIError
    false
  end
end
