module BootstrapFlashMessages
  module FlashMessages
    def redirect_to(options = {}, response_status_and_flash = {})
      messages = response_status_and_flash[:flash]
      if messages && (messages.is_a?(Symbol) || messages.is_a?(Array))
        flashes = {}
        locals = response_status_and_flash[:locals]
        if messages.is_a?(Array)
          messages.each do |key|
            flashes[key] = flash_messages(key, locals)
          end
        else
          flashes[messages] = flash_messages(messages, locals)
        end
        response_status_and_flash.delete(:locals)
        response_status_and_flash[:flash] = flashes
      end
      super(options, response_status_and_flash)
    end

  private

    def flash!(*args)
      options = args.extract_options!
      args.each do |key|
        flash[key] = flash_messages(key, options[:locals])
      end
    end

    def flash_now!(*args)
      options = args.extract_options!
      args.each do |key|
        flash.now[key] = flash_messages(key, options[:locals])
      end
    end

    def flash_messages(key, *args)
      i18n_key = "flash_messages.#{params[:controller]}.#{params[:action]}.#{key}"
      options = args.extract_options!
      options[:default] = i18n_key.to_sym
      I18n.t(i18n_key.gsub(/\//, ".").html_safe, options)
    end
  end
end
