module BootstrapFormsHelper
end

# Adds bootstrap classes to form objects for well designed forms
class BootstrapFormBuilder < ActionView::Helpers::FormBuilder
  def bs_text_field(method, options = {})
    bs_generic_field(method, options, :text_field)
  end

  def bs_number_field(method, options = {})
    bs_generic_field(method, options, :number_field)
  end

  def bs_password_field(method, options = {})
    bs_generic_field(method, options, :password_field)
  end

  def bs_submit(value = nil, options = {})
    options = add_to_css_class(options, 'btn btn-primary')
    @template.submit_tag(value, options)
  end

  def bs_select(method, choices = nil, options = {}, html_options = {}, &block)
    bs_generic_field(method, html_options) do |html_opt|
      @template.select(@object_name, method, choices, options, html_opt)
    end
  end

  def bs_collection_select(method, collection, value_method, text_method, options = {}, html_options = {})
    bs_generic_field(method, html_options) do |html_opt|
      @template.collection_select(@object_name, method, collection, value_method, text_method, options, html_opt)
    end
  end

  def bs_grouped_collection_select(method, collection, group_method, group_label_method, option_key_method, option_value_method, options = {}, html_options = {})
    bs_generic_field(method, html_options) do |html_opt|
      @template.grouped_collection_select(@object_name, method, collection, group_method, group_label_method, option_key_method, option_value_method, options, html_opt)
    end
  end


  private
  # Adds to a css class to options, makes sure to not overwrite any preset classes
  def add_to_css_class(options, attribute)
    unless options.key?(:class)
      options = options.merge({ class: attribute })
    else
      options = options.merge({ class: attribute + ' ' + options[:class].to_s })
    end
    options
  end

  def bs_generic_field(method, options = {}, field_type_or_block = nil)
    options = add_to_css_class(options, 'form-control')
    @template.content_tag(:div, class: 'form-group') do
      @template.label(@object_name, method.to_sym) +
      if block_given?
        yield(options)
      else
        @template.send(field_type_or_block, @object_name, method, options)
      end
    end
  end
end


class BootstrapFormBuilder2 < ActionView::Helpers::FormBuilder
  def text_field(method, options = {})
    options = add_to_css_class options, 'form-control'
    label_for(*args)
    super
  end

  def add_to_css_class(options, attributes)
    options[:class] = [options[:class], attributes].join(' ')
    options
  end
end