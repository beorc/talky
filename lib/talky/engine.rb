module Talky
  class Engine < ::Rails::Engine
    def self.app_path
      File.expand_path('../../', called_from)
    end

    def self.validator_path(name)
      File.expand_path("lib/talky/validators/#{name}.rb", app_path)
    end
  end
end
