#==============================================================================
# ** Scene_Menu_for_Simple_Questlog_by_Evil95
#------------------------------------------------------------------------------
#  This class performs the menu screen processing.
#==============================================================================
# Important: Overwrites Original Scene_Menu completly!
#==============================================================================
class Scene_Menu < Scene_Base
  def create_command_window
    s1 = Vocab::item
    s2 = Vocab::skill
    s3 = Vocab::equip
    s4 = Vocab::status
    s7 = "Questlog"
    s5 = Vocab::save
    s6 = Vocab::game_end
    @command_window = Window_Command.new(160, [s1, s2, s3, s4, s7, s5, s6])
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
      when 5      # Save
        $scene = Scene_File.new(true, false, false)
      when 6      # End Game
        $scene = Scene_End.new
      when 4
        $scene = Scene_Questlog.new
      end
    end
  end
end
class Scene_File < Scene_Base
  def return_scene
    if @from_title
      $scene = Scene_Title.new
    elsif @from_event
      $scene = Scene_Map.new
    else
      $scene = Scene_Menu.new(5)
    end
  end
end

class Scene_End < Scene_Base
  def return_scene
    $scene = Scene_Menu.new(6)
  end
end

class Scene_Questlog < Scene_Base
  def return_scene
    if @from_menu
      $scene = Scene_Menu.new(4)
    else
      $scene = Scene_Map.new
    end
  end
end