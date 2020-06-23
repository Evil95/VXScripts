#==============================================================================
# Help/Steuerung Window
# ----------------------------------------------------------------------------
# Version 1.1  (24.10.15)
# Von Evil95
#==============================================================================

# ----------------------------------------------------------------------------
# Aufrufen mit "$help = Help.new" via Skript...(Eventseite 3)
# Entfernen mit "$help.dispose" via Skript...(Eventseite 3)
# ----------------------------------------------------------------------------

class Help < Window_Base
  def initialize
    super(160, 50, 253, 305) #(X position, Y position, width, height) 
    self.contents = Bitmap.new(width - 32, height - 32)
    refresh
  end
  def refresh
    self.contents.clear
    self.contents.draw_text(0, 0, 256, 32, "  Erklärung Abkürzungen")
    self.contents.draw_text(0, 40, 256, 32, "HP = Lebenspunkte")
    self.contents.draw_text(0, 60, 256, 32, "MP = Magiepunkte")
    self.contents.draw_text(0, 80, 256, 32, "ATK = Angriffswert")
    self.contents.draw_text(0, 100, 256, 32, "DEF = Verteidigungswert")
    self.contents.draw_text(0, 120, 256, 32, "INT = Intelligenz")
    self.contents.draw_text(0, 140, 256, 32, "TEM = Tempo")
    self.contents.draw_text(0, 160, 256, 32, "LV = Level")
    self.contents.draw_text(0, 180, 256, 32, "Exp = Erfahrungspunkte")
    self.contents.draw_text(0, 220, 256, 32, "       Drücke Enter um")
    self.contents.draw_text(0, 240, 256, 32, "          fort zufahren.")
  end
end