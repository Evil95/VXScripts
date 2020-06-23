#==============================================================================
# Menü in Scene_Gameover
# ----------------------------------------------------------------------------
# Version 1.1
# Von Evil95
#==============================================================================
class Scene_Gameover < Scene_Base
  alias gameover start
  def start
    create_command_window
    gameover
  end
  def create_command_window
    s1 = Vocab::continue
    s2 = Vocab::shutdown
    s3 = Vocab::to_title
    @command_window = Window_Command.new(172,[s1,s2,s3])
    @command_window.x = (544 - @command_window.width) / 2
    @command_window.y = 288
    @command_window.index = 2
    @continue_enabled = (Dir.glob('Save*.rvdata').size > 0)
    if @continue_enabled
      @command_window.index = 0
    else
      @command_window.draw_item(0, false)
    end
    @command_window.openness = 0
    @command_window.open
  end
  def post_start
    super
    open_command_window
  end
  def pre_terminate
    super
    close_command_window
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
  def update
    @command_window.update
    if Input.trigger?(Input::C)
      case @command_window.index
      when 0
        if @continue_enabled
          Sound.play_decision
          $scene = Scene_File.new(false, true, false)
          Graphics.fadeout(60)
        else
          Sound.play_buzzer
        end
      when 1
        Sound.play_decision
        RPG::BGM.fade(800)
        RPG::BGS.fade(800)
        RPG::ME.fade(800)
        $scene = nil
      when 2
        Sound.play_decision
        $scene = Scene_Title.new
        Graphics.fadeout(60)
      end
    end
  end
end