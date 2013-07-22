--This screen is displayed when the program starts, after the Language
--selection screen (if any).

--A title_screen class is created and returned.

local title_screen = {}

function title_screen:new()
	
	local object = {}
	setmetatable(object, self)
	self.__index = self
	return object
end

function title_screen:on_started()

	--black screen for 0.3 seconds
	self.phase = "black"
	
	self.surface = kq.surface.create(320, 240)
	kq.timer.start(self, 300, function() self:phase_zs_presents() end)
	
	--use the 0.3 seconds to preload all sound effects
	kq.audio.preload_sounds()
end

function title_screen:phase_zs_presents()
	
	self.phase = "zs_presents"
	
	local zs_presents_img = kq.surface.create("title_screen_initialization.png", false)
	
	local width, height = zs_presents_img:get_size()
	local x, y = 160 - width / 2, 120 - height / 2
	zs_presents_img:draw(self.surface, x, y)
	kq.audio.play_sound("intro")
	

	kq.timer.start(self, 2000, function()
		self.surface:fade_out(10, function()
			self:phase_title() 
		end)		
	end)
end
	
function title_screen:phase_title()
	
	self.phase = "title"
	
	--Check this line for memory leak, and updates on github
	self.surface = kq.surface.create(320, 240)
	
	--start music
	--kq.audio.play_music("title_screen")
	
	self.kq_logo_img = kq.surface.create("menus/title_screen_KQ_logo.png", false)
	self.button_img = kq.surface.create("menus/title_screen_button.png", false)
	
end

function title_screen:on_draw(dst_surface)
	if self.phase == "title" then
		self:draw_phase_title(dst_surface)
	end
	
	--final blit (dst_surface may be larger)
	local width, height = dst_surface:get_size()
	self.surface:draw(dst_surface, width / 2 - 160, height / 2 - 120)
end

function title_screen:draw_phase_title()
	self.surface:fill_color({0, 0, 0})
	
	--logo
	self.kq_logo_img:draw(self.surface)
	
	--buttons
	local width, height = self.button_img:get_size()
	self.button_img:draw(self.surface, 160 - width / 2, 120)
	self.button_img:draw(self.surface, 160 - width / 2, 161)
	self.button_img:draw(self.surface, 160 - width / 2, 202)
end

function title_screen:on_key_pressed(key)
	
	local handled = false
	if key == "space" then
		handled = self:try_finish_title()
	end
end

function title_screen:try_finish_title()

	local handled = false
	
	self:finish_title()
	
	handled = true
	return handled
end

function title_screen:finish_title()
	
	local savegame_menu = require("menus/savegames")
	--kq.audio.stop_music()
	kq.main:start_menu(savegame_menu:new())
end

return title_screen













