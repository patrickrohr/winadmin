module Abilities
  @cans = {}
  @controllers = []

  def can(action, controller)
    self.class.cans[key(action, controller)] = true
  end

  def can_access(controller)
    self.class.controllers[controller.downcase] = true
  end

  def cannot(action, controller)
    self.class.cans[key(action, controller)] = false
  end

  def cannot_access(controller)
    self.class.controllers[controller.downcase] = true
  end

  def can?(action, controller)
    if self.class.cans[key(action, controller)]
      return true
    elsif self.class.controllers[controller.downcase]
      return true
    end
    return false
  end

  def authorize!(action, controller)
    unless can?(action, controller)
      raise "Access not permitted"
    end
  end

  private
  def key(action, controller)
    (action.downcase + controller.downcase).to_sym
  end
end