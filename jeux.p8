pico-8 cartridge // http://www.pico-8.com
version 27
__lua__

function _init()
	init_menu()
	init_explo_maison()
	init_combat()
	init_jeux()
	init_fin()
	init_boss()
end

function _update60()

	if (etat=="menu") update_menu()
	--if (etat=="bug_soso") etat="dialogue_debut_sosoa"
	update_explo_maison()
	update_combat()
	update_boss()
	update_m()
	update_k()

end

function _draw()
	
	if (etat=="menu")	draw_menu()
	draw_combat()
	draw_explo_maison()
	draw_combat_boss()
	draw_combat_m()
	draw_combat_k()

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
function draw_explo_maison()
	if (etat=="explo_maison") then
		cls()
		draw_map()	
		if(p.itemsportail>0) then
		 draw_portail(3,11)
		end	
		draw_player()
		draw_sensei()
		--draw_soso_explo()
		if(btn(❎)) show_inventory()
	end
	
	if etat=="explo_hot_dog_city" then
		cls()
		draw_map()	
		if (p.flag == 5) then
			draw_portail(119,12)
		end
		draw_player()
		--quand le player chnage de flag la saucisse est battue
		--on veut qu'elle disparaisse (le flag sera diffれたrent de zero)
		if (p.flag==0) draw_soso_explo()
		if (p.flag==4) draw_boss_explo()
		if (p.flag==3) draw_k_explo()
		if (p.flag==2) draw_m_explo()
		
		if(btn(❎)) show_inventory()
	
	
	end

end
function draw_combat()
	if etat=="sensei_combat" then
		cls(1)
		map(0,0,0,0,0)
		screen_shake()
		draw_carreau()
		palt(0,false)
		rect(0,52,63,62,1)
		rectfill(1,53,62,61,0)
		palt()
		draw_life()
		draw_sensei_combat()
		draw_ma_vie()
		line(27,53,27,61,11)
		line(40,53,40,61,11)
		for i=1,#notes do
			local n=notes[i]
			print(n.s,n.x,n.y)
--			pset(n.x+3,n.y+3,9)
	
		end

		for a=1,#fini do
			local n=fini[i]
			if n!=nill then
				print(n.s,n.x,n.y)
--				pset(n.x+3,n.y+3,9)
			end

		end
	elseif etat=="dialogue_fin_sensei" then
		cls()
		rect(0,0,17,18,7)
		spr(s_parle,0,0,2.5,2.5)
		print("you are",25,0,7)
		print("ready now.",25,10,7)
		print("take the portal",0,20,7)
		print("to hot-dog-verse",0,30,7)
		print("to kill the",0,40,7)
		print("hot-doggy-dog",0,50,8)
		print("at north.",0,59,7)
	elseif etat=="dialogue_debut_sensei" then
		cls()
		rect(0,0,17,18,7)
		spr(s_parle,0,0,2.5,2.5)
		print("let's go",25,0,7)
		print("training!",25,10,7)
		print("use arrow key",0,20,7)
		print("and your",0,30,7)
		print("reflexes to",0,40,7)
		print("beat me",0,50,7)
		print("good luck son!",0,59,7)
	


	elseif etat=="dialogue_debut_sosoa" then

		cls()
		map(0,0,0,0,0)
		rect(0,0,17,18,7)
		spr(so_parle,1,2,2,2)
		print("u shall ",25,0,7)
		print("not pass !",25,10,7)
		print("unless you ",0,20,7)
		print("killed",0,30,7)
		print("mustard and",0,40,10)
		print("ketchup !!!",0,50,7)
	

	elseif etat=="dialogue_fin_soso" then

		cls()
		rect(0,0,17,18,7)
		spr(so_parle,1,2,2,2)
		print("i failed ",25,0,7)
		print("to protect",25,10,7)
		print("my king. ",0,20,7)
		print("shame on me !!",0,30,8)
		print("mustard",0,40,10)
		print("will b-eat you!",0,50,7)




	elseif etat=="combat_saucisse" then
		cls()
		screen_shake()
		--draw_vague()
		--draw_carreau()
		palt(0,false)
		rect(0,52,63,62,1)
		rectfill(1,53,62,61,0)
		palt()
		draw_life()
		draw_soso()
		draw_cube()
		draw_ma_vie()
		line(27,53,27,61,11)
		line(40,53,40,61,11)
		for i=1,#notes do
			local n=notes[i]
			print(n.s,n.x,n.y)
--			pset(n.x+3,n.y+3,9)
	
		end

		for a=1,#fini do
			local n=fini[i]
			if n!=nill then
				print(n.s,n.x,n.y)
--				pset(n.x+3,n.y+3,9)
			end

		end

	end


end

---------------------------------------
-- les fonctions init
---------------------------------------
function init_explo_maison()
	nbr_pas=0
	map_setup()
	make_player(3,2)

end

function init_menu()

	poke(0x5f2c,3) -- cette ligne permet de mettre pico-8 en mode 64x64
	etat="menu" --etat initiale du jeux ce sera menu par default
	music(0)
end

function init_fin()

end

function init_combat()
	offset=0
	notes={}
	fini={}
	frame=0
	combo=0
	temps=60
	test_pat={"h",60,"h",30,"b",30,"b",40,"g",60,"d",40,"g",40,"d",60,"h",40,"b",40,"g",40,"d",40}

	carreau={}
	carreau2={}
	
	rempli={▥,░,⧗,▤,☉,◆,…,★,✽,●,♥,웃,⌂,∧,🐱,ˇ,▒,♪}
	
	touche={"h","b","d","g"}
	touche_so={"h","b","d","g","x"}

	life=51
	degat=life/10

	init_ma_vie()
	s_parle=8
	so_parle=108
	--etat="dialogue_debut_soso1"

end

---------------------------------------
-- diverses fonction update
---------------------------------------
function update_menu()

		faire_carreau()
		update_carreau()
	if (btnp(5)) then
		etat="explo_maison"
		music(01)
	end

end

function update_explo_maison()
	if (etat=="explo_maison") then
		update_map()
		move_player()
		if (nbr_pas == 3) then
			etat="dialogue_debut_sensei"
			music(15)
		end
		anim_player()
	elseif etat=="explo_hot_dog_city" then
		update_map()
		move_player()
		anim_player()	
	end
end

function update_fin()


end

