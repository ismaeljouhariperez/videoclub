module ApplicationHelper
  def active_class(link_path)
    current_page?(link_path) ? 'nav-link active' : 'nav-link'
  end
end
