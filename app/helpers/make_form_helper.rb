module MakeFormHelper
  def errors
    return "" unless flash[:errors]

    output = "<ul class=\"errors\">"
    flash[:errors].each { |error| output += "<li>#{error}</li>" }
    output += "</ul>"

    output
  end

  def make_form(arg, action, *control_args)
    if arg.is_a?(Array)
      obj = nil
      url_model_name = arg[0].to_s.downcase
      model_name = arg[1].to_s.downcase
    else
      obj = arg
      model_name = obj.class.to_s.singularize.downcase
      url_model_name = model_name.downcase
    end

    _make_form(obj, url_model_name, model_name, action, *control_args)
  end

  def _make_form(obj, url_model_name, model_name, action, *control_args)
    controls_str = control_args.map do |(field, type)|
      control(obj, model_name, field, type)
    end.join("")

    if action == :create
      url    = send(url_model_name.pluralize + "_url")
      submit = "create"
    else
      url    = send(url_model_name + "_url", obj)
      submit = "save"
    end

    if action == :update
      hidden_method = '<input type="hidden" name="_method" value="PATCH" />'
    else
      hidden_method = ''
    end

    output = <<-HTML
      #{errors}
      <form action="#{url}" method="POST">
        <input
          type="hidden"
          name="authenticity_token"
          value="#{form_authenticity_token}"
        >

        #{hidden_method}

        #{controls_str}

        <input type="submit" value="#{submit}">
      </form>
    HTML

    output.html_safe
  end

  def autofocus
    if @autofocus
      ""
    else
      @autofocus = "autofocus"
    end
  end

  def control(obj, model_name, field, type)
    value = obj ? obj[field] : ""

    case type
    when :text, :password
      control_textlike(type, model_name, field, value)
    when :radio
      control_radio(model_name, field, value)
    when :dropdown
      control_dropdown(model_name, field, value)
    when :textarea
      control_textarea(model_name, field, value)
    when :hidden
      control_hidden(model_name, field, value)
    end
  end

  def control_textlike(type, model_name, field, value = "")
    <<-HTML.html_safe
    <label>
      <span>#{field.to_s.titleize}</span>
      <input
        type="#{type}"
        name="#{model_name}[#{field}]"
        value="#{h(value)}"
        #{autofocus}
      / >
    </label>
    HTML
  end

  def control_hidden(model_name, field, value = "")
    <<-HTML.html_safe
    <label>
      <input
        type="hidden"
        name="#{model_name}[#{field}]"
        value="#{h(value)}"
      / >
    </label>
    HTML
  end

  def control_textarea(model_name, field, value = "")
    <<-HTML.html_safe
    <label>
      <textarea
        name="#{model_name}[#{field}]"
        #{autofocus}
      >#{h(value)}</textarea>
    </label>
    HTML
  end

  def control_radio(model_name, field, value)
    m = model_name.camelcase.constantize
    options = m.const_get(field.upcase)

    output = options.map do |option|
      <<-HTML
      <label>
        <input
          type="radio"
          name="#{model_name}[#{field}]"
          value="#{option}"
          #{value == option ? "checked" : ""}
        >
        #{option}
      </label>
      HTML
    end.join("")

    "<span>" + field.to_s.titleize + "</span>" + output
  end

  def control_dropdown(model_name, field, value)
    model_class = model_name.camelcase.constantize

    # field must be like "#{modelname}_id"
    # TODO go into model_class & grab model_class's field assocation class_name

    options_class = field[0..-4].to_s.camelcase.constantize

    output = options_class.all.map do |option|
      <<-HTML
        <option
          type="radio"
          value="#{option.id}"
          #{value == option.id ? "selected" : ""}
        >
        #{option.name}
        </option>
      HTML
    end.join("")

    field.to_s.titleize +
      "<select name=\"#{model_name}[#{field}]\">" +
      output +
      "</select>"
  end
end
