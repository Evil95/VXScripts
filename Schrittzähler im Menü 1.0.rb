#==============================================================================
# Schrittzähler im Menü
# ----------------------------------------------------------------------------
# Version 1.0  (21.10.2011)
# Von Evil95
#==============================================================================
class Schrittzähler < Window_Base
  def initialize
    super(0, 236, 160, 64)
    self.contents = Bitmap.new(width - 32, height - 32)
    refresh
  end
  def refresh
    self.contents.clear
    self.contents.font.color = system_color
    self.contents.font.size = 12
    self.contents.draw_text(4, -25, 120, 64, "Schritte")
    self.contents.font.color = normal_color
    self.contents.font.size = 20
    self.contents.draw_text(4, 5, 120, 32, $game_party.steps.to_s, 2)
  end
end

class Scene_Menu < Scene_Base
  alias :start_schritt :start 
  def start
  def_start_schritt
  @steps_window = Schrittzähler.new(0,270)
  end
  
  alias :terminate_schritt :terminate
  def terminate
  @steps_window.dispose
  end
  
  alias :update_schritt :update
  def update
  @steps_window.update
  end
end
 