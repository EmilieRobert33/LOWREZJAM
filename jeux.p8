pico-8 cartridge // http://www.pico-8.com
version 27
__lua__

function _init()
	init_menu()
	init_jeux()
	init_fin()
end

function _update60()

	if etat=="menu" then
		update_menu()
	elseif etat=="jeux" then 
		update_jeux()
	elseif etat=="fin" then
		update_fin()
	end

end

function _draw()
	
	if etat=="menu" then
		draw_menu()
	elseif etat=="jeux" then 
		draw_jeux()
	elseif etat=="fin" then
		draw_fin()
	end


end
---------------------------------------
-- la fonction init pour le jeux
---------------------------------------

function init_jeux()


end

----------------------------------------
-- la fonction update pour le jeux
----------------------------------------


function update_jeux()
end


---------------------------------------
-- diverse fonction pour update_jeux()
---------------------------------------


---------------------------------------
-- la fonction draw_jeux()
---------------------------------------

function draw_jeux()

end


---------------------------------------
-- diverses fonctions pour draw_jeux()
---------------------------------------

---------------------------------------
-- les fonctions init
---------------------------------------

function init_menu()

	poke(0x5f2c,3) -- cette ligne permet de mettre pico-8 en mode 64x64
	etat="menu" --etat initiale du jeux ce sera menu par default
end

function init_fin()

end

---------------------------------------
-- diverses fonction update
---------------------------------------
function update_menu()


end

function update_fin()


end

---------------------------------------
--sous fonction des updates
---------------------------------------






---------------------------------------
-- diverses fonction draw
---------------------------------------

function draw_menu()

end

function draw_fin()

end

-------------------------------------
-- diverses sous fonction draw
-------------------------------------


__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
