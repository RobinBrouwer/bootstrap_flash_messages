require 'bootstrap_flash_messages/helpers'
require 'bootstrap_flash_messages/flash_messages'

module BootstrapFlashMessages
  @alert_class_mapping = { :notice => :success, :success => :success, :info => :info, :warning => :warning, :error => :danger }
  
  def self.alert_class_mapping(key)
    @alert_class_mapping[key.to_sym]
  end
  
  def self.initialize
    return if @initialized
    raise "ActionController is not available yet." unless defined?(ActionController)
    ActionController::Base.send(:helper, BootstrapFlashMessages::Helpers)
    ActionController::Base.send(:include, BootstrapFlashMessages::FlashMessages)
    @initialized = true
  end
end

if defined?(Rails::Railtie)
  require 'bootstrap_flash_messages/railtie'
end
