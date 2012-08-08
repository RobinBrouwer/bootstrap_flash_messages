module BootstrapFlashMessages
  module Helpers
    def flash_messages(*args)
      if flash.present?
        block = args.include?(:block)
        show_heading = args.include?(:heading)
        show_close = args.include?(:close)
        
        messages = []
        flash.each do |key, value|
          heading = ""
          if show_heading
            heading_text = I18n.t("flash_messages.headings.#{key}")
            heading = (block ? content_tag(:h4, heading_text, :class => "alert-heading") : content_tag(:strong, heading_text))
          end
          close = ""
          if show_close
            close = link_to("x", "#", :class => "close", :data => { :dismiss => "alert" })
          end
          
          messages << content_tag(:div, :class => "alert alert-#{key} #{"alert-block" if block}") do
            close + heading + " " + value
          end
        end
        raw(messages.join)
      end
    end
  end
end
