module ApplicationHelper
  
  def markdown(text)
    renderer = Redcarpet::Render::HTML.new
    markdown = Redcarpet::Markdown.new(renderer, extensions = {
      no_intra_emphasis: true, 
      fenced_code_blocks: true,   
      disable_indented_code_blocks: true,
      autolink: true,
      underline: true,
      quote: true,
      footnotes: true
    })
    
    
    markdown.render(text).html_safe
  end
end
