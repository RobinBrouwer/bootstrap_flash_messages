require 'bootstrap_flash_messages/helpers'
require 'bootstrap_flash_messages/flash_messages'

module BootstrapFlashMessages
  ALERT_CLASS_MAPPING = Hash.new(:info).merge(:notice => :success, :success => :success, :warning => :warning, :error => :danger).freeze
  
  def self.alert_class_mapping(key)
    ALERT_CLASS_MAPPING[key.to_sym]
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
