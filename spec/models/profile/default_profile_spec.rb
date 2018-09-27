# frozen_string_literal: true

require 'rails_helper'

RSpec.describe DefaultProfile, type: :model do
  subject = DefaultProfile.new

  it 'responds to #username' do
    expect(subject).to respond_to(:username)
  end

  it 'responds to #first_name' do
    expect(subject).to respond_to(:first_name)
  end

  it 'responds to #last_name' do
    expect(subject).to respond_to(:last_name)
  end

  it 'responds to #bio' do
    expect(subject).to respond_to(:bio)
  end
end
