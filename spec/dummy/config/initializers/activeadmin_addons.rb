ActiveadminAddons.setup do |config|
  # Change to "default" if you want to use ActiveAdmin's default select control.
  # config.default_select = "select2"

  # Override default initialization configuration for select2 input in ActiveAdminAddons
  # https://select2.org/configuration/options-api
  # single elements can also be configured through data attributes:
  # f.input attribute, as: :select, input_html: { data: { dropdown_auto_width: true, width: 'auto' } }
  # config.select_config = {
  #   width: 'auto',
  #   dropdownAutoWidth: true
  # }

  # Set default options for DateTimePickerInput. The options you can provide are the same as in
  # xdan's datetimepicker library (https://github.com/xdan/datetimepicker/tree/2.5.4). Yo need to
  # pass a ruby hash, avoid camelCase keys. For example: use min_date instead of minDate key.
  # config.datetime_picker_default_options = {}

  # Set DateTimePickerInput input format. This if for backend (Ruby)
  # config.datetime_picker_input_format = "%Y-%m-%d %H:%M"
end
