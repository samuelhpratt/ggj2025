pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- ggj 2025 - bubble!
#include debugLines.lua
#include logs.lua
#include main.lua
#include dome.lua
#include objects.lua
#include people.lua
#include water.lua
#include fire.lua
#include food.lua
#include ui.lua
#include worldInfo.lua

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000707000007070000070700000707000007070000070700
00700700000000000000000000000000000000000000000000000000000000000000000000000000007777700077777000777770007777700007770000077700
00077000000000000077700000777000077777000777770000000000000000000000000000000000000777000007770000077700000777000007770000077700
00077000000000000077700000777000077777000777770007777700077777000007770000077700007777700077777000077700000777000007770000077700
007007000000a0000070700000707000007070000070700007777700077777000007770000077700000777000007770000077700000777000007770000077700
00000000000a0a000070700007707000007070000770700000707000077070000007770000777700000707000077070000070700007707000007070000770700
000000000000a0000770770000007700077077000000770007707700000077000077077000000770007707700000077000770770000007700077077000000770
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000070007000700070000000000000000000000000000000000000000000000000000000000000000000000000000000000
00070700000707000000000000000000077777000777770007000700070007000000000000000000000000000000000000000000000000000000000000000000
00077700000777007777777077777770077777000777770007777700077777000000000000000000000000000000000000000000000000000000000000000000
00077700000777000777770007777700007070000070700007777700077777000000000000000000000000000000000000000000000000000000000000000000
00077700007777000070700007707000007070000770700000707000077070000000000000000000000000000000000000000000000000000000000000000000
00770770000007700770770000007700077077000000770007707700000077000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fff000fff000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000fff000fff000000000000
00000000000000000000000000000000000000000fffffffffffff000000000000000000000fffffffff000000000000000000000fffffffffffff0000000000
00000000000500555005000000055000000500000fffffffffffff000000000000000000000fffffffff000000000000000000000fffffffffffff0000000000
00000000000005757500000000000005000000000fffffffffffff000000000000000000000fffffffff000000000000000000000fffffffffffff0000000000
00000000000005757500000000000050500000000fffffffffffff000fffffffffffff00000fffffffff0000000fffffffff0000000fffffffff000000000000
00000000000000555000000000000000000000000fffffffffffff000fffffffffffff00000fffffffff0000000fffffffff0000000fffffffff000000000000
00000000000000000000000000000000000000000fffffffffffff000fffffffffffff00000fffffffff0000000fffffffff00000fffffffffffff0000000000
0000000000000000000000000000000000000000000fff000fff00000fffffffffffff00000fff000fff0000000fffffffff00000fffffffffffff0000000000
0000000000000000000000000000000000000000000fff000fff00000fffffffffffff00000fff000fff0000000fffffffff00000fffffffffffff0000000000
0000000000000000000000000000000000000000000fff000fff00000fffffffffffff00000fff000fff0000000fffffffff0000000fff000fff000000000000
0000000000050000000500000005500000550000000fff000fff0000000fff000fff0000000fff000fff0000000fff000fff0000000fff000fff000000000000
0000000000050055500500000000500000050000000fff000fff0000000fff000fff0000000fff000fff0000000fff000fff0000000fff000fff000000000000
0000000000000550550000000000000000000000000fff000fff0000000fff000fff0000000fff000fff0000000fff000fff0000000fff000fff000000000000
0000000000000000000000000000000500000000000fff000fff0000000fff000fff0000000fff000fff0000000fff000fff0000000fff000fff000000000000
000000000000000000000000000000000000000000000000007000000070a0600000000000000000000000000000000000000000000000000000000000000000
000088bc67676767cb880000000000000000000000000000007000000070a0600000000000000000000000000000000000000000000000000000000000000000
00088bc6666666666cb880000028280000005000006d0000007aaa60007aaa600076a66000000000000000000000000000000000000000000000000000000000
0088bc777777777777cb880000888800055dd50006aad000707aaa60707aaa60067aaa6000000000000000000000000000000000000000000000000000000000
008bc77777777777777cb8000088a8000c0dddd00daad000667aaa60667aaa60067aaa6000000000000000000000000000000000000000000000000000000000
00bc7777777777777777cb00008a8800000dd05000dd5000067aa6d0067aa6d0067aa6d000000000000000000000000000000000000000000000000000000000
00c777777777777777777c00008888000c0ddd500000050000066600000666000006660000000000000000000000000000000000000000000000000000000000
007777777777777777777700008282000005550000000050007aaad0007aaad0007aaad000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00777777777777777777770000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077777777777777777700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00007777777777777777000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000008000000008000000000000000000000000000000000000000000000000000
000000000000000000aa000000000000000000000000000000080000000080000000000000a00000000080000000000000000000000000000000000000000000
000000000000000000aa00000000000000000000000000000000900000000000008909000000900000a000000000000000000000000000000000000000000000
00000000000bb000000bb00000000000000000000000000000000000008090000000900000000900000090000000000000000000000000000000000000000000
00000000000b0000000b000000000000000000000000000000809000000009000009990000900000000009000000000000000000000000000000000000000000
00bb000000bb000000bb0000000000000070070007000070009aa900009aaa00009aa900009aa900009aaa000000000000000000000000000000000000000000
000b0000000b0000000b0000000770000007000000000000000aa000000aa000000aa000000aa000000aa0000000000000000000000000000000000000000000
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
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11aaaa1aaaa11aa111aaaa1aaaa11aaa1aaaa1111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11aa1a1aa1a1aa1a111aa11aa111aa1111aa11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11aa1a1aa1a1aa1a111aa11aaa11aa1111aa11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11aaaa1aaaa1aa1a1a1aa11aa111aa1111aa11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11aa111aaa11aa1a1aaaa11aaaa1aa1111aa11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11aa111aa1aa1aa111aa111aaaa11aaa11aa11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
1111111111111111111bbbbb1111e81111111e8111e81111111e81111e88888881111e8811111111111111111111111111111111111111111111111111111111
11ee1111111111e8111b1b1b111e88811111e8881e88811111e88811e88888888811e88881111111111111111111111111111111111111111111111111111111
11e8811111111e88211bbbbb11188881111e8888188881111e888811888888888821888882111111111111111111111111111111111111111111111111111111
11e888111111e8882111bbb11118888111e8888218888111e8888211888888888211888882111111111111111111111111111111111111111111111111111111
11e88881111e8888211bb1bb111888811e8888211888811e88882111888222222111888882111111111111111111111111111111111111111111111111111111
11e8888811e888882111111111188881e8888211188881e888821111888111111111888882111111111111111111111111111111111111111111111111111111
11e88888888888882111e8811118888e8888211118888e8888211111888888881111888882111111111111111111111111111111111111111111111111111111
11e8888888888888211e888811188888888211111888888882111111888888888111888882111111111111111111111111111111111111111111111111111111
11e88888888888882118888821188888882111111888888821111111888888888211888882111111111111111111111111111111111111111111111111111111
77e88888888888882778888827788888827777777888888277777777888888882777888882777777777777777777777771711711117111111111111111111111
77e88888888888882778888827788888277777777888882777777777888222227777888882777777777777777777777717171111111111111111111111111111
77e88888888888882778888827788888877777777888888777777777888277777777888882777777777777777777777171717111711111111111111111111111
77e88822882288882778888827788888887777777888888877777777888277777777888882777777777777777777777717171111111111111111111111111111
77e88827227788882778888827788888888777777888888887777777888277777777888882777777777777777777777771711711111111111111111111111111
77e88827777788882778888827788888888877777888888888777777888277777777888882777777777777777777777777171117111111111111111111111111
11e88821111188882118888821188888888881111888888888811111888211111111888882111111111111111111111111111111111111111111111111111111
11e88821111188882118888821188882888888111888828888881111888211111111888882111111111111111111111111111111111111111111111111111111
77e88827777788882278888827788882188888877888827888888777888888888777888888888777777777777777777177171111111111111111111111111111
11e88821111188882118888821188882118888881888821188888811888888888821888888888821111111111111111111111111111111111111111111111111
11e88821111188882118888821188882111888882888821118888821888888888821888888888821111111111111111111111111111111111111111111111111
11188211111118821111888211118821111188821188211111888211188888888211188888888211111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111
