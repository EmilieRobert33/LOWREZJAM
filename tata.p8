pico-8 cartridge // http://www.pico-8.com
version 27
__lua__
-- my adventure game
--by emilie

function _init()
	poke(0x5f2c,3) -- cette ligne permet de mettre pico-8 en mode 64x64
	map_setup()
	make_player()

end

function _update()
	move_player()
end

function _draw()
	cls()
	draw_map()	
	if(p.itemsportail>0) then
	 draw_portail()
	end
	draw_player()
	if(btn(❎)) show_inventory()

end
-->8
-- map code

function map_setup()
	--map tile settings
	wall=0
	key=1
	door=2
	anim1=3
	anim2=4
	itemportail=5
	lose=6
	win=7

end

function update_map()

end

function draw_map()
	-- pour suivre le player 
	-- sur la map
	mapx=flr(p.x/8)*8
	mapy=flr(p.y/8)*8
	camera(mapx*8,mapy*8)
	
	map(0,0,0,0,63,63)
end

function is_tile(tile_type,x,y)
	tile=mget(x,y)
	has_flag=fget(tile,tile_type)
	return has_flag
end

function can_move(x,y)
	return not is_tile(wall,x,y)
end

function swap_tile(x,y)
	tile=mget(x,y)
	mset(x,y,tile+1)
end

function get_key(x,y)
	p.keys+=1
	swap_tile(x,y)
	sfx(3)
end

function open_door(x,y)
	p.keys-=1
	swap_tile(x,y)
	sfx(4)
end

function get_item_portail(x,y)
	p.itemsportail+=1
	swap_tile(x,y)
	sfx(5)
end

function draw_portail()
	for i=1,10 do
		srand(0.00001*rnd(i))
		circfill(31,31,(40-4*i)+rnd(6)*rnd(4)*cos(t()),15-i)
	end
end
-->8
-- player code

function make_player()
	p={}
	p.x=3
	p.y=2
	p.sprite=1
	p.keys=0
	p.itemsportail=0
end

function draw_player()
	spr(p.sprite,p.x*8,p.y*8)
end

function move_player()
	newx=p.x
	newy=p.y
	
	if(btnp(⬅️)) newx-=1
	if(btnp(➡️)) newx+=1
	if(btnp(⬆️)) newy-=1
	if(btnp(⬇️)) newy+=1
	
	interact(newx,newy)
	
	if (can_move(newx,newy)) then
		p.x=mid(0,newx,127)
		p.y=mid(0,newy,63)
	else
		sfx(1)
	end
	
end

function interact(x,y)
	if(is_tile(key,x,y)) then
		get_key(x,y)
	elseif(is_tile(door,x,y) and p.keys>0) then
		open_door(x,y)
	elseif(is_tile(itemportail,x,y)) then
		get_item_portail(x,y)
		draw_portail()
	end
end
-->8
--inventory code

function show_inventory()
	invx=mapx*8+40
	invy=mapy*8+8
	
	rectfill(invx,invy,invx+48,invy+24,0)
	print("inventory",invx+7,invy+4,7)
	print("keys "..p.keys,invx+12,invy+14,9)
end
-->8
-- le portail

function draw_portail()
	px=mapx*8+40
	py=mapy*8+8
	for i=1,10 do
		srand(0.00001*rnd(i))
		circfill(px,py,(25-4*i)+rnd(6)*rnd(4)*cos(t()),15-i)
	end
