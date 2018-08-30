# frozen_string_literal: true

class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end

  def self.presents(name)
    define_method(name) do
      @object
    end
  end

  private_class_method :presents

  private

  def h
    @template
  end
end