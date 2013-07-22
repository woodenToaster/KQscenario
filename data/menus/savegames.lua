--Savegame selection screen, displayed after the title screen.

local savegame_menu = {}

function savegame_menu:new()
	local object = {}
	setmetatable(object, self)
	self.__index = self
	return object
end

function savegame_menu:on_started()
	
	--Create all graphic objects
	self.surface = kq.surface.create(320, 240)
	self.background_color = {0, 127, 14}
	self.background_img = kq.surface.create("menus/selection_menu_background.png")
	self.save_container_img = kq.surface.create("menus/selection_menu_save_container.png")
	self.option_container_img = kq.surface.create("menus./selection_menu_option_container.png")
	self.option1_text = kq.text_surface.create()
	self.option2_text = kq.text_surface.create()
	self.title_text = kq.text_surface.create{
		horizontal_alignment = "center",
		font = "fixed"
	}
	self.cursor_position = 1
	--self.cursor_sprite = kq.sprite.create("menus/selection_menu_cursor")
	self.allow_cursor_move = true
	self.finished = false
	self.phase = nil
	
	--Run the menu
	self:read_savegames()
	
	
end

function savegame_menu:on_draw(dst_surface)

	--Background color
	self.surface:fill_color(self.background_color)
	
	--Savegames container
	local width, height = self.background_img:get_size()
	self.background_img:draw(self.surface, 160 - width / 2, 120 - height / 2)
	self.surface:draw(dst_surface)
end

function savegame_menu:read_savegames()
	
	self.slots = {}
	for i = 1, 3 do
		local slot = {}
		slot.file_name = "save" .. i .. ".dat"
		slot.savegame = kq.game.load(slot.file_name)
		--slot.number_img = kq.surface.create("menus/selection_menu_save" .. i ..".png")
		
		slot.player_name_text = kq.text_surface.create()
		if kq.game.exists(slot.file_name) then
			--Existing file
			--Do some stuff
		else
			--New file
			local name = "- " .. kq.language.get_string("selection_menu_empty") .. " -"
			slot.player_name_text:set_text(name)
		end
		
		self.slots[i] = slot
	end
end

return savegame_menu
















