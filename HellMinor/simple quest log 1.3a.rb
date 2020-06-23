#==============================================================================
#  Simple Quest-Log
#
#  Version : 1.3a - 04.04.08
#  Created by : hellMinor
#  Do NOT redistribute without my permission
#  Description : A simple script for a Quest-Log
#
#==============================================================================
#==============================================================================
# F.A.Q.
#==============================================================================
# The Global Questlog-Name is $questlog
# To open the Questlog from the menu just do $scene = Scene_Questlog.new
# To open the Questlog from an event $scene = Scene_Questlog.new(false)
#
# To add a quest make a new call script with this Template :
# $questlog.addQuest("Unique ID","Quest Title","Quest Description","State")
#
# To update a Quest description make a new call script with this Template :
# $questlog.updateQuest("unique ID","Quest Description","State")
#
# To move a Quest to Completed Quests make new call script with this Template :
# $questlog.completeQuest("Unique ID")
#
# To delete a Quest from the Active-Questlog make a call script with this
# Template :
# $questlog.deleteQuest("Unique ID")
#
# You can get the current state of a Quest with this Template :
# $questlog.getQuestState("Unique ID")
# This may be useful in a conditional branch if you want to react with a
# special Quest-State
#
# If u want to add a Questmap, create a folder named Questmaps in your
# Graphics folder. The name of the Questmap must be the same as the Quest
# in the Game. Be sure that you set the correct MAP_FORMAT.
# A Quest-Map should have a size of 265*200 px !
# I.E. : If your Quest is named QuestYXZ , the picture in the Questmap folder
# has to be QuestYXZ.png if your map is a .png
#==============================================================================
# Setup
#==============================================================================
QUESTLOGNAME = "Questlog"               # Questlog Menu name
QUEST_MENU_ITEM_1 = "Active Quests"     # Active Quest name
QUEST_MENU_ITEM_2 = "Completed Quests"  # Completed Quest name
SIZE_VAR = 20                           # Character Size
MAP_FORMAT = "png"                      # Quest-Map Ending
#==============================================================================
class Questlog
#============================================================================== 
  def addQuest(id,header,description,state = "")
    $activelog << [id,header,description,state]
  end
#------------------------------------------------------------------------------  
  def updateQuest(id,description,state = "")
    for i in 0..$activelog.size-1
      if $activelog[i][0] == id
        $activelog[i][2] = description
        $activelog[i][3] = state
        break
      end
    end
  end
#------------------------------------------------------------------------------
  def completeQuest(id)
    for i in 0..$activelog.size-1
      if $activelog[i][0] == id
        $completedlog << $activelog[i]
        $activelog.delete_at(i)
        break
      end
    end
  end
#------------------------------------------------------------------------------
  def deleteQuest(id)
    for i in 0..$activelog.size-1
      if $activelog[i][0] == id
        $activelog.delete_at(i)
        break
      end
    end
  end
#------------------------------------------------------------------------------
  def getQuestState(id)
    for i in 0..$activelog.size-1
      if $activelog[i][0] == id
        return $activelog[i][3]
        break
      end
    end
  end
  
end
#==============================================================================
class Scene_Questlog < Scene_Base
#==============================================================================
  def initialize(from_menu = true)
    @from_menu = from_menu
  end
  
  def start
    super
    create_menu_background
    @help_window = Window_Help.new
    @help_window.set_text(QUESTLOGNAME,1)
    
    s1 = QUEST_MENU_ITEM_1
    s2 = QUEST_MENU_ITEM_2
    
    @select_window = Window_Command.new(544,[s1,s2],2,1) 
    @select_window.y = 55
    @select_window.active = true
    
  end
#------------------------------------------------------------------------------
  def terminate
    super
    dispose_menu_background
    @help_window.dispose
    @select_window.dispose
  end
#------------------------------------------------------------------------------  
  def kill_questwindows
    @quest_window.dispose
  end  
#------------------------------------------------------------------------------
  def return_scene
    if @from_menu
      $scene = Scene_Menu.new
    else
      $scene = Scene_Map.new
    end
  end
#------------------------------------------------------------------------------
  def update
    super
    update_menu_background
    @help_window.update
    if @select_window.active
      @select_window.update
      update_select_selection
    elsif @quest_window.active
      @quest_window.update
      update_quest_selection
    end
  end
#------------------------------------------------------------------------------
  def update_select_selection
    if Input.trigger?(Input::B)
      Sound.play_cancel
      return_scene
    elsif Input.trigger?(Input::C)
      case @select_window.index
      when 0
        $oldlog = false
        @quest_window = Window_Quest.new(0,110,272,(24*11)+42)
        @select_window.active = false
        @quest_window.active = true
      when 1
        $oldlog = true
        @quest_window = Window_Quest.new(0,110,272,(24*11)+42)
        @select_window.active = false
        @quest_window.active = true
      end      
    end
  end
#------------------------------------------------------------------------------  
  def update_quest_selection
    if Input.trigger?(Input::B)
      Sound.play_cancel
      kill_questwindows
      @select_window.active = true
    end
  end

