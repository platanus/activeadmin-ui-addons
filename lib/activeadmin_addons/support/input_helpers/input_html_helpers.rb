module ActiveAdminAddons
  module InputHtmlHelpers
    include InputMethods

    def prefixed_method
      "#{builder.object_name}_#{valid_method}"
    end

    def method_to_input_name
      "#{builder.object_name}[#{valid_method}]"
    end

    def method_to_input_array_name
      "#{method_to_input_name}[]"
    end

    def method_to_input_id(id)
      raise "invalid input id" if id.blank?
      "#{prefixed_method}_#{id}"
    end

    def selected_values_id
      "#{prefixed_method}_selected_values"
    end

    def empty_input_id
      "#{prefixed_method}_empty"
    end

    def build_separator
      template.content_tag(:span, "-", class: "separator")
    end

    def build_hidden_control(id, name, value = nil)
      builder.hidden_field(
        valid_method,
        id: id,
        name: name,
        value: value
      )
    end
  end
end
