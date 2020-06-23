#==============================================================================
# Vollbildabfrage vor Spielstart
# ----------------------------------------------------------------------------
# Version 1.0 (30.7.08)
# Von Evil95
#==============================================================================
# In "Main" muss "$scene = Scene_Title.new" mit "$scene = Scene_Fullscreen.new"
# ersetzt werden.
# Wichtig: Dieses Script funktioniert nur mit dem "Fullscreen++ v2.2" Script.
#==============================================================================
class Window_Fullscreen < Window_Base
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
class Scene_Fullscreen < Scene_Base
  def main
    if $keybd || $BTEST  || $TEST   
      $scene = Scene_Title.new
    else
      super                     
    end
  end
  def start
    super
    $data_system = load_data('Data/System.rvdata')  
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
    @fullscreen_window.update
    @command_window.update
    if Input.trigger?(Input::C)
      Sound.play_decision
      case @command_window.index
      when 0; command_fullscreen        
      when 1; command_windowed
      end
    end
  end
  def create_windows
    str = 'Im Vollbildmodus starten?'
    @fullscreen_window = Window_Fullscreen.new(str)        
    @fullscreen_window.x = (544 - @fullscreen_window.width) / 2
    commands = ['Ja', 'Nein']
    @command_window = Window_Command.new(128, commands)
    @command_window.x = (544 - @command_window.width) / 2
    @command_window.y = 288
    @command_window.openness = 0
    @command_window.open
  end
  def dispose_windows
    @fullscreen_window.dispose
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
  def command_fullscreen
    Graphics.fullscreen_mode
    $scene = Scene_Title.new
  end  
  def command_windowed
    Graphics.windowed_mode
    $scene = Scene_Title.new
  end
end