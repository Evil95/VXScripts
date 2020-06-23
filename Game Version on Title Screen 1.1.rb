#==============================================================================
# Game Version on Title Screen
# ----------------------------------------------------------------------------
# Version 1.1  (23.08.2014)
# Von Evil95
#==============================================================================
$anzeige = 1
class Gameversion < Window_Base
  VERSIONTEXT = "Version: "
  GAMEVERSION = "0.15"
  def initialize
    super(0, 0, 544, 416)
    self.contents = Bitmap.new(width - 32, height - 32)
    self.opacity = 0
    refresh
  end
  def refresh
    self.contents.clear
    self.contents.font.size = 12
    self.contents.font.color = Color.new(255,255,255)
    self.contents.font.shadow = true
    self.contents.font.bold = true
    if $anzeige == 1
      self.contents.draw_text(0, 356, 150, 34, VERSIONTEXT + GAMEVERSION)
    end
    if $anzeige == 2
      self.contents.draw_text(0, 356, 150, 34, GAMEVERSION)
    end
  end
end