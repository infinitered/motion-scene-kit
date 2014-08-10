class SCNNode
  def add_animation(animation_key, params)
    SCNUtils.add_animation(self, animation_key, params)
    self
  end

  def add_transform_animation(animation_key, params)
    params[:attribute] = :transform
    SCNUtils.add_animation(self, animation_key, params)
    self
  end

  def remove_animation(key)
    self.removeAnimationForKey(key.to_s)
    self
  end

  #def position=(value)
    #super
  #end

  #def transform=(value)
    #super
  #end
end
