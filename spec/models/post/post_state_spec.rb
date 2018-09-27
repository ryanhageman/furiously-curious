# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Post, type: :model do
  let(:subject) { build_stubbed(:post) }

  context 'state' do
    it 'should go from draft to published' do
      expect(subject)
        .to transition_from(:draft)
        .to(:published)
        .on_event(:publish)
    end

    it 'should go from hidden to published' do
      expect(subject)
        .to transition_from(:hidden)
        .to(:published)
        .on_event(:publish)
    end

    it 'should go from published to hidden' do
      expect(subject)
        .to transition_from(:published)
        .to(:hidden)
        .on_event(:hide)
    end

    it 'should not go from draft to hidden' do
      expect(subject).not_to allow_event(:hide)
    end

    it 'should go from published to draft' do
      expect(subject)
        .to transition_from(:published)
        .to(:draft)
        .on_event(:save_as_draft)
    end

    it 'should go from hidden to draft' do
      expect(subject)
        .to transition_from(:hidden)
        .to(:draft)
        .on_event(:save_as_draft)
    end
  end
end
