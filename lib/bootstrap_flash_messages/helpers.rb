module BootstrapFlashMessages
  module Helpers
    def flash_messages(*args)
      if flash.present?
        block = args.include?(:block)
        show_heading = args.include?(:heading)
        show_close = args.include?(:close)
        unescape_html = args.include?(:html)
        simple_format = args.include?(:simple_format)
        fade = args.include?(:fade)
        fade_in = args.include?(:fade_in)
        
        messages = []
        flash.each do |key, value|
          next if key == :timedout || key == 'timedout'
          
          heading = ""
          if show_heading
            heading_text = I18n.t("flash_messages.headings.#{key}")
            heading = (block ? content_tag(:h4, heading_text, :class => "alert-heading") : content_tag(:strong, heading_text))
          end
          close = ""
          if show_close
            close = content_tag(:button, raw("&times;"), :type => "button", :class => "close", "data-dismiss" => "alert", "aria-hidden" => "true")
          end
          
          value = simple_format(value) if simple_format
          value = raw(value) if unescape_html
          
          messages << content_tag(:div, close + heading + " " + value, :class => "alert alert-#{BootstrapFlashMessages.alert_class_mapping(key)}#{' alert-dismissable' if show_close}#{" fade#{" in" unless fade_in}" if fade || fade_in}")
        end
        
        raw(messages.join)
      end
    end
  end
end
