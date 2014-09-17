module AdminLTE
  module Rails
    class Engine < ::Rails::Engine
      initializer :images do |app|
        app.config.assets.precompile += %w( auth.css auth.js iCheck/flat/_all.css )
        app.config.assets.precompile << /\.(?:svg|eot|woff|ttf)\z/
        app.config.assets.precompile += %w(*.png *.jpg *.jpeg *.gif)
      end
    end
  end
end