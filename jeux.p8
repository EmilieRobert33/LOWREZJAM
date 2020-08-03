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

	objets={} --notre tableau contenant la totalitれた des objets du jeux
	--enfin de ce qui ont れたtれた fait avec creer_objet()

end

----------------------------------------
-- la fonction update pour le jeux
----------------------------------------


function update_jeux()
	if (btnp(❎)) etat="fin"
end


---------------------------------------
-- diverse fonction pour update_jeux()
---------------------------------------


--fonction pour creer des objets vitef 
--pas sur qu'on l'utilise a 100%
--mais pour un jeux avec plein de truc qui bouge ca peut aider
--surtout pour checker les collisions avec les autres fonctions qui suivent
function creer_objet(x,y,sprite,lsprite,hsprite)

	local objet ={}
	objet.x=x
	objet.y=y
	objet.sprite=sprite
	objet.hsprite=hsprite
	objet.lsprite=lsprite
	objet.dx=0
	objet.dy=0
	objet.box={x1=0,y1=0,x2=7,y2=7}
	objet.tag=0
	objet.tps=0
	objet.shoot=true
	objet.speed=0
	add(objets,objet)
	return objet
end

--une fonction qui bouge la totalitれた des nos objets si ils ont une vitesse
--initiale le dx et dy pratique pour bouger des balles ect pas forcれたment des ennemies
function bouge_objets()
	for o in all(objets)do
		o.x+=o.dx
		o.y+=o.dy
	end
end

--fonction qui permet d'obtenir la hit box d'un objet
function get_box(a)
	local box ={}
	box.x1 = a.x + a.box.x1
	box.y1 = a.y + a.box.y1
	box.x2 = a.x + a.box.x2
	box.y2 = a.y + a.box.y2
	return box
end

--fonction qui detecte la collision entre 2 objets
--ellle retourne true si il y a eu collision
function check_coll(a,b)
	if (a==b or a.tag==b.tag) return false
		local box_a = get_box(a)
		local box_b = get_box(b)
		if (box_a.x1>box_b.x2 or
						box_a.y1>box_b.y2 or
						box_b.x1>box_a.x2 or
						box_b.y1>box_a.y2) then
			return false
		end
	return true
end

--fonction qui check les collisions entre tous les objets
-- et supprime ce qui se sont rentれた dedans
--pareil on peut changer le comportement faut voir ca plus commme
-- un exemple

function collisions()
	for a in all(objets) do
		for b in all(objets) do
			if (check_coll(a,b) == true) then
			del(objets,a)
			del(objets,b)
			end
		end
	end
end




---------------------------------------
-- la fonction draw_jeux()
---------------------------------------

function draw_jeux()

	cls()
	for i=1,10 do
		srand(0.00001*rnd(i))
		circfill(31,31,(40-4*i)+rnd(6)*rnd(4)*cos(t()),15-i)
	end
	circfill(31,31,3,1)
	print("웃",28,29,7)
	print("press ❎ to die",2,55,7)


end


---------------------------------------
-- diverses fonctions pour draw_jeux()
---------------------------------------

--exemple de fonction qui dessinne les objets
--et supprime ce qui sont hors du champ de vision
function draw_objets()
	for o in all(objets)do
		if (o.y<=-8) del(objets,o)
		if (o.x<=-8) del(objets,o)
		if (o.y>=64) del(objets,o)
		if (o.x>=64) del(objets,o)
		spr(o.sprite,o.x,o.y,o.lsprite,o.hsprite)
	end
end



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

	if (btnp(❎)) etat="jeux"

end

function update_fin()

	if (btnp(❎)) etat="menu"
	if (btnp(5)) etat="jeux"

end

---------------------------------------
--sous fonction des updates
---------------------------------------






---------------------------------------
-- diverses fonction draw
---------------------------------------

function draw_menu()
	cls()
	print("menu",22,30,8)	
	print("press x to play",3,55,5)

end

function draw_fin()
	cls()
	print("noob",27+7*cos(t()),30+7*sin(t()),8)
	print("press x to play",3,55,5)

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
