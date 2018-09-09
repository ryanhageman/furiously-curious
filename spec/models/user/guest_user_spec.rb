# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GuestUser, type: :model do
  it 'should respond to #email' do
    guest_user = GuestUser.new
    expect(guest_user).to respond_to(:email)
  end
end
