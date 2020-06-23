#==============================================================================
#  Simple Map-Name
#
#  Version : 1.24 - 12.11.08
#  Created by : hellMinor
#  Do NOT redistribute without my permission
#  Description : A little script to show the name of the current map
#  Note : This script was originally made to cut out the additions to
#         the mapname made by my Day and Night script but it works normally
#         without it.
#
#==============================================================================
# F.A.Q.
#==============================================================================
# If you want a background picture for your mapnames just put a picture
# called "location_back" into the folder "Graphics/System"
#==============================================================================
# Main config
#==============================================================================
  X_POSITION = 10           # Default = 10
  Y_POSITION = 10           # Default = 10
  DELAY = 2                 # How long the Mapname is shown (in seconds)
  ALIGN = 0                 # Align of the Mapname(0 = left, 1 = center, 2 = right)
  PIC_FORMAT = "png"        # Format for the Nightlight-Maps
  COLOR = 255,255,255,255   # Textcolor, default is white (255,255,255,255)
  $show_mapname = true      # Visible ?
#==============================================================================
class Scene_Map
#==============================================================================
  def update_transfer_player
    return unless $game_player.transfer?
    fade = (Graphics.brightness > 0)
    fadeout(30) if fade
    @spriteset.dispose
    dispose_showname_window
    $game_player.perform_transfer
    $game_map.autoplay
    $game_map.update
    Graphics.wait(15)
    @spriteset = Spriteset_Map.new
    fadein(30) if fade
    Input.update
    create_showname_window
  end
#------------------------------------------------------------------------------
  def create_showname_window
    @str = $game_map.name.gsub(/\[\w*\]/) {""}
    @mapname = Window_MapName.new(X_POSITION,Y_POSITION,200,56,@str)
    @mapname.z = 300
    @delay = DELAY*60
  end
#------------------------------------------------------------------------------  
  def dispose_showname_window
    @mapname.dispose if defined?(@mapname)
  end
#------------------------------------------------------------------------------
  alias update_mapname_adds update 
  def update
    update_mapname_adds
    if $show_mapname == true and defined?(@mapname) and not @mapname.disposed?
      @mapname.fade_in if @mapname.contents_opacity <= 255 and @delay > 0
      @delay -= 1 if @mapname.contents_opacity == 255 and @delay > 0
      @mapname.fade_out if @mapname.contents_opacity >= 0 and @delay == 0
    end
  end
#------------------------------------------------------------------------------
  def update_scene_change
    return if $game_player.moving?    # Is player moving?
    dispose_showname_window if $game_temp.next_scene != nil
    case $game_temp.next_scene
    when "battle"
      call_battle
    when "shop"
      call_shop
    when "name"
      call_name
    when "menu"
      call_menu
    when "save"
      call_save
    when "debug"
      call_debug
    when "gameover"
      call_gameover
    when "title"
      call_title
    else
      $game_temp.next_scene = nil
    end
  end
  
end
#==============================================================================
class Window_MapName < Window_Base
#==============================================================================  
  def initialize(x = 0,y = 0,width = 544, height = 416, text = "")
    super(x,y,width,height)
    self.opacity = 0
    self.contents_opacity = 0
    @text = text
    refresh
  end
#------------------------------------------------------------------------------  
  def refresh
    self.contents.clear
    @sprite = Sprite.new()
    begin
    @sprite.bitmap = Bitmap.new("Graphics/System/location_back")
    rescue Errno::ENOENT
    end
    @sprite.opacity = 0
    @sprite.x = X_POSITION+5
    @sprite.y = Y_POSITION+5
    self.contents.font.color = Color.new(COLOR[0],COLOR[1],COLOR[2],COLOR[3])
    self.contents.draw_text(4, 0, self.width - 40, WLH, @text, ALIGN)
  end
#------------------------------------------------------------------------------
  def dispose
    @sprite.dispose
    super
  end
#------------------------------------------------------------------------------
  def fade_in
    self.contents_opacity += 2
    @sprite.opacity += 2
  end
#------------------------------------------------------------------------------
  def fade_out
    self.contents_opacity -= 2
    @sprite.opacity -= 2
  end
#------------------------------------------------------------------------------   
end
#==============================================================================
class Scene_Title < Scene_Base
#==============================================================================
  alias load_database_mapname_adds load_database
  def load_database
    load_database_mapname_adds
    $data_mapinfos      = load_data("Data/MapInfos.rvdata") 
    for key in $data_mapinfos.keys
      $data_mapinfos[key] = $data_mapinfos[key].name
    end
  end
  
end
#==============================================================================
class Game_Map
#==============================================================================  
  def name
    $data_mapinfos[@map_id]
  end
  
end