module BeforeRenderInstance
  def render(*opts, &blk)
    run_callbacks :render do
      super(*opts, &blk)
    end
  end
end

ActionController::Base.send :prepend, BeforeRenderInstance
