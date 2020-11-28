module ActiveadminAddons
  module Generators
    class InstallGenerator < Rails::Generators::Base
      source_root File.expand_path('../templates', __FILE__)
      class_option :theme, type: :string, default: '', desc: "Use default or 'material' theme"

      def create_initializer
        template "initializer.rb", "config/initializers/activeadmin_addons.rb"
      end

      def add_javascripts
        file_path = 'app/assets/javascripts/active_admin'
        reference = "#= require active_admin/base\n"

        begin
          inject_into_file("#{file_path}.js.coffee", coffee_assets, after: reference)
        rescue
          reference = "//= require active_admin/base\n"
          inject_into_file("#{file_path}.js", js_assets, after: reference)
        end
      end

      def add_stylesheets
        file_path = 'app/assets/stylesheets/active_admin'

        begin
          prepend_file("#{file_path}.scss", css_assets)
        rescue
          prepend_file("#{file_path}.css.scss", css_assets)
        end
      end

      private

      def js_assets
        to_add = "//= require activeadmin_addons/all\n"
        to_add += "//= require active_material\n" if options['theme'] == "material"
        to_add
      end

      def coffee_assets
        to_add = "#= require activeadmin_addons/all\n"
        to_add += "#= require active_material\n" if options['theme'] == "material"
        to_add
      end

      def css_assets
        if options['theme'] == "material"
          to_add = "$am-theme-primary: #342e48;\n"
          to_add += "@import 'active_material';\n"
          to_add += "@import 'activeadmin_addons/all';\n"
          to_add + "@import 'activeadmin_addons/material';\n"
        else
          "@import 'activeadmin_addons/all';\n"
        end
      end
    end
  end
end
