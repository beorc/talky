class Talky::InstallGenerator < Rails::Generators::Base
  source_root File.expand_path('../templates', __FILE__)

  def copy_migrations
    rake "talky_engine:install:migrations"
  end

  def add_routes
    route 'draw_talky_routes'
  end
end
