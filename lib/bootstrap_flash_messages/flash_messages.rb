module BootstrapFlashMessages
  module FlashMessages
    def redirect_to(options = {}, response_status_and_flash = {})
      messages = response_status_and_flash[:flash]
      if messages && (messages.is_a?(Symbol) || messages.is_a?(Array))
        flashes = {}
        locals = response_status_and_flash[:locals]
        if messages.is_a?(Array)
          messages.each do |key|
            flashes[key] = flash_messages(params[:controller], params[:action], key, locals)
          end
        else
          flashes[messages] = flash_messages(params[:controller], params[:action], messages, locals)
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
        flash[key] = flash_messages(params[:controller], params[:action], key, options[:locals])
      end
    end

    def flash_now!(*args)
      options = args.extract_options!
      args.each do |key|
        flash.now[key] = flash_messages(params[:controller], params[:action], key, options[:locals])
      end
    end

    def flash_messages(*args)
      options = args.extract_options!
      I18n.t("flash_messages.#{args.join(".")}", options)
    end
  end
end