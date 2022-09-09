if Rails.env.test?
  CarrierWave.configure do |config|
    config.storage = :file
    config.enable_processing = false
  end

  # make sure our uploaders are auto-loaded
  Dir.entries("#{Rails.root}/app/uploaders/").each do |file|
    next if %w(. ..).include?(file)
    require "#{Rails.root}/app/uploaders/#{file}"
  end

  # use different dirs when testing
  CarrierWave::Uploader::Base.descendants.each do |klass|
    next if klass.anonymous?
    klass.class_eval do
      def cache_dir
        "#{Rails.root}/spec/support/uploads/tmp"
      end

      def store_dir
        "#{Rails.root}/spec/support/uploads/#{model.class.to_s.underscore}/#{model.id}/#{mounted_as}"
      end
    end
  end
end
