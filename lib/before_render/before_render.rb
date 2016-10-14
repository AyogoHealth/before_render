module BeforeRender
  extend ActiveSupport::Concern

  include ActiveSupport::Callbacks

  included do
    define_callbacks :render
  end

  module ClassMethods
    def before_render(*names, &blk)
      _insert_callbacks(names, blk) do |name, options|
        set_callback(:render, :before, name, options)
      end
    end

    def prepend_before_render(*names, &blk)
      _insert_callbacks(names, blk) do |name, options|
        set_callback(:render, :before, name, options.merge(:prepend => true))
      end
    end

    def skip_before_render(*names)
      _insert_callbacks(names) do |name, options|
        skip_callback(:render, :before, name, options)
      end
    end

    alias_method :append_before_render, :before_render
  end
end

AbstractController::Base.send :include,  BeforeRender
