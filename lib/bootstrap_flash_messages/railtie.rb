if defined?(Rails::Railtie)
  module BootstrapFlashMessages
    class Railtie < Rails::Railtie
      initializer :bootstrap_flash_messages do
        BootstrapFlashMessages.initialize
      end
    end
  end
end