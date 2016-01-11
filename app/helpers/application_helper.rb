module ApplicationHelper
  #Builds top navigation. Accepts accessible controllers as array. Action called is by default :index
  def build_top_nav(controllers = [])
    capture do #starts output buffer
      for c in controllers
        c = c.to_sym
        next if cannot? :see_menu, c
        active = controller_name.to_sym == c ? 'active' : ''
        c_name = controller_label_for c
        link_to = link_to(c_name, controller: c, action: :index)
        concat content_tag(:li, link_to, class: active) #concat writes to output buffer
      end
    end
  end

  #Builds sub navigation depending on active controller and action. Accepts pagetree as options hash and optional controller name
  def build_sub_nav(options = {}, c_name = '')
    controller = controller_name.to_sym
    controller = c_name.to_sym unless c_name.blank? # Overwrites Controller name
    actions = options[controller].to_a

    capture do #starts output buffer
      for a in actions
        a = a.to_sym
        active = current_page?(controller: controller, action: a) ? 'active' : '' #adds active class if page is current page
        a_name = action_label_for(controller, a)
        link_to = link_to(a_name, controller: controller, action: a)

        concat content_tag(:li, link_to, class: active)
      end
    end
  end

  #TODO: add translations to I18n file
  def action_label_for(controller, action)
    I18n.t action.to_sym, scope: controller.to_s, default: action.to_s.humanize
  end

  def controller_label_for(controller)
    I18n.t controller.to_sym, scope: 'controllers', default: controller.to_s.humanize
  end

  #Returns the correct bootstrap css class for a given flash type
  def bootstrap_flash_class_for(name)
    case name.to_sym
      when :notice then "alert alert-info"
      when :success then "alert alert-success"
      when :alert then "alert alert-danger"
      else "alert alert-info"
    end
  end
end
