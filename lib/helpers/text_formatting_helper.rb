module TextFormattingHelper
  def smartypants_format(text, options = {})
    options = options.reverse_merge(sanitize: true, sanitize_options: {})

    if options[:sanitize]
      Redcarpet::Render::SmartyPants.render(sanitize(text, options[:sanitize_options]))
    else
      Redcarpet::Render::SmartyPants.render(text)
    end
  end

  def widont_format(text)
    # Only make the final space non-breaking if the final two words fit within
    # 20 characters.
    if text.length > 20 && text[-20..-1][/\s+\S+\s+\S+$/].nil?
      text
    else
      text.gsub(/\s+(?=\S+$)/, "&nbsp;")
    end
  end
end
