module AdminLTE
  module Rails
    class Engine < ::Rails::Engine
      initializer :images do |app|
        app.config.assets.precompile += %w( auth.css auth.js iCheck/flat/_all.css )
      end
    end
  end
end