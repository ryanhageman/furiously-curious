# frozen_string_literal: true

# If there is no user logged in, this guest user is returned
class GuestUser < User
  def email
    'nope@email.com'
  end
end