function update_combat()
	
	if etat=="sensei_combat" then 
		rand_pat()
		faire_carreau()
		update_carreau()
		if (btnp(2)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬆️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08
			end
		end
		if (btnp(3)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬇️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end
	
		if (btnp(0)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬅️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end

		if (btnp(1)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="➡️") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end




		for i=1,#notes do
			if (notes[i]!=nill) then
				notes[i].x-=0.80
				if (notes[i].x<20) then
					add(fini,notes[i])
					del(notes,notes[i])
					sfx(40)
					perdre_ma_vie()
					offset=0.08
				end
			end
		end
		for a=1,#fini do
			if (fini[i]!=nill) and (fini[i].x<-7) then
				del(fini,notes[i])
			end
		end
	elseif etat=="dialogue_debut_sensei" then
		if (cos(2*t())>0 and s_parle==8) s_parle=11		
		if (cos(2*t())<0 and s_parle==11) s_parle=8
		if (btnp(5) ) then 
			etat="sensei_combat"
			music(02)
		end

	elseif etat=="dialogue_fin_sensei" then
		if (cos(2*t())>0 and s_parle==8) s_parle=11		
		if (cos(2*t())<0 and s_parle==11) s_parle=8
		if (btnp(0) or btnp(1) or btnp(2) or btnp(3) or btnp(4) or btnp(5)) then
			etat="explo_maison"
			music(01)
			nbr_pas=50
			life=51
			ma_vie=4
			p.itemsportail=1
		end

	elseif etat=="dialogue_debut_sosoa" then
		if (cos(2*t())>0 and so_parle==108) so_parle=110		
		if (cos(2*t())<0 and so_parle==110) so_parle=108
		if (btnp(4)) etat="combat_saucisse"

	elseif etat=="dialogue_debut_sosob" then
		if (cos(2*t())>0 and so_parle==108) so_parle=110		
		if (cos(2*t())<0 and so_parle==110) so_parle=108
		if (btnp(0) or btnp(1) or btnp(2) or btnp(3) or btnp(4) or btnp(5)) etat="combat_saucisse"


	elseif etat=="dialogue_fin_soso" then
		if (cos(2*t())>0 and so_parle==108) so_parle=110		
		if (cos(2*t())<0 and so_parle==110) so_parle=108
		if (btnp(0) or btnp(1) or btnp(2) or btnp(3) or btnp(4) or btnp(5)) then
			etat="explo_hot_dog_city"
			music(01)
			life=51
			ma_vie=4
		end


	elseif etat=="combat_saucisse" then 
		rand_pat()
		faire_carreau()
		update_carreau()
		if (btnp(2)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬆️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08
			end
		end
		if (btnp(3)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬇️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end
	
		if (btnp(0)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬅️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end

		if (btnp(1)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="➡️") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end

		if (btnp(5)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="❎") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end





		for i=1,#notes do
			if (notes[i]!=nill) then
				notes[i].x-=0.80
				if (notes[i].x<20) then
					add(fini,notes[i])
					del(notes,notes[i])
					sfx(40)
					perdre_ma_vie()
					offset=0.08
				end
			end
		end
		for a=1,#fini do
			if (fini[i]!=nill) and (fini[i].x<-7) then
				del(fini,notes[i])
			end
		end
	end

end

---------------------------------------
--sous fonction des updates
---------------------------------------

function u_degat()
	life-=degat
	if (life<=0) then
		life=51
		ma_vie=4
		if etat=="sensei_combat" then
			etat="dialogue_fin_sensei"
			music(01)
		elseif etat=="combat_saucisse" then
			etat="dialogue_fin_soso"
			music(01)
		elseif etat=="combat_m" then
			etat="explo_hot_dog_city"
			music(01)
		elseif etat=="combat_k" then
			etat="explo_hot_dog_city"
			music(01)
		elseif etat=="combat_boss" then
			etat="explo_hot_dog_city"
			music(01)
		end
	end
end
function draw_life()

	print ("hp:",0,0,11)
	rectfill(11,1,62,3,8)
	if (life>0) rectfill(11,1,11+life,3,11)

end
-------------------------------------
-- draw le sensei
-------------------------------------

function draw_sensei_combat()
	if life>25 then
		spr(0,15,8,4,4)
	else
		spr(4,10,8,4,4)
	end
end

function draw_soso()

	if life>25 then
		spr(104,26,12,2,3)
	else
		spr(106,27,12,2,3)
	end
end

function draw_cube()
	b={}
	for i=0,3 do
		x=15+cos(t()/4+i/4)*10
		y=20+sin(t()/4+i/4)*10
		add(b,{x=x,y=y})
	end
	for i=1,4 do
		j=i%4+1
		line(b[i].x,b[i].y,b[i].x,b[i].y+10,7)
		line(b[i].x,b[i].y,b[j].x,b[j].y)
		line(b[i].x,b[i].y+10,b[j].x,b[j].y+10)

		line(b[i].x+37,b[i].y,b[i].x+37,b[i].y+10)
		line(b[i].x+37,b[i].y,b[j].x+37,b[j].y)
		line(b[i].x+37,b[i].y+10,b[j].x+37,b[j].y+10)
	
	end

end

--------------------------------------
-- function pour afficher les coeurs
--------------------------------------

function init_ma_vie()

	ma_vie=4
	retry=false

end



function perdre_ma_vie()

	ma_vie-=1
	if ma_vie<=0 then
		ma_vie=4
		life=51
		notes={}
		temps=120
		retry=true
		sfx(28)
	end

end




function draw_ma_vie()
	if (ma_vie==1) print("♥",0,48,8)
	if (ma_vie==2) print("♥♥",0,48,8)
	if (ma_vie==3) print("♥♥♥",0,48,8)
	if (retry and temps>=60) then
		rectfill(1,25,64,33,7)
		print("try again !",13,27,8)
	end
	if (ma_vie==4) then
		print("♥♥♥♥",0,48,8)
	end
end

-----------------------------------------
-----------------------------------------
--fonction pour combat boss -------------
------------------------------------------
-----------------------------------------

function draw_c_b()
	cx=34
	cy=27
	for i=1,#c_b do
		rectfill(cx,cy,c_b[i].x,c_b[i].y,c_b[i].c)
		rectfill(cx,cy,cx+(cx-c_b[i].x),c_b[i].y,c_b[i].c)
		rectfill(cx,cy,c_b[i].x,cy+cy-c_b[i].y,c_b[i].c)	
		rectfill(cx,cy,2*cx-c_b[i].x,2*cy-c_b[i].y,c_b[i].c)
	end

end

function faire_c_b(x,y)
	for i=1,#c_b do
		if (c_b[i]!=nill) then
			c_b[i].x+=1/5
			c_b[i].y+=1/5
			if (c_b[i].x>=37 and c_b[i].f) then
				c_b[i].f=false
				add(c_b,{x=32,y=27,c=rnd(15),f=true})
			elseif (c_b[i].x>65) then
				del(c_b,c_b[i])
			end
		end
	end
end

function init_boss()
	c_b={{x=0,y=0,c=6,f=true}}
	c_b[1].x=34
	c_b[1].y=27
	c_b[1].c=30

	touche_boss={"h","b","d","g","x","c"}
end

function draw_boss()

	if life>25 then
		spr(128,26,12,2,3)
	else
		spr(176,27,12,2,3)
	end
end

function draw_combat_boss()

	if etat=="combat_boss" then
		cls()
		screen_shake()
		draw_c_b()
		palt(0,false)
		rect(0,52,63,62,1)
		rectfill(1,53,62,61,0)
		palt()
		draw_life()
		draw_boss()
		draw_ma_vie()
		line(27,53,27,61,11)
		line(40,53,40,61,11)
		for i=1,#notes do
			local n=notes[i]
			print(n.s,n.x,n.y)
--			pset(n.x+3,n.y+3,9)	
		end
		for a=1,#fini do
			local n=fini[i]
			if n!=nill then
				print(n.s,n.x,n.y)
--				pset(n.x+3,n.y+3,9)
			end

		end
	end
end


function update_boss()

	if etat=="combat_boss" then 
		rand_pat()
		faire_c_b()
		if (btnp(2)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬆️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08
			end
		end
		if (btnp(3)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬇️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end
	
		if (btnp(0)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬅️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end

		if (btnp(1)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="➡️") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end

		if (btnp(5)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="❎") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end

		if (btnp(4)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="🅾️") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end

		for i=1,#notes do
			if (notes[i]!=nill) then
				notes[i].x-=0.80
				if (notes[i].x<20) then
					add(fini,notes[i])
					del(notes,notes[i])
					sfx(40)
					perdre_ma_vie()
					offset=0.08
				end
			end
		end
		for a=1,#fini do
			if (fini[i]!=nill) and (fini[i].x<-7) then
				del(fini,notes[i])
			end
		end
	end
end
---------------------------------------------
---------------------------------------------
---combat moutarde
----------------------------------------------
----------------------------------------------
----------------------------------------------

function draw_combat_m()


	if etat=="combat_m" then
		cls()
		screen_shake()
		palt(0,false)
		rect(0,52,63,62,1)
		rectfill(1,53,62,61,0)
		palt()
		draw_life()
		draw_m()
		draw_ma_vie()
		line(27,53,27,61,11)
		line(40,53,40,61,11)
		for i=1,#notes do
			local n=notes[i]
			print(n.s,n.x,n.y)
--			pset(n.x+3,n.y+3,9)
	
		end

		for a=1,#fini do
			local n=fini[i]
			if n!=nill then
				print(n.s,n.x,n.y)
--				pset(n.x+3,n.y+3,9)
			end

		end

	end
end

function draw_m()

	if life>25 then
		spr(157,26,12,2,3)
	else
		spr(155,27,12,2,3)
	end
end

function update_m()


	if etat=="combat_m" then 
		rand_pat()
		faire_c_b()
		if (btnp(2)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬆️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08
			end
		end
		if (btnp(3)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬇️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end
	
		if (btnp(0)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬅️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end

		if (btnp(1)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="➡️") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end

		if (btnp(5)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="❎") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end


		if (btnp(4)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="🅾️") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end





		for i=1,#notes do
			if (notes[i]!=nill) then
				notes[i].x-=0.80
				if (notes[i].x<20) then
					add(fini,notes[i])
					del(notes,notes[i])
					sfx(40)
					perdre_ma_vie()
					offset=0.08
				end
			end
		end
		for a=1,#fini do
			if (fini[i]!=nill) and (fini[i].x<-7) then
				del(fini,notes[i])
			end
		end
	end
end

--------------------------------------------------------
--------------------------------------------------------
--------combat ketchup ---------------------------------
----------------------------------------------------------
---------------------------------------------------------
function draw_combat_k()


	if etat=="combat_k" then
		cls()
		screen_shake()
		palt(0,false)
		rect(0,52,63,62,1)
		rectfill(1,53,62,61,0)
		palt()
		draw_life()
		draw_k()
		draw_ma_vie()
		line(27,53,27,61,11)
		line(40,53,40,61,11)
		for i=1,#notes do
			local n=notes[i]
			print(n.s,n.x,n.y)
--			pset(n.x+3,n.y+3,9)
	
		end

		for a=1,#fini do
			local n=fini[i]
			if n!=nill then
				print(n.s,n.x,n.y)
--				pset(n.x+3,n.y+3,9)
			end

		end

	end
end

function draw_k()

	if life>25 then
		spr(151,26,12,2,3)
	else
		spr(153,27,12,2,3)
	end
end
function update_k()


	if etat=="combat_k" then 
		rand_pat()
		faire_c_b()
		if (btnp(2)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬆️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08
			end
		end
		if (btnp(3)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬇️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end
	
		if (btnp(0)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="⬅️") then
				del(notes,notes[1])
				u_degat()
				sfx(30+combo)
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end	
		end

		if (btnp(1)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="➡️") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end

		if (btnp(5)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="❎") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end


		if (btnp(4)) then
			if (notes[1]!=nill and notes[1].x>=27 and notes[1].x<=40 and notes[1].s=="🅾️") then
				del(notes,notes[1])
				sfx(30+combo)
				u_degat()
				combo+=1
				if (combo>9) combo=0
			else
				sfx(40)
				perdre_ma_vie()
				combo=0
				offset=0.08

			end
		end





		for i=1,#notes do
			if (notes[i]!=nill) then
				notes[i].x-=0.80
				if (notes[i].x<20) then
					add(fini,notes[i])
					del(notes,notes[i])
					sfx(40)
					perdre_ma_vie()
					offset=0.08
				end
			end
		end
		for a=1,#fini do
			if (fini[i]!=nill) and (fini[i].x<-7) then
				del(fini,notes[i])
			end
		end
	end
end





----------------------------------------------------------
----------------------------------------------------------
----------------------------------------------------------

------------------------------------
------------------------------------
------------------------------------
function rand_pat()
	frame+=1
	if (frame>=temps) then
		frame=0
		if etat=="sensei_combat" then
			faire_note(touche[flr(rnd(5))])
			temps=55
		elseif etat=="combat_saucisse" then
			faire_note(touche_so[flr(rnd(5.5))])
			temps=55
		elseif etat=="combat_m" then
			faire_note(touche_so[flr(rnd(5.5))])
			temps=50
		elseif etat=="combat_k" then
			faire_note(touche_so[flr(rnd(5.5))])
			temps=50
		elseif etat=="combat_boss" then
			faire_note(touche_boss[flr(rnd(6.5))])
			temps=45
		end
	end
end

function pattern(s)
	frame+=1
	if (frame>=temps and s[1]!=nill) then
		frame=0
		temps=s[2]
		del(s,s[2])
		faire_note(del(s,s[1]))
	end
end

function faire_note(a)
	if (a=="h") then
		local n={x=64,y=55,s="⬆️"}
		add(notes,n)
	end

	if (a=="b") then
		local n={x=64,y=55,s="⬇️"}
		add(notes,n)
	end
	if (a=="d") then
		local n={x=64,y=55,s="➡️"}
		add(notes,n)
	end
	if (a=="g") then
		local n={x=64,y=55,s="⬅️"}
		add(notes,n)
	end
	if (a=="x") then
		local n={x=64,y=55,s="❎"}
		add(notes,n)
	end

	if (a=="c") then
		local n={x=64,y=55,s="🅾️"}
		add(notes,n)
	end
end


function faire_carreau()
	if (cos(t())==-1) then
		local c={x1=rnd(84)-20,y1=-rnd(20),x2=rnd(64)+10,y2=0,r=rempli[flr(rnd(#rempli))]}
		add(carreau,c)
	end
	if (cos(t())==0) then
		local c={x1=64,y1=rnd(84)-20,x2=64+rnd(20),y2=rnd(84)-20,r=rempli[flr(rnd(#rempli))]}
		add(carreau2,c)
	end
end

function update_carreau()

	for i=1,#carreau do
		if carreau[i]!=nill then
			local c=carreau[i]
			c.y1+=0.5
			c.y2+=0.5

			if (c.y1>65) del(carreau,c)
		end
	end

	for a=1,#carreau2 do
		if carreau2[a]!=nill then
			local c=carreau2[a]
			c.x1-=0.5
			c.x2-=0.5

			if (c.x2<-5) del(carreau2,c)
		end
	end


end

function draw_carreau()
	for i=1,#carreau do
		if carreau[i]!=nill then
			local c=carreau[i]
			fillp(c.r)
			rectfill(c.x1,c.y1,c.x2,c.y2,5)
			fillp()
		end
	end
	for a=1,#carreau2 do
		if carreau2[a]!=nill then
			local c=carreau2[a]
			fillp(c.r)
			rectfill(c.x1,c.y1,c.x2,c.y2,5)
			fillp()
		end
	end
end

function screen_shake()
  local fade = 0.95
  local offset_x=16-rnd(32)
  local offset_y=16-rnd(32)
  offset_x*=offset
  offset_y*=offset
  
  camera(offset_x,offset_y)
  offset*=fade
  if offset<0.05 then
    offset=0
  end
end
----------------------------
-- init 
----------------------------

function _init_combat()
	notes={}
end





---------------------------------------
-- diverses fonction draw
---------------------------------------

function draw_menu()
	cls()
	draw_carreau()
	print("beat the",15,5,7)
	print("hot-dog-verse",5,15,7)
	print("press ❎",15,25,7)
	print("to play",15,35,7)
	spr(64,0,45,2,2)
	spr(96,40,45,2,2)
	
end

function draw_fin()

end
-------------------------------------
--c'est un peu le bordel fonction support pour explo
-------------------------------------
function map_setup()
	--timers
	timer=0
	anim_time=30 --30 = 1sec

	--map tile settings
	wall=0
	key=1
	door=2
	anim1=3
	anim2=4
	itemportail=5
	tel=6
	win=7

end

function update_map()
	if( timer<0) then
		toggle_tiles()
		timer=anim_time
	end
	timer -=1

end

function draw_map()
	-- pour suivre le player 
	-- sur la map
	mapx=flr(p.x/8)*8
	mapy=flr(p.y/8)*8
	camera(mapx*8,mapy*8)
	
	map(0,0,0,0,63*8,63*8)
end

function is_tile(tile_type,x,y)
	tile=mget(x,y)
	has_flag=fget(tile,tile_type)
	return has_flag
end

function can_move(x,y)
	return not is_tile(wall,x,y)
end

function unswap_tile(x,y)
	tile=mget(x,y)
	mset(x,y,tile-1)
end

function swap_tile(x,y)
	tile=mget(x,y)
	mset(x,y,tile+1)
end

function get_key(x,y)
	p.keys+=1
	swap_tile(x,y)
	sfx(21)
end

function open_door(x,y)
	p.keys-=1
	swap_tile(x,y)
	sfx(22)
end

function get_item_portail(x,y)
	p.itemsportail+=1
	swap_tile(x,y)
	sfx(5)
end


-->8
-- player code

function make_player(x,y)
	p={}
	p.x=x
	p.y=y
	p.sprite=66
	p.keys=0
	p.itemsportail=0
	p.flag=1
	--p.anim="walk"
	--p.walk={f=66,st=66,sz=2,spd=1/30}
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8,2,2)
	--print(p.flag,p.x*8,p.y*8,8)
	--print(etat,p.x*8,p.y*8,8)
end

function draw_sensei()
	spr(anim_sensei(96),1*8,1*8,2,2)
end

function draw_soso_explo()
	spr(anim_soso(100),74*8,16*8,2,2)
end

function draw_boss_explo()
	spr(anim_boss_explo(195),118*8,8*8,2,2)
end

function draw_m_explo()
	spr(anim_moutarde_explo(74),84*8,27*8,2,2)
end

function draw_k_explo()
	spr(anim_ketchup_explo(70),105*8,26*8,2,2)
end

function move_player()
	newx=p.x
	newy=p.y
	
	if(btnp(⬅️)) then
		newx-=1 
		nbr_pas+=1
	end 
	if(btnp(➡️)) then 
		newx+=1
		nbr_pas+=1
	end 
	if(btnp(⬆️)) then 
		newy-=1 
		nbr_pas+=1
	end 
	if(btnp(⬇️)) then 
		newy+=1 
		nbr_pas+=1
	end 
	
	interact(newx,newy)
	
	if (can_move(newx,newy)) then
		p.x=mid(0,newx,63*8)
		p.y=mid(0,newy,63*8)
	else
		sfx(20)
	end
	
end

function interact(x,y)
	if(is_tile(key,x,y)) then
		get_key(x,y)
	elseif(is_tile(door,x,y) and p.keys>0) then
		open_door(x,y)
	elseif(is_tile(itemportail,x,y)) then
		get_item_portail(x,y)		
	elseif(is_tile(tel,x,y) and p.flag==1) then
		etat="explo_hot_dog_city"
		newx=59
		newy=26
		p.flag=0
		swap_tile(x,y)
		music(01)

	elseif(is_tile(tel,x,y) and p.flag==0) then
		--combat saucisse
		etat="combat_saucisse"
		music(02)
		--mapx=0
		--mapy=0
		p.flag=2
		swap_tile(x,y)
		
	elseif(is_tile(tel,x,y) and p.flag==2) then
		--combat moutarde
		etat="combat_m"
		music(02)
		p.flag=3
		swap_tile(x,y)
	
	elseif(is_tile(tel,x,y) and p.flag==3) then
		--combat ketchup
		etat="combat_k"
		music(02)
		p.flag=4
		swap_tile(x,y)
	
	elseif(is_tile(tel,x,y) and p.flag==4) then
		--combat boss
		etat="combat_boss"
		music(02)
		p.flag=5
		swap_tile(x,y)
	
	elseif(is_tile(tel,x,y) and p.flag==5) then
		etat="explo_maison"
		newx=2
		newy=3
		p.flag=0
		swap_tile(x,y)
		music(02)

	end
end



-->8
--inventory code

function show_inventory()
	invx=mapx*8+8
	invy=mapy*8+8
	
	rectfill(invx,invy,invx+48,invy+24,0)
	print("inventory",invx+7,invy+4,7)
	print("keys "..p.keys,invx+12,invy+14,9)
end
-->8
-- le portail en 24 88

function draw_portail(x,y)
	
	for i=1,10 do
		srand(0.00001*rnd(i))
		circfill(x*8,y*8,(25-4*i)+rnd(6)*rnd(4)*cos(t()),15-i)
	end
end
-->8
-- animations

function toggle_tiles()
	for x=mapx, mapx+8 do
		for y=mapy, mapy+8 do
			if(is_tile(anim1,x,y))then
				swap_tile(x,y)
				--sfx(2)
			elseif(is_tile(anim2,x,y)) then
				unswap_tile(x,y)
				--sfx(2)			
			end
		end
	end
end

function anim_player()
	if (p.sprite ==66 and cos(1*t())>0) then
		p.sprite=68
	end
	if (p.sprite ==68 and cos(1*t())<0) then
		p.sprite=66
	end
end

function anim_sensei(sprite)
	if (sprite ==96 and cos(1*t())>0) then
		sprite=98
	end
	if (sprite ==98 and cos(1*t())<0) then
		sprite=96
	end
	return sprite
end

function anim_soso(sprite)
	if (sprite ==100 and cos(1*t())>0) then
		sprite=102
	end
	if (sprite ==102 and cos(1*t())<0) then
		sprite=100
	end
	return sprite
end

function anim_moutarde_explo(sprite)
	if (sprite ==74 and cos(1*t())>0) then
		sprite=76
	end
	if (sprite ==76 and cos(1*t())<0) then
		sprite=74
	end
	return sprite
end

function anim_ketchup_explo(sprite)
	if (sprite ==70 and cos(1*t())>0) then
		sprite=72
	end
	if (sprite ==72 and cos(1*t())<0) then
		sprite=70
	end
	return sprite
end

function anim_boss_explo(sprite)
	if (sprite ==195 and cos(1*t())>0) then
		sprite=197
	end
	if (sprite ==197 and cos(1*t())<0) then
		sprite=195
	end
	return sprite
end
-------------------------------------
-- diverses sous fonction draw
-------------------------------------


__gfx__
00000000000000000000000000000000000000000000000000400000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000004400000000000000000000044000000000000000000000044000000000000000000000000000000
00000000000000000000000000000000000000000000000004400000000000000000000444400000000000000000000444400000000000000000000000000000
00000000000000000440000000000000000000000000000000400000000000000000004444440000000000000000004444440000000000000000000000000000
00000440000000004444000000000000000000000000000000000000000000000000044444444000000000000000044444444000000000000000000000000000
00000440000000044444400000000000000000000000000000000000000000000000444444444400000000000000444444444400000000000000000000000000
00000440000000444444440000000000000000000000000000044444444000000004444444444440000000000004444444444440000000000000000000000000
00004444000004444444444000000000000000000000000000444444444400000044444444444444000000000044444444444444000000000000000000000000
00004444000044444444444400000000000000000000000004444444444440000444444444444444400000000444444444444444400000000000000000000000
00000440000444444444444440000000000000000000000044444444444444000000000000000000000000000000000000000000000000000000000000000000
0000044000444444444444444400000000000000000000044444444444444440000aaaaaaaaaaaa000000000000aaaaaaaaaaaa0000000000000000000000000
0000044000000000000000000000000000000000000000000000000000000000000aaa07aa07aaa000000000000aaa07aa07aaa0000000000000000000000000
000004400000aaaaaaaaaaaa0000000000000000000000000aaaaaaaaaaaa000000aaa00aa00aaa000000000000aaa00aa00aaa0000000000000000000000000
000004400000aaa07aa07aaa0000000000000000000000000aaa0aaaa0aaa000000aa0aaaaaa0aa000000000000aa0aaaaaa0aa0000000000000000000000000
000004400000aaa00aa00aaa0000000004400000000000000aaaa0aa0aaaa000000aaa66aa66aaa000000000000aaa688886aaa0000000000000000000000000
000004400000aa0aaaaaa0aa0000000044444444440000000aaaaaaaaaaaa00000006666666666000000000000006668ee866600000000000000000000000000
000004400000aaa66aa66aaa0000000044444444444000000aaa688886aaa0000006666600666660000000000006666600666660000000000000000000000000
00000440000006666666666000000000044000000044000000666888866600000066660000006666000000000066660000006666000000000000000000000000
00000440000066666006666600000000000000000044000006666600666660000066600000000666000000000066600000000666000000000000000000000000
0000044000066660dddd066660000000000000000044000066660dddd06666000006600000000660000000000006600000000660000000000000000000000000
00000440dd06660dddddd066600000000000000000440dd06660dddddd8866000000660000006600000000000000660000006600000000000000000000000000
00000440ddd0660dddddd0660d0000000000000000440ddd0680dddddd8660d00000066000066000000000000000066000066000000000000000000000000000
0000044000000660dddd06600dd00000000000000044000000680dddd06600dd0000666000066600000000000000666000066600000000000000000000000000
00000440000060660dd066060dd000000000000000440000060660dd066060dd0006660000006660000000000006660000006660000000000000000000000000
00000440000006660dd066600dd000000000000000440000006660dd066600dd0000000000000000000000000000000000000000000000000000000000000000
00000440000066600dd006660dd000000000000000440000066600dd006660dd0000000000000000000000000000000000000000000000000000000000000000
000004400000660d00dd00660dd0000000000000004400000660d00dd00660dd0000000000000000000000000000000000000000000000000000000000000000
0000044000000d0dd0dd0dd000000000000000000044000000d0dd0dd0dd00000000000000000000000000000000000000000000000000000000000000000000
0000044000000d0dd0ddd0d000000000000000000044000000d0dd0ddd0d00000000000000000000000000000000000000000000000000000000000000000000
0000044000000000044d000000000000000000000044000000000044d00000000000000000000000000000000000000000000000000000000000000000000000
00000440000000000000000000000000000000000044000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000044000000dddd00dddd000000000000000000044000000dddd00dddd00000000000000000000000000000000000000000000000000000000000000000000
0004444440000000000444444000000000004444440000000080000000000000000000000000000000a000000000000000000000000000000000000000000000
0044444444000000004444444400000000044444444000000080000000000000008000000000000000a000000000000000a00000000000000000000000000000
00444aaaa400000000444aaaa40000000004444444400000088800000000000000800000000000000aaa00000000000000a00000000000000000000000000000
004491aa14000000004491aa1400000000044aaaa440000088888000000000000888000000000000aaaaa000000000000aaa0000000000000000000000000000
00049aaaa000000000049aaaa0000000000491aa1400000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
00009aaaa000000000009aaaa000000000049aaaa000000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
00eeeaaaee00000000eeeaaaee00000000009aaaa000000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
00eeeeeeee00000000eeeeeeee00000000eeeaaaee00000081818000000000008181800000000000a1a1a00000000000a1a1a000000000000000000000000000
0e0eeeeee0e000000e0eeeeee0e0000000eeeeeeee00000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
0e0eeeeee0e000000e0eeeeee0e000000e0eeeeee0e0000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
a00eeeeee0e00000a00eeeeee0e000000e0eeeeee0e0000081118000000000008111800000000000a111a00000000000a111a000000000000000000000000000
000eeeeee0a00000000eeeeee0a000000a0eeeeee0e0000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
000cccccc0000000000cccccc0000000000eeeeee0a0000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
000cc000c0000000000cc000c0000000000cccccc000000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
000c0000c0000000000c0000c0000000000c0000c000000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
000a0000a0000000000a0000a0000000000a0000a000000088888000000000008888800000000000aaaaa00000000000aaaaa000000000000000000000000000
00004440000400000000000000000000000000000000000000008880000000000000000880000000000008f00000000000000008800000000000000000000000
000444440004000000004440000400000000888000000000000888880000000000000088880000000000888f0000000000000088880000000000000880000000
00444444400440000004444400040000000888880000000000088f88f0000000000008888880000000088888f000000000000888888000000000008888000000
0444444444040000004444444004400000088f88f000000000088888800000000000088888800000000888888000000000000888888000000000088888800000
000a1aa10004000004444444440400000008888880000000000088a880000000000008fc8fc000000008fc8fc0000000000008fc8fc000000000088888800000
000aa66a00040000000a1aa100040000000088a8800000000000088a80000000000008ff8ff000000008888880000000000008ff8ff000000ee008fc8cf00e00
00066aa600040000000aa66a000400000000088a80000000e888888a8800e000000008888880000000088888800000000000088888800000008008ff8ff00e00
00dd666dd004000000066aa60004000000e0888a880e00000000888a88080000ee0008e88e8000ee0008888880000000ee0008e88e8000ee0080088888800800
0d0d666d0dd1000000dd6666d00400000080888a880800000000088a808000008000888ee888008000888ee8880000008000888ee88800800080088ee8800800
d00dd6dd000400000d0dd6660dd100000008088a808000000000088a8000000080088888888880800888e88e888000008008888888888080008088eeee880800
000dd1dd000400000d0dd1d6000400000000088a80000000000088a8800000008888888aa888888088888aa88888ff8e8888888aa88888800088888888888800
0001141100040000010dd1dd00040000000088a88000000000088a88880000000000088aa88000008008faa88000f0000000088aa88000000088888aa8888800
000ddddd00040000000114110004000000088a88880000000008a888080000000000088aa880000008088fa88000f0000000088aa88000000000088aa8800000
000ddd0d00040000000ddddd000400000008a8880800000000088880080000000000088aa8800000008e8af88000f0000000088aa88000000000088aa8800000
000d000d00040000000d000d00040000000888800800000000008000080000000000088aa8800000000e8aaff00000000000088aa88000000000088aa8800000
000d000d00040000000d000d000400000000e0000e0000000000e0000e0000000000088aa880000000088aa8f00000000000088aa88000000000088aa8800000
000000000000000000000000000000000000000000a000a0a000a000000000000000088aa880000000088aa88000000000000000000000000000000000000000
00a000a0a000a0000000000000a000a0a000a000000a00a0a00a0000000000000000088aa880000000088aa88000000000000000000000000000000000000000
000a00a0a00a000000000000000a00a0a00a00000000aaaaaaa00000000000000000088aa8800000000ffffff000000000000000000000000000000000000000
0000aaaaaaa00000000000000000aaaaaaa000000000888888880000000000000008888aa88800000ffffaaf8800000000000000000000000000000000000000
000088888888000000000000000088888888000000088788887800000000000000088888a88880000f88f8a88880000000000000000000000000000000000000
0008878888780000000000000008878888780000000887788778000000000000000880028888800008800288ff80000000000000000000000000000000000000
000887788778000000000000000887788778000000f888888888ff0000000000000880002228800008800022f880000000000000000000000000000000000000
00f888888888ff000000000000f888888888ff000fff88888888ffa00000000000eee000000ee000eee000000ee0000000000000000000000000000000000000
0fff88822288ffa0000000000fff88822288ffa0faffff822288ffa0000080000000000000008000000000000000a000000000000000a0000000000000000000
faffff288828ffa000000000faffff288828ffa0ffaffff22288ffa0000080000000000000008000000000000000a000000000000000a0000000000000000000
ffaffff88888ffa000000000ffaffff88888ffa0fffafff88888ffaf0088888000000000008888800000000000aaaaa00000000000aaaaa00000000000000000
fffafff88888ffaf00000000ffffaff88998ffafffffaff88998ffaf0088888000000000008888800000000000aaaaa00000000000aaaaa00000000000000000
ffffaff88998ffaf00000000fffffaf88998ffaffffffaf88998ffaf088888880000000008888888000000000aaaaaaa000000000aaaaaaa0000000000000000
fffffaf88998ffaf00000000ffffffa88aa8faffffffffa88aa8faff88888888800000008888888880000000aaaaaaaaa0000000aaaaaaaaa000000000000000
ffffffa88aa8faff00000000fffffffaaaaaa8fffffffffaaaaaa8ff88888888800000008888888880000000aaaaaaaaa0000000aaaaaaaaa000000000000000
fffffffaaaaaa8fff0000000ffffffff8aa998ffffffffff8aa998ff088888880000000008888888000000000aaaaaaa000000000aaaaaaa0000000000000000
0fffffff8aa998ffff000000000000a0a000000000a000a0a000a000888888888000000008888888800000000aaaaaaaa0000000aaaaaaaaa000000000000000
0ffffffff889998fff00000000aa00a0a00aa000000a00a0a00a0000888888888000000008888888800000000aaaaaaaa0000000aaaaaaaaa000000000000000
0ffffffff889998fff0000000000aaaaaaa000000000aaaaaaa000008888888880000000008888888000000000aaaaaaa0000000aaaaaaaaa000000000000000
00fffffff889998fff0000000000888888880000000088888888000088888888800000000008888880000000000aaaaaa0000000aaaaaaaaa000000000000000
00ffffff88889988800000000008877887780000000887788778000088888888800000000008888880000000000aaaaaa0000000aaaaaaaaa000000000000000
000fff888888998880000000000887788778000000088778877800008888888880000000008888888000000000aaaaaaa0000000aaaaaaaaa000000000000000
0000fff8888888880000000000f888888888ff0000f888888888ff00888888888000000008888888800000000aaaaaaaa0000000aaaaaaaaa000000000000000
0000000088888880000000000fff88822288ffa00fff88822288ffa081888881800000008888888880000000aaaaaaaaa0000000a1aaaaa1a000000000000000
000000000000000000000000faffff2eee28ffa0faffff2eee28ffa081188811800000008118881180000000a11aaa11a0000000a11aaa11a000000000000000
000000a0a000000000000000ffaffff8e888ffa0ffafff2eee28ffa088888888800000008888888880000000aaaaaaaaa0000000aaaaaaaaa000000000000000
00aa00a0a00aa00000000000fffafff88888ffaffffafff22288ffaf88888888800000008888888880000000aaaaaaaaa0000000aaaaaaaaa000000000000000
0000aaaaaaa0000000000000ffffaff88998ffafffffaff88998ffaf81888881800000008888888880000000aaaaaaaaa0000000a1aaaaa1a000000000000000
000088888888000000000000fffffaf88998ffaffffffaf88998ffaf88188818800000008888888880000000aaaaaaaaa0000000aa1aaa1aa000000000000000
000887788778000000000000f444ffa88aa8fafff444ffa88aa8faff88811188800000008881118880000000aaa111aaa0000000aaa111aaa000000000000000
00088778877800000000000040004ffaaaaaa8fe40004ffaaaaaa8fe88888888800000008818881880000000aa1aaa1aa0000000aaaaaaaaa000000000000000
00f888888888ff0000000000000004ff8aa99ee0000004ff8aa99ee0088888880000000008888888000000000aaaaaaa000000000aaaaaaa0000000000000000
0fff88822288ffa000000000000a0000a00000000000000000000000ffffffffffffffff00000000499799999997999999997994000000000000000000000000
faffff2eee28ffa0000000000000aaaa00000000000a0000a0000000ffffffffffffffff00000000949799999997999999997949000000000000000000000000
ffaffff8e888ffa000000000000f8888000000000000aaaa00000000ffffffffffffffff00000000994777777777777777777499000000000000000000000000
fffafff88888ffaf0000000000f878878f000000000f888800000000ffffffffffffffff00000000777499999799997999994777000000000000000000000000
ffffaff88998ffaf000000000ff888888ff0000000f878878f000000ffffffffffffffff00000000997949999799997999949799000000000000000000000000
fffffaf88998ffaf00000000faff88888ffa00000ff888888ff00000ffffffffffffffff00000000997994777777777777499799000000000000000000000000
f444ffa88aa8faff00000000ffaf88888faf0000faff82228ffa0000ffffffffffffffff00000000997997499997999994799799000000000000000000000000
40004ffaaaaaa8fef0000000fffa88888aff0000ffaf28882faf0000ffffffffffffffff00000000997997949997999949799799000000000000000000000000
000004ff8aa99ee000000000ffffa898afff0000fffa88888aff0000555555555555555500000000997997996666666699799799444444444444444400000000
000004fff889ef0000000000ffff8aaa8fff0000ffffa898afff000066665555666655550000000099777799ffff666699777799444444444444444400000000
000004fff88eef0000000000ffff88988fff0000ffff8aaa8fff0000555555555555555500000000997997996666666699799799444444444444444400000000
000004fff8eeef00000000000fff8898ffff0000ffff88988fff0000555555555555555500000000997997996666666699799799444444444444444400000000
000444ff8e8e99ff000000000ffff898ffff00000fff8898ffff000055566666555666660000000077799777666fffff77799777444444444444444400000000
000fff88888e9988f00000000ffff898fff000000ffff898ffff0000555555555555555500000000997997996666666699799799444444444444444400000000
0000fff8888e88880000000000fff898880000000ffff898fff0000066655555666555550000000099777799fff6666699777799444444444444444400000000
000000008888888000000000000088888800000000fff89888000000555555555555555500000000997997996666666699799799444444444444444400000000
ffffffffffffffff4a4444a44a4aa4a45555555555555555ffffffccfeffffffffffffffffffffff997997949997999949799799ffffffff555555555555555f
ffffffffffffffff4a4444a4161991615554455555500555fffffcccf3fffffff8fff8fff4fff4ff997997499997999994799799ffffffff5554455555544558
444fffffffffffff4a4444a4111111115444444550000005ffff5ccff3f33fff484f484f484f484f997994777777777777499799ffffffff5555f5555555f588
49444444ffffffff4a4444a4111111115444444550000005ffff5ffff3f33feff4fff4fff4fff4ff997949999799997999949799ffffffff55666665f8888855
4f494494ffffffffaaa99aaa191111915114444550000005fff55ffff3333f3fffffffffffffffff777499999799997999994777ffffffff5656665655588855
4f4f94f4ffffffff191991914a4444a45444464550000005fff5fffffff33f3ff8fff8fff4fff4ff994777777777777777777499ffffffff55f333f555544455
444ff9f9ffffffff4a4444a44a4444a45114444550000005ff55fffffff3333f484f484f484f484f949799999997999999997949ffffffff5553535555545455
999fffffffffffff4a4444a44a4444a45444444550000005f55ffffffff33ffff4fff4fff4fff4ff499799999997999999997994ffffffff555f5f55555f5f55
ffffffff1111111144444444ffffffff1111111144444444994444444499449999444444f999999f155555512222222266666666666666665555555555555555
ffffffff1111111144444444f999f99fccc111114449444499449994444444999944999499999999556555552222222266666666ffff66665f54455555555555
ffffffff1111111144444444ffffffff11111111999499949944444444444499994444449949994955555555222222224446666666666666575f555555555555
ffffffff1111111144444444ffffffff11ccc1114444444499444444999444999944444449999999555555652222222249444444666666665777777f55555555
ffffffff1111111144444444fff999ff111111114449444499499444444444999949944499994999565555552222222246494494666fffff5577755555555555
ffffffff1111111144444444ffffffff11111cc19994999499444444444444999944444499949999c855555522222222464694646666666655ccc55555555555
ffffffff1111111144444444f999ffff1111111144444444994444444994449999444444d999949fc88555512222222244466969fff6666655c5c55555555555
ffffffff1111111144444444ffffffff1cccc11144444444994449944499449999444994ddddddffccc5511122222222999666666666666655f5f55555555555
__gff__
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000101010101010101000000000000000001010101010101010000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000400000010101000000000000000000004000400100014000000200030105002001091001010101000000010000010000000001014002000000
__map__
cacbcbcbcbcbcc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e7e7e7e7e7f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f1f1f1f1f1f1f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0
dcdbdbdbdbdbdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e7f0f0e0e7f0f0edf0f0f0f0edf0edededededededededededf0f0f0f0f0f1f1f4f1f1f1f0f0f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f0
dcdbdbdbdbdbdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e7f3f0ede7f0f0e7f0f0f0f0e7f0e7e7e7e7e7e7e7e7e7e7e7e7f0f0f0f0f1f1f1f1f1f1f0f0f9f9e7e7e7e7e7e7e7e7e7f9f9f9f9f0
dcdbdbdbdbdbdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e7f0ede7e7f0e7e7f0f0edede7f0e7e7f0f0f0f0f0f0f0f0f0e7ededf0f0f1f1f1f4f1f1f0f0e7e7d8d8d8d8d8d8d8d8e7e7f9f9f9f0
dcdbdbdbdbdbdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e7f0e7e7e7e0e7f0f0ede7e7f0f0f0e7f0edededededededf0f0e7e7f0f0f0f1f1f1f1f1f1f0e7d8d8d8d8d8d8d8d8d8d8e7e7f9f9f0
dadbdbdbdbfcdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e7f0f0f0e7ede7f0f0e7f0f0f0f0e7e7f0e7e7e7e7e7e7e7edf0f0e7f0f0f0f1f1f1f1f1f1f0e7d8d8d8d8d8d8d8d8d8d8d8e7e7f9f0
dadbdbdbdbdbdc00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e7f0f0f3e7e7e7f0f0e7e7e7e7e7e7f0f0f0f0f0f0f0f0f0e7edede7f0f0f0f0f1f1f1f4f1f0e7d8d8d8d8d8d8d8d8d8d8d8d8e7f9f0
eaebebe4ebebec00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e7e7f0f0f0f3f0f0f0f0f0f0f0f0f3f0f0f0f0edededf0f0f0e7e7e7f0f0f0f0f1f1f1f4f1f0e7e7d8d8d8d8d8d8d8d8d8d8d8e7e7f0
f9e7f0f0f0f0e7f9f9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1edf0f0f0f0f0f0f3f0f0f0f0f0f0f0edede7e7e7edf0f0e7f0f0f0f0f3f0f1f1f1f1f1f0f9e7d8d8d8d8d7d8d8d8d8d8d8d8e7f0
f9f0f0f0f0e7f0f9f900000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1ededededededededededede7f0f0e7e7e7e7e7e7f0f0e7f0f0f0f0f0f0f0f1f1f1f1f0f9e7d8d8d8d8d8d8d8d8d8d8d8d8e7f0
f9f0f0fbf0f0f0f9f9000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f1f1f1f1f1e7f0f0f0f0f0f0f0e7f0f0e7f0f0f0f0f0f0f1f1f1f1f4f0f9e7e7d8d8d8d8d8d8d8d8d8d8e7e7f0
f9f0f0fbf0f0f0f9f90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f100000000000000f1f1f1f1f1f4f1f1f1f1e7edededededf0f0e7f0f0e7f0f0f0f0f0f0f1f1f1f1f1f0f9f9e7d8d8d8d8d7d8d8d8d8d8e7f9f0
f9f0f0f0f0f0f0f9f90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f4f1f1f1f1f1f1f1f1f1f1f4f1f1f1f1f1f1f1f1f1f1f1f1f1f4f1f1f1f1f1f1f1f1e7e7e7e7e7e7f3f0e7f0f0e7f0f0f0f0f0f0f1f1f1f1f1f0f9f9e7e7d8d8d8d7d8d8d8d8e7e7f9f0
f9e1e1e1e1e1e1f9f90000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f4f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1e7f0f0e7f0f0e7f0f0f0f3f0f0f1f1f4f1f1f0f9f9f9e7e7e7d8d8d8d8e7e7f9f9f9f0
f9e1e1e1e1e1e1f9e10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f1f1f4f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f4f1f1f1f4f1e7f0f0e7f0f0e7f0f0f0f0f0f0f1f1f1f1f0f0f9f9f9f9f9e7f3f0f3e7e7f9f9f9f9f0
f9f9f9f9f9f9f9f9e10000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f0f0f0f0f0f0f0f0f0f0f0f9f1f4f1f1f1f1f1f1f1f1f1f1e7f0f0e7e7e7e7f0f0f0f0f0f0f0f1f1f1f1f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0f0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f5f5f5f5f5e8f5f5e9f5f5e8f0f0f0f0f0c7f0f0f0f0f0f9f1f1f1f1f1f1f1f1f1f1f9f9f0f0f0f0f9f9f0f0f0f0f3f0f0f0f1f1f1f1f1f1f1f1f0f0f0f0f0f0f0f0f0f0f0f0f0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f5f5f5f5f5e8f5f5e9f5f5e8f0f0f0f0f0f0f0f0f0f0f0f9f1f1f1f1f9f9f9f1f9f9f0f0f0f0f0f0f0f9edededf0f0f0f0f3f1f1f4f1f1f1f4f1f0f0f0f0f0f3f0f0f0f0f0f0f0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f5f5f5f5f5f1f1f1f1f1f1f1f0f9f0f9f9f0f0f3f0f0f0f9f1f4f1f1f9f0f0f9f0f0f0f0f0f0f0f0f0f0f9f9f9edf0f0f0f0f1f1f1f1f1f1f1f1f0f0f0f0f0f0f0f0f0e7f0f0f0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f5f5f5f5f5f1f1f1f1f1f1f1f9f0f9f0f0f0f0f0f0f0f0f0f1f1f1f1f0f0f0f0f0f0f0f0f0e7f0f0f3f0f0f0f9f9ededf0edf1f1f1f1f1f1f4f1f0f0f0f0f0f0f0f0f0f0f0f0f0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f4f1f1f1f5f5f5f5f5f1f1f4f1f1f1f1f0f0f0f0f0f0f0edf0f0f0f0f1f9f1f0f0f0f0f0f0f0f0f0f3f0f0f0f0f0f0f0e7f0f9f9e4f9f9f1f1f1f1f1f1f1f0f0f3f0f3f3e7f3f0f0f0f0f0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f5f5f5f5f5f1f1f1f1f1f1f1f0f0f0f0edf0f0e7f0f3f0f0f9f0f0f0f0f0f0f3f0f0f0f0e7f0f0f0f0f0f0e7e7f0f0f0f0f0f9f1f1f1f4f1f1e7f0f0f0ededf0f0f0f0f0f0f0f0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f5f5f5f5f5f1f1f1f1f1f1f1f0f0f0ede7f0f0e7f0f0f0f0f0f0f0f0f0f0f0f0e7e7f0e7f0edf9ededede7e7f0f0e7f0f0e7f9f1f4f1f1f1f1e7f0f0f0f0e7f0f0f0f0f0f0f0f0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f1f1f1f0f0f0f0f0f1f1f1f1f1f4f1ededede7e7f0f0e7f0f0f0f0f0ededf0edf0f0f0f3f3f0f0edf9fff9f9f9f0f0f0f0f0f0f0f0f9f1f1f1f1e7e7f0f0f3f0ede7f0f0f0f0f3f0f0f0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f0f0f0f0f0f0f0f0f0f0f1f1f1f1f1e7e7e7e7f0f0f0e7f0f0f0f0edf9f9e4f9edf0f0f0f0f0f0f9eefffffffff9f0f0f0f3f0f0f0f9f1f1f1e7f0f0f0ededf0e7e7f0f0f0f0f0f0f0f0
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000f1f1f0f0f3f0f0f0f3f3f3f0f1f1f1f1f1f0f0f0f0f0e7e7f0f0f0f0f0f9f2f2f2f5f9f0f0f0f0f0f0f9fefffffffff9f0f0f0f0f0f0f0e7e7e7e7f0f3f0edf0e7ede7f0f0f0f0f0f0f0f0f0
000000000000000000000000000000000000000000000000000000000000000000000000000000000000d0000000000000000000f1f1f0f0f3f0f0f0f0f3f0f0f1e7e7e7e7f0f0f0f0f0e7e7ededededede7f5f2f2f2f9f0f0f0f3f0f0f9effffffffff9f0f0f0f0f3c7f0f0f0f0f0f0f3edf0f0ede7e7f0f0f0f0f0f0f0f0f0
0000000000000000000000000000000000000000000000000000000000000000000000000000000000d0d0000000000000000000f1f1f0f0f3f0f0f0f0f3f0f0f1e7e0f0e7f0f0e7e7e7e7e7e7e7e7e7e7e7f2f2ddf2f9f0f0f0f0f0f0f9fffffffffff9f0f3f0f0f0f0f0edededf3ededededede7e7f0f0f0f0f3f0f0f0f0f0
0000000000000000000000000000000000000000000000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0000000f1f1f0f0f3f3f3f0f3f3f0f0f1e7f0f0f0f0f0f0f0e8f0e9f0f0e8f0f5f5f5f2f2f2f9f0ededf0f0f0f9fffffffffff9f0f0f0f0f0f0f0e7e7e7e7e7e7e7e7e7e7f0f0f0f0f0f0f0f0f0f0f0
00000000000000000000000000000000000000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0d0d0000000000000f1f1edededededededededede7e7edededf0ededf0e8ede9edede8edf5f5f5f2f5f2f9edededf0edf0f0f9f9f9f9f9f0f0f0f0f3f0f0f0f0f0f0f0f0f0f0f0f0f0f0f3f0f0f0f0f0f0f0f0f0
000000000000000000000000000000000000000000000000000000000000000000d0d0d0d0d0d0d0d0d0d0000000000000000000f1f4f1f1f1f1f1f1f1f1f1f4f1f1f1f4f1f1f1f1f1f1f4f1f1f1f1f1f4f1f9f9f9f9f9f9f9f9edf9edf9f0f0f0f0f0edf0ededededededededededededededededededededededededededed
00000000000000000000000000000000000000000000000000000000000000000000d0d0d0d0d0d0d00000d0d0d0000000000000f1f1f1f1f1f1f1f4f1f1f1f1f1f1f1f1f1f1f4f1f1f1f1f1f1f1f1f1f1f1f1f1f1f1f4f1f1f1f1f1f4f1ededededededf9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9f9
__sfx__
010f00000b550095530b5000b550095530b5000b550095530b5500955309550095530c550095530b55009553075530555304553045530455317500075000b5000b5000b5000b5000b50001500035000650008500
011e00000e25010200102530e2501125011200102531125013250000001325000000112500e25028700102530e2500e200102530e250112501120010253112501725000000172500000013250102501020010253
012200001805511000130550e0001a0550000013055000001c0551c0001a0550000018055000000000021055110551305521055150551305515055320553405532055300552f0553005515055130551105500000
010f0000102550e2550e255102550e2550e255102550e2550e255102550e2550e2551125528255212552125528255212552125529255212552125528255212552125528255212552125526255262552825524255
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000600000405004040040200401005000070000800000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0004000012120131201413017140191401b1501e160241702e1701d10024100221002010020100201001f20020200242002920032200303002b3002a3002930028300283002830027400294002d400314003b400
000400001b0501c0501d0501f0502105024050270502b0502e050390503f050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000003c05036050310502b05025050210401a03017020110100000000000107000f7000f7000f7000f7000f7000f70010700147001b700237002b7002e700297001b700167001570017700337003370028700
000900001212019130231302a140311403a1503d1503d0003f0503e0003f0503e0003f0003d1003960037600346002f6002a6002560021600196001560031000116000a600056000160035000360000000000000
001000000a55002300142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000c55002300142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001055002300142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001255002300142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001855017500142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001c55017500142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000001e55017500142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002355017500142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002955025500142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000002f55001500142001200002000160000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000865000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__music__
02 01424344
03 02424344
03 03424344

