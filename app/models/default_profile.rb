# frozen_string_literal: true

# Default profile, used if the user has no profile, or if they're a guest user
class DefaultProfile
  def username
    'Anonymous'
  end

  def first_name
    'no first name'
  end

  def last_name
    'no last name'
  end

  def bio
    'Nothing to see here. Move along...'
  end
end
