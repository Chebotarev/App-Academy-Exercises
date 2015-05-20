require 'active_support/inflector'
require_relative './params'
require_relative './session'
require_relative './flash'

class ControllerBase
  attr_reader :req, :res, :params

  # Setup the controller
  def initialize(req, res, route_params = {})
    @req = req
    @res = res

    @params = Params.new(req, route_params)

    @already_built_response = false
  end

  # Helper method to alias @already_built_response
  def already_built_response?
    @already_built_response
  end

  def invoke_action(name)
    self.send(name.to_sym)
    render(name) unless already_built_response?
  end

  # Set the response status code and header
  def redirect_to(url)
    raise "Already built response" if already_built_response?
    res["Location"] = url
    res.status = 302

    flash.store_flash(res)
    session.store_session(res)

    @already_built_response = true
  end

  def render(template_name)
    controller_name = self.class.to_s.underscore
    contents = File.read("views/#{controller_name}/#{template_name}.html.erb")
    erb_template = ERB.new(contents)
    eval_content = erb_template.result(binding)
    render_content(eval_content, "text/html")
  end

  # Populate the response with content.
  # Set the response's content type to the given type.
  # Raise an error if the developer tries to double render.
  def render_content(content, content_type)
    raise "Already built response" if already_built_response?
    res.content_type = content_type
    res.body = content

    session.store_session(res)
    flash.store_flash(res)

    @already_built_response = true
  end

  def session
    @session ||= Session.new(req)
  end

  def flash
    @flash ||= Flash.new(req)
  end
end
