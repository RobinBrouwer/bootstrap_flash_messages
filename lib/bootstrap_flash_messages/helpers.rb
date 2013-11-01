module BootstrapFlashMessages
  module Helpers
    def flash_messages(*args)
      if flash.present?
        block = args.include?(:block)
        show_heading = args.include?(:heading)
        show_close = args.include?(:close)
        unescape_html = args.include?(:html)
        convert_newlines = args.include?(:convert_newlines)
        fade = args.include?(:fade)
        
        messages = []
        flash.each do |key, value|
          heading = ""
          if show_heading
            heading_text = I18n.t("flash_messages.headings.#{key}")
            heading = (block ? content_tag(:h4, heading_text, :class => "alert-heading") : content_tag(:strong, heading_text))
          end
          close = ""
          if show_close
            #close = link_to(raw("&times;"), "#", :class => "close", :data => { :dismiss => "alert" })
            close = content_tag :button, raw("&times;"), :type => 'button', :class => 'close', 'data-dismiss' => 'alert', 'aria-hidden' => 'true'
          end
          
          value.gsub!("\n", "<br/>") if convert_newlines
          
          messages << content_tag(:div, :class => "alert alert-#{BootstrapFlashMessages.alert_class_mapping(key)}#{' alert-dismissable' if show_close}#{" alert-block" if block}#{" fade in" if fade}") do
            close + heading + " " + (unescape_html || convert_newlines ? raw(value) : value)
          end
        end
        raw(messages.join)
      end
    end
  end
end
