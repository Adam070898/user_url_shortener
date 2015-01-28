class User < ActiveRecord::Base
  has_many :urls
  # Remember to create a migration!
  def self.authenticate(email, password)
    user = User.where(email: email, password: password).first
    # if (email == user.email && password == user.password)
      return user
    # else return nil; end
  end
end
