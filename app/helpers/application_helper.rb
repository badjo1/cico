module ApplicationHelper
# Returns the full title on a per-page basis.
  def full_title(page_title = '')
    base_title = "WIJZER App"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end


  def btn_link_active(text, path)
    options = current_page?(path) ? { class: "btn btn-default active" } : {class: "btn btn-default"}
    link_to text, path, options
  end

  def nav_bar
    content_tag(:ul, class: "nav navbar-nav") do
      yield
    end
  end

  def nav_link(text, path)
    options = current_page?(path) ? { class: "active" } : {}
    content_tag(:li, options) do
      link_to text, path
    end  
  end

  # def show_week?
  #   url_for(:only_path => true).start_with?('/schedule/week')
  # end

end
