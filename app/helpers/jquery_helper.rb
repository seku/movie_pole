module JqueryHelper

  def document_ready(&block)
    concat(javascript_tag{"$(document).ready(function(){#{block_given? ? capture(&block) : nil}});"})
  end
  
  def delay(seconds, &block)
    "setTimeout(function(){#{block_given? ? capture(&block) : nil}}, #{seconds * 1000})"
  end
  
  def render_authenticity_token
    return unless protect_against_forgery?
    "window._authenticity_token = '#{form_authenticity_token}'\n"
  end
  
  def capture_for_document_ready(variable_name, &block)
    unless instance_variable_defined?("@#{variable_name}") 
      captured = capture do
        if block_given?
          capture(&block)
        end
      end
      instance_variable_set("@#{variable_name}", captured)
      content_for :document_ready, captured
    end
  end
  
  def jquery_data(selector, key, value)
    "$('#{selector}').data('#{key}', #{value.to_json});\n"
  end
  
  def jquery_data_get(selector, key)
    "$('#{selector}').data('#{key}')"
  end
  
  def options_for_jquery(options)
    raise ArgumentError unless options.is_a?(Hash)
    "{" +
    options.map do |k, v|
      if v.is_a?(Hash)
        "\"#{k}\": #{options_for_jquery(v)}"
      else
        (v.is_a?(String) && v.starts_with?("js:")) ? "\"#{k}\": #{v.sub!('js:', '')}" : "\"#{k}\": #{v.to_json}"
      end
    end.join(", ") + "}"
  end
  
  def onclick(selector, &block)
    "$('#{selector}').click(function() {#{block_given? ? capture(&block) : nil}});\n"
  end
  
  def onchange(selector, &block)
    "$('#{selector}').change(function() {#{block_given? ? capture(&block) : nil}});\n"
  end
  
  def onkeyup(selector, &block)
    "$('#{selector}').keyup(function() {#{block_given? ? capture(&block) : nil}});\n"
  end

  def get(path, options = {})
    if options[:update]
      "$.get('#{path}', function(data){$('##{options[:update]}').html(data)});"
    else
      "$.get('#{path}');"
    end
  end
  
  def function(code)
    "function() {#{code}}"
  end
  
  

end
