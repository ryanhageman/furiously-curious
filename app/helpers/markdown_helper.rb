# frozen_string_literal: true

module MarkdownHelper
  def markdown(text)
    markdown_to_html(text, MARKDOWN_OPTIONS, MARKDOWN_EXTENSIONS)
  end

  private

  MARKDOWN_OPTIONS = {
    filter_html: true,
    prettify: true,
    link_attributes: {
      rel: 'nofollow',
      target: '_blank'
    }
  }

  MARKDOWN_EXTENSIONS = {
    no_intra_emphasis: true,
    fenced_code_blocks: true,
    autolink: true,
    strikethrough: true,
    space_after_headers: true,
    superscript: true,
    underline: true,
    highlight: true,
    footnotes: true
  }.freeze

  class CodeRayTransform < Redcarpet::Render::HTML
    def block_code(code, language)
      language ||= :ruby
      CodeRay.scan(code, language).div
    end
  end

  def highlight_syntax(options)
    CodeRayTransform.new(options)
  end

  def markdown_to_html(text, options, extensions)
    Redcarpet::Markdown
      .new(highlight_syntax(options), extensions)
      .render(text).html_safe
  end
end
