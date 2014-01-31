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
      options.except(:locals).each do |key, value|
        flash[key] = value
      end
    end

    def flash_now!(*args)
      options = args.extract_options!
      args.each do |key|
        flash.now[key] = flash_messages(key, options[:locals])
      end
      options.except(:locals).each do |key, value|
        flash.now[key] = value
      end
    end

    def flash_messages(key, *args)
      i18n_key = "flash_messages.#{params[:controller]}.#{params[:action]}.#{key}"
      i18n_default_key = "flash_messages.defaults.#{key}"
      i18n_default_action_key = "flash_messages.defaults.#{params[:action]}.#{key}"
      i18n_key.gsub!(/\//, ".")
      options = args.extract_options!
      
      begin
        options[:raise] = true
        translation = I18n.t(i18n_key, options)
      rescue I18n::MissingTranslationData
        begin
          translation = I18n.t(i18n_default_action_key, options)
        rescue I18n::MissingTranslationData
          options[:raise] = false
          translation = I18n.t(i18n_default_key, options)
        end
      end
      
      translation
    end
  end
end
