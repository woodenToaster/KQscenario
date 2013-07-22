--Presently English is the only option

local language_menu = {}

function language_menu:new()
	
	local object = {}
	setmetatable(object, self)
	self.__index = self
	return object
end

function language_menu:on_started()
	
	self:start_title_screen()
end

function language_menu:start_title_screen()
	
	local title_screen = require("menus/title")
	kq.main:start_menu(title_screen:new())
end

return language_menu