end
#==============================================================================
class Scene_Title < Scene_Base
#==============================================================================
  alias create_game_objects_additions create_game_objects
  def create_game_objects
    create_game_objects_additions
    $questlog = Questlog.new
    $activelog = Array.new
    $completedlog = Array.new
  end
  
end
#==============================================================================
class Window_Help < Window_Base
#==============================================================================
  def initialize(x = 0,y = 0, width = 544, height = WLH+32)
    super(x, y, width, height)
  end
  
end
#==============================================================================
class Window_Description < Window_Base
#==============================================================================
  def initialize(x = 0,y = 0, width = 544, height = WLH+32)
    super(x, y, width, height)
    @text = nil
    @contents_x = 0
    @contents_y = 0
    @line_count = 0             # Line count drawn up until now
    update
  end
#------------------------------------------------------------------------------  
  def new_line
    @contents_x = 0
    @contents_y += WLH
    @line_count += 1
    @line_show_fast = false
  end
#------------------------------------------------------------------------------  
  def finish_message
    @text = nil
    @line_count = 0
    @contents_x = 0
    @contents_y = 0
  end
#------------------------------------------------------------------------------  
  def write_text(str)
    if str != nil || str != ""
      create_contents
      update_msg(str)
    end
  end
#------------------------------------------------------------------------------  
  def update_msg(str)
    str.each_line{|str2|iterator(str2)}
    finish_message
  end
#------------------------------------------------------------------------------   
  def iterator(str2)
    contents.font.size = SIZE_VAR
    contents.draw_text(@contents_x, @contents_y, str2.size*40, WLH, str2.delete("\n"))
    c_width = contents.text_size(str2).width
    @contents_x += c_width
    new_line
  end
  
end
#==============================================================================
class Window_Quest < Window_Selectable
#==============================================================================
  def initialize(x, y, width, height)
    super(x, y, width, height)
    @column_max = 1
    self.index = 0
    
    @quest_helper = Window_Description.new(271,110,273,(24*11)+42)
    
    refresh
  end
#------------------------------------------------------------------------------
  def refresh
    @data = []
    if !$oldlog
      for i in (0..$activelog.size-1)
        @data.push($activelog[i])
      end
    else
      for i in (0..$completedlog.size-1)
        @data.push($completedlog[i])
      end
    end
    @item_max = @data.size
    create_contents
    for i in 0...@item_max
      draw_item(i)
    end
  end
#------------------------------------------------------------------------------
  def draw_item(index)
    rect = item_rect(index)
    self.contents.clear_rect(rect)
    item = @data[index][1]
    if item != nil
      rect.width -= 4
      self.contents.draw_text(rect.x, rect.y, 172, WLH, item)
    end
  end
#------------------------------------------------------------------------------
  alias update_addition update
  def update
    update_addition
    update_description(@index)
    update_selection
  end
#------------------------------------------------------------------------------
  def update_selection
    if Input.trigger?(Input::B)
      Sound.play_cancel
      @quest_helper.dispose
      if @quest_map != nil
        @quest_map_bitmap.bitmap.dispose
        @quest_map_bitmap.dispose
        @quest_map.dispose
        @quest_map_viewport.dispose
        @quest_map = nil
      end
    end
  end
#------------------------------------------------------------------------------    
  def update_description(id)
    if defined?(@data[id][2])
      @quest_helper.write_text(@data[id][2])
      if @quest_map == nil
        if Cache.questmaps(@data[id][1]).is_a?(Bitmap)
          self.height /= 3
          @quest_map = Window_Description.new(0,210,272,(24*7)+38)
          @quest_map_bitmap = Sprite.new
          @quest_map_viewport = Viewport.new(3,213,268,(24*7)+35)
          @quest_map_bitmap.viewport = @quest_map_viewport
          @quest_map_bitmap.bitmap = Cache.questmaps(@data[id][1])
          @quest_map_bitmap.viewport.z = 150
        end
      else
        if Cache.questmaps(@data[id][1]).is_a?(Bitmap)
          @quest_map_bitmap.bitmap = Cache.questmaps(@data[id][1])
        else
          self.height *= 3
          @quest_map_bitmap.bitmap.dispose
          @quest_map_bitmap.dispose
          @quest_map.dispose
          @quest_map_viewport.dispose
          @quest_map = nil
        end
      end
      
    end
  end
  
end
#==============================================================================
class Scene_File < Scene_Base
#==============================================================================
  alias write_save_data_adds write_save_data
  def write_save_data(file)
    write_save_data_adds(file)    
    Marshal.dump($activelog,           file)
    Marshal.dump($completedlog,        file)
    Marshal.dump($questlog,            file)
  end
  
  alias read_save_data_adds read_save_data
  def read_save_data(file)
    read_save_data_adds(file)
    $activelog           = Marshal.load(file)
    $completedlog        = Marshal.load(file)
    $questlog            = Marshal.load(file)
  end
end
#==============================================================================
module Cache
#==============================================================================  
  def self.questmaps(filename)
    begin
      load_bitmap("Graphics/Questmaps/", filename)
    rescue
      return nil
    end
  end
  
end