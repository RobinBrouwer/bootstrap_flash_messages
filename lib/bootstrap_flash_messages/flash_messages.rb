module BootstrapFlashMessages
  module FlashMessages
    def redirect_to(options = {}, response_status_and_flash = {})
      messages = response_status_and_flash[:flash]
      if messages && (messages.is_a?(Symbol) || messages.is_a?(Array))
        flashes = {}
        if messages.is_a?(Array)
          messages.each do |key|
            flashes[key] = flash_messages(params[:controller], params[:action], key)
          end
        else
          flashes[messages] = flash_messages(params[:controller], params[:action], messages)
        end
        response_status_and_flash[:flash] = flashes
      end
      super(options, response_status_and_flash)
    end

  private

    def flash!(*args)
      args.each do |key|
        flash[key] = flash_messages(params[:controller], params[:action], key)
      end
    end

    def flash_now!(*args)
      args.each do |key|
        flash.now[key] = flash_messages(params[:controller], params[:action], key)
      end
    end

    def flash_messages(*args)
      I18n.t("flash_messages.#{args.join(".")}")
    end
  end
end