# frozen_string_literal: true

# Base Presenter for views
class BasePresenter
  attr_reader :object, :template

  def initialize(object, template)
    @object = object
    @template = template
  end

  def self.presents(name)
    define_method(name) do
      object
    end
  end

  private_class_method :presents

  private

  def h
    template
  end
end
