# frozen_string_literal: true

class LinkComponent < ApplicationComponent
  include Phlex::Rails::Helpers::LinkTo

  CLASS = <<~DEFAULT
    inline-flex items-center justify-center
    rounded-md font-medium transition-colors
    focus-visible:outline-none focus-visible:ring-1 focus-visible:ring-ring
    disabled:pointer-events-none disabled:opacity-50
    text-sky-900 underline-offset-4 hover:underline
    h-9
  DEFAULT

  def initialize(url:, text: nil, size: "lg", **options)
    @text = text
    @url = url
    @options = options
    @size = size
  end

  def template(&)
    if @text.present?
      link_to(@text, @url, class: "#{CLASS} #{text_size}")
    else
      link_to(@url, class: "#{CLASS} #{text_size}", &)
    end
  end

  private

    def text_size = "text-#{@size}"
end
