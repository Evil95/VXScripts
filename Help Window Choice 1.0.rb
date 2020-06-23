#==============================================================================
# Help-Window-Choice
# ----------------------------------------------------------------------------
# Version 1.0  (30.7.08)
# Von Evil95
#==============================================================================
class Window_Hilfe < Window_Base
  def initialize(str)
    super(0, 48, 272, WLH + 32)
    @str = str
    refresh
  end
  def refresh
    self.contents.clear
    self.contents.draw_text(0, 0, 240, WLH, @str, 1)
  end
end
class Scene_Hilfe < Scene_Base
  def main
    super
  end
  def start
    super
    create_windows                                 
  end  
  def post_start
    super
    open_command_window
  end
  def pre_terminate
    super
    close_command_window
  end
  def terminate
    super
    dispose_windows
  end
  def update
    super
    @Hilfe_window.update
    @command_window.update
    if Input.trigger?(Input::C)
      Sound.play_decision
      case @command_window.index
      when 0; command_Hilfe0        
      when 1; command_Hilfe1
      end
    end
  end
  def create_windows
    str = 'Spielsteuerung erklären?'
    @Hilfe_window = Window_Hilfe.new(str)        
    @Hilfe_window.x = (544 - @Hilfe_window.width) / 2
    commands = ['Ja', 'Nein']
    @command_window = Window_Command.new(128, commands)
    @command_window.x = (544 - @command_window.width) / 2
    @command_window.y = 288
    @command_window.openness = 0
    @command_window.open
  end
  def dispose_windows
    @Hilfe_window.dispose
    @command_window.dispose
  end
  def open_command_window
    @command_window.open
    begin
      @command_window.update
      Graphics.update
    end until @command_window.openness == 255
  end
  def close_command_window
    @command_window.close
    begin
      @command_window.update
      Graphics.update
    end until @command_window.openness == 0
  end
  def command_Hilfe0
    Graphics.fadeout(40)
    Graphics.wait(20)
    $game_variables[14] = 1
    $scene = Scene_Map.new
  end  
    def command_Hilfe1
    Graphics.fadeout(40)
    Graphics.wait(20)
    $game_variables[14] = 0
    $scene = Scene_Map.new
  end  
end