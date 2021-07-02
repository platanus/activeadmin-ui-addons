module ActiveAdminAddons
  class TagBuilder < CustomBuilder
    def render
      @enum_attr = if enumerize_attr?
                     :enumerize
                   elsif rails_enum_attr?
                     :enum
                   end

      raise "you need to pass an enumerize or enum attribute" unless @enum_attr
      append_tag
    end

    def append_tag
      return context.status_tag(display_data, class: data) unless options[:interactive]

      select_tag
    end

    def select_tag
      context.div class: 'tag-select-container' do
        context.div(interactive_tag_params) do
          context.status_tag(display_data, class: data)
        end

        context.div(interactive_tag_select_params) do
          context.select do
            possible_values.each do |val|
              context.option(value: val, selected: val == data) do
                context.text_node val.capitalize
              end
            end
          end
        end
      end
    end

    def display_data
      @enum_attr == :enumerize ? data.text : data
    end

    def interactive_params(klass)
      {
        'class' => klass,
        'data-model' => class_name,
        'data-object_id' => model.id,
        'data-field' => attribute,
        'data-url' => context.auto_url_for(model),
        'data-value' => data
      }
    end

    def interactive_tag_params
      interactive_tag_class = 'interactive-tag'
      interactive_tag_class += " #{class_name}"
      interactive_tag_class += " #{class_name}-#{attribute}-#{model.id}-tag"
      interactive_tag_class += ' notify-success' if options[:success_message]
      interactive_params(interactive_tag_class)
    end

    def interactive_tag_select_params
      interactive_tag_select_klass = 'interactive-tag-select'
      interactive_tag_select_klass += " #{class_name}-#{attribute}-#{model.id}-select"
      interactive_tag_select_klass += ' select-container-hidden'
      interactive_tag_select_klass += ' default-select'
      interactive_params(interactive_tag_select_klass)
    end

    def possible_values
      klass = model.class
      if @enum_attr == :enumerize
        klass.enumerized_attributes[attribute.to_s].values
      else
        klass.defined_enums[attribute.to_s].keys
      end
    end

    def enumerize_attr?
      data.is_a?("Enumerize::Value".constantize)
    rescue NameError
      false
    end

    def rails_enum_attr?
      defined? Rails && Rails::VERSION::MAJOR == 4 && Rails::VERSION::MINOR >= 1 &&
        model.defined_enums[attribute.to_s]
    end
  end
end

ActiveAdminAddons::TagBuilder.create_view_methods
