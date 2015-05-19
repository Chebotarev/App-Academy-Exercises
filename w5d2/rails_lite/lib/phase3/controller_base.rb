require_relative '../phase2/controller_base'
require 'active_support'
require 'active_support/core_ext'
require 'erb'

module Phase3
  class ControllerBase < Phase2::ControllerBase
    # use ERB and binding to evaluate templates
    # pass the rendered html to render_content
    def render(template_name)
      controller_name = self.class.to_s.underscore
      contents = File.read("views/#{controller_name}/#{template_name}.html.erb")
      erb_template = ERB.new(contents)
      eval_content = erb_template.result(binding)
      render_content(eval_content, "text/html")
    end
  end
end