end
__gfx__
00000000000100000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000001111000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000a00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000059595000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000504540500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700006660000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000005050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
fffffffffffffffff999999f0000000000000000ffffffffffffffff00000000ffffffccffffffff000000000000000000000000000000000000000000000000
fffffffff999f99f999999990000000000000000ffffffffffffffff00000000fffffcccffffffff000000000000000000000000000000000000000000000000
ffffffffffffffff994999490000000000000000444fffffffffffff00000000ffff5ccfffffffff000000000000000000000000000000000000000000000000
ffffffffffffffff49999999000000000000000049444444ffffffff00000000ffff5fffffffffff000000000000000000000000000000000000000000000000
fffffffffff999ff9999499900000000000000004f494494ffffffff00000000fff55fffffffffff000000000000000000000000000000000000000000000000
ffffffffffffffff9994999900000000000000004f4f94f4ffffffff00000000fff5ffffffffffff000000000000000000000000000000000000000000000000
fffffffff999ffffd999949f0000000000000000444ff9f9ffffffff00000000ff55ffffffffffff000000000000000000000000000000000000000000000000
ffffffffffffffffddddddff0000000000000000999fffffffffffff00000000f55fffffffffffff000000000000000000000000000000000000000000000000
11111111111111111555555100000000000000004a4444a44a4aa4a4000000000000000000000000000000000000000000000000000000000000000000000000
11111111ccc111115565555500000000000000004a4444a416199161000000000000000000000000000000000000000000000000000000000000000000000000
11111111111111115555555500000000000000004a4444a411111111000000000000000000000000000000000000000000000000000000000000000000000000
1111111111ccc1115555556500000000000000004a4444a411111111000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111565555550000000000000000aaa99aaa19111191000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111cc1c85555550000000000000000191991914a4444a4000000000000000000000000000000000000000000000000000000000000000000000000
1111111111111111c885555100000000000000004a4444a44a4444a4000000000000000000000000000000000000000000000000000000000000000000000000
111111111cccc111ccc5511100000000000000004a4444a44a4444a4000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444449944444444994499000000005555555555555555000000000000000000000000000000000000000000000000000000000000000000000000
44444444444944449944999444444499000000005554455555500555000000000000000000000000000000000000000000000000000000000000000000000000
44444444999499949944444444444499000000005444444550000005000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444449944444499944499000000005444444550000005000000000000000000000000000000000000000000000000000000000000000000000000
44444444444944449949944444444499000000005114444550000005000000000000000000000000000000000000000000000000000000000000000000000000
44444444999499949944444444444499000000005444464550000005000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444449944444449944499000000005114444550000005000000000000000000000000000000000000000000000000000000000000000000000000
44444444444444449944499444994499000000005444444550000005000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
40404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000040404040404040404040404040404040404040404040404040404040404040404040404040404040404040
40404040404040404040404040404040404040404000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__gff__
0000000000000000000000000000000000000100000200002000000000000000010101000003010000000000000000000000000000050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__map__
1010101010101010121210101010101010101010101010101010111111101004040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101012121010251010101010101010102020201010101011101004040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101012121010101010101010101020202020202010101011111004040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1011101010101010121210101010101010101020202120212020101010111004040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1011111010101010101212121210101010101020202020202120101010111004040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010111110101010101010101212121010101010202120202020101010111003040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010111111101010101010101010121212121212202020201010101010111003040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101111111111111111111010101010101010101010101010101010111003040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101010111010101010101010101010101010101010111003040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101011111011111111111111111110101010101011111003040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101011111111111011111111111111111010101010111003040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101010101111101010101010101010101011111111101011101003040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010151010101010111110101010101010101010101010101011111111103103040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101011111010101010101010101010101010101010101010103503040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1010101010101011111010101010101010101010101010101010101010103103040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
1212121212121235121212121212121204040404040404040404040404040403040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303031303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303031303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303031303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303304040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
3230303030303030303030303030303314140404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040404040400000000000000000000000000000000000000000000000000000000000000000000000000000000000000
__sfx__
000100000105000030000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000300000c05008050000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
001000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400001d05031050340403504038030000200000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
000400000575009750137501c7502e75023740187400f73001710007100075000100021002a10027100321002b10034100341002c100271002d100311002d1002d1001a1002d100191002e1002e1002e1002f100
0006000001010010100101002010030200402006020080300a0400e0501206017070210703f0703f0303f0103f0503f0503f0503e0503d0503d0503c0503b0503b0503b0503b0503b0503f0503f0503f0501e000
000d01001d6201a6301863014640116500e6600c6700b6700b6600b6500c6300d6200f6101261015610176201a6301b6301c6401c6501c6501a65018660156601265010650106501164012630146301665000000
