module RouteHelpers
  # <%= link_to "link name", link_dest %>
  # link_to "cats!", cats_url
  def link_to(name, destination, options = {})
    "<a href=\"#{destination}\">#{name}</a>"
  end

  def button_to(name, destination, options = {})
    options[:method] ||= "post"
    <<-HTML
      <form action="#{destination}" method="post">
        <input type="hidden" name="_method" value="#{options[:method].to_s}">

        <input type="submit" value="#{name}">
      </form>
    HTML
  end
end
