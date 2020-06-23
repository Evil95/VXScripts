#==============================================================================
# No Window
# ----------------------------------------------------------------------------
# Version 1.0  (5.8.08)
# Von Evil95
#==============================================================================
class Window_Base < Window 
def initialize(x, y, width, height)
    super()
    self.windowskin = Cache.system("Window")
    self.x = x
    self.y = y
    self.width = width
    self.height = height
    self.z = 100

    if $game_variables[1] == 1 #wenn variable 1 0 ist, ist alles transparent, wenn variable 1 1 ist, ist alles normal
    self.back_opacity = 200
    else
    self.back_opacity = 0
    self.opacity = 0
    end
  
    self.openness = 255
    create_contents
    @opening = false
    @closing = false
  end
end