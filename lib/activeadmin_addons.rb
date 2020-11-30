module ActiveadminAddons
  extend self

  attr_writer :default_select, :select_config, :datetime_picker_default_options, :datetime_picker_input_format

  def default_select
    return "select2" unless @default_select
    @default_select
  end

  def select_config
    @select_config || {}
  end

  def datetime_picker_default_options
    return {} unless @datetime_picker_default_options
    @datetime_picker_default_options
  end

  def datetime_picker_input_format
    return "%Y-%m-%d %H:%M" unless @datetime_picker_input_format
    @datetime_picker_input_format
  end

  def setup
    yield self
    require "activeadmin_addons"
  end
end

require_relative './activeadmin_addons/engine'
