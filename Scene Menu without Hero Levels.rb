#==============================================================================
# ** Scene Menu without Hero Levels by Evil95
#------------------------------------------------------------------------------
#  This class performs the menu screen processing.
#==============================================================================
class Window_Status < Window_Base
  def refresh
    self.contents.clear
    draw_actor_name(@actor, 4, 0)
    draw_actor_class(@actor, 128, 0)
    draw_actor_face(@actor, 8, 32)
    draw_basic_info(128, 32)
    draw_parameters(32, 160)
    draw_exp_info(288, 32)
    draw_equipments(288, 160)
  end
end
class Window_SkillStatus < Window_Base
  def refresh
    self.contents.clear
    draw_actor_name(@actor, 4, 0)
    draw_actor_hp(@actor, 240, 0)
    draw_actor_mp(@actor, 392, 0)
  end
end
class Window_MenuStatus < Window_Selectable
  def refresh
    self.contents.clear
    @item_max = $game_party.members.size
    for actor in $game_party.members
      draw_actor_face(actor, 2, actor.index * 96 + 2, 92)
      x = 104
      y = actor.index * 96 + WLH / 2
      draw_actor_name(actor, x, y)
      draw_actor_class(actor, x + 120, y)
      draw_actor_state(actor, x, y + WLH * 2)
      draw_actor_hp(actor, x + 120, y + WLH * 1)
      draw_actor_mp(actor, x + 120, y + WLH * 2)
    end
  end
end