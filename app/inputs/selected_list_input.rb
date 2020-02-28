class SelectedListInput < ActiveAdminAddons::InputBase
  def render_custom_input
    concat(label_html)
    concat(render_control_wrapper)
  end

  def load_control_attributes
    load_class(@options[:class])
    load_data_attr(:model, value: builder.object_name)
    load_data_attr(:method, value: method)
    load_data_attr(:url, default: url_from_method)
    load_data_attr(:response_root, default: tableize_method)
    load_data_attr(:fields, default: ["name"], formatter: :to_json)
    load_data_attr(:predicate, default: "contains")
    load_data_attr(:display_name, default: "name")
    load_data_attr(:minimum_input_length, default: 1)
    load_data_attr(:width, default: "100%")
    load_data_attr(
      :order,
      value: @options[:order_by],
      default: get_data_attr_value(:fields).first.to_s + "_desc"
    )
  end

  private

  def render_control_wrapper
    template.content_tag(:div, class: "selected-list-container") do
      template.content_tag(label_html)
      template.concat(render_items_list)
      template.concat(builder.select(build_virtual_attr, [], {}, input_html_options))
    end
  end

  def render_items_list
    template.content_tag(:div, id: selected_values_id, class: "selected-values") do
      template.concat(build_hidden_control(empty_input_id, method_to_input_array_name, ""))
      input_related_items.each { |item| template.concat(render_item(item)) }
    end
  end

  def render_item(item)
    template.content_tag(:div, id: method_to_input_id(item.id), class: "selected-item") do
      template.concat(item_label(item))
      template.concat(
        build_hidden_control(method_to_input_id(item.id), method_to_input_array_name, item.id.to_s)
      )
    end
  end

  def item_label(item)
    item.send(@options[:display_name] || "name")
  end
end
