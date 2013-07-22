--Main script of the quest

function kq.main:on_started()

	--Loads audio volume, video mode, language, etc.
	kq.main.load_settings()
	
	local language_menu = require("menus/language")
	
	--Show the language/intro menu
	kq.main:start_menu(language_menu:new())
end

function kq.main:on_finished()
	
	kq.main.save_settings()
end

function kq.main:start_menu(menu)

	kq.main.menu = menu
	
	if menu ~= nil then
		kq.menu.start(kq.main, menu)
	end
end

