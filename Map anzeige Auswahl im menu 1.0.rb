#==============================================================================
# Map-Anzeige-Auswahl im Menu
# ----------------------------------------------------------------------------
# Version 1.0  (9.8.08)
# Von Evil95
#==============================================================================
class Scene_Menu < Scene_Base
  def create_command_window
    s1 = Vocab::item
    s2 = Vocab::skill
    s3 = Vocab::equip
    s4 = Vocab::status
    s5 = Vocab::save
    s6 = Vocab::game_end
    if $game_switches[2] == true
    s7 = "Map ein"
    else
    s7 = "Map aus"
    end
    @command_window = Window_Command.new(160, [s1, s2, s3, s4, s5, s6, s7])
    @command_window.index = @menu_index
    if $game_party.members.size == 0          # If number of party members is 0
      @command_window.draw_item(0, false)     # Disable item
      @command_window.draw_item(1, false)     # Disable skill
      @command_window.draw_item(2, false)     # Disable equipment
      @command_window.draw_item(3, false)     # Disable status
    end
    if $game_system.save_disabled             # If save is forbidden
      @command_window.draw_item(4, false)     # Disable save
    end
  end
  #--------------------------------------------------------------------------
  # * Update Command Selection
  #--------------------------------------------------------------------------
  def update_command_selection
    if Input.trigger?(Input::B)
      Sound.play_cancel
      $scene = Scene_Map.new
    elsif Input.trigger?(Input::C)
      if $game_party.members.size == 0 and @command_window.index < 4
        Sound.play_buzzer
        return
      elsif $game_system.save_disabled and @command_window.index == 4
        Sound.play_buzzer
        return
      end
      Sound.play_decision
      case @command_window.index
      when 0      # Item
        $scene = Scene_Item.new
      when 1,2,3  # Skill, equipment, status
        start_actor_selection
      when 4      # Save
        $scene = Scene_File.new(true, false, false)
      when 5      # End Game
        $scene = Scene_End.new
      when 6
        if $game_switches[2] == true
          $game_switches[2] = false
        else
          $game_switches[2] = true
        end
        $scene = Scene_Menu.new(6)
      end
    end
  end
end