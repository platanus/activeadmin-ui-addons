module ActiveAdminAddons
  module SelectHelpers
    include InputMethods
    include InputOptionsHandler

    def array_to_select_options
      selected_values = input_value.to_s.split(",")
      array = collection.map(&:to_s) + selected_values
      array.sort.map do |value|
        option = { id: value, text: value }
        option[:selected] = "selected" if selected_values.include?(value)
        option
      end.uniq
    end

    def initial_collection_to_select_options
      initial_options = [[nil]] # add blank option
      selected = selected_item

      if selected
        selected_option = item_to_select_option(selected)
        initial_options << [selected_option[:text], selected_option[:id]]
      end

      initial_options
    end

    def collection_to_select_options
      complete_collection = collection + selected_collection
      complete_collection.map do |item|
        option = item_to_select_option(item)
        yield(item, option) if block_given?

        if selected_collection.include?(item)
          load_data_attr(:selected, value: option.dup, formatter: :to_json)
          option[:selected] = "selected"
        end

        option
      end.uniq
    end

    def item_to_select_option(item)
      return unless item
      display_name = (valid_options[:display_name] || ActiveadminAddons.default_display_name(item))
      {
        id: item.send((valid_options[:value] || :id)),
        text: item.send(display_name)
      }
    end

    def active_record_select?
      active_record_relation?(collection) &&
        active_record_relation?(selected_collection)
    rescue NameError
      false
    end

    def selected_collection
      method_model.where(id: input_value)
    end

    def selected_item
      selected_collection.first
    end

    private

    def active_record_relation?(value)
      klass = value.class.name
      klass == "ActiveRecord::Relation" ||
        klass == "ActiveRecord::Associations::CollectionProxy"
    end

    def valid_options
      raise "missing @options hash" unless !!@options
      @options
    end

    def collection
      valid_options[:collection] || []
    end
  end
end
