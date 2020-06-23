#==============================================================================
# Real-Time-Show
# ----------------------------------------------------------------------------
# Version 1.0  (21.10.2011)
# Von Evil95
#==============================================================================
# Uhrzeit mit "$rts = RTS.new" aufrufen.
# Mit "$rts.dispose" kann das Fenster wieder geschlossen werden.
#==============================================================================
class RTS < Window_Base
  def initialize
    super(180, 50, 188, 64)
    self.contents = Bitmap.new(width - 32, height - 32)
    refresh
  end
  def refresh
    stunde = Time.new.strftime("%H")
    minute = Time.new.strftime("%M")
    self.contents.clear
    self.contents.draw_text(0, -1, 256, 32, "Es ist jetzt "+stunde+":"+minute+".")
  end
end