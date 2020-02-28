class SearchSelectFilterInput < SearchSelectInput
  include ActiveAdminAddons::FilterInput

  def selected_item
    @selected_item ||= selected_collection.first
  end

  def load_control_attributes
    super
    load_data_attr(:width, default: "resolve")
  end

  def input_method
    eq_input_name
  end
end
