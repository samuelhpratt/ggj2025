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
#include sfx.lua
#include ui.lua
#include dialogue.lua
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
000000000000000000000000000000000000000000000000000000000000000000000000000ee000eeeeee00000000000000000000eeeeeeee00000000000000
000088bc67676767cb88000000000000000000000000000000000000000000000000000000e55eee555555eee000000000000000ee777aaaaaee000000000000
00088bc6666666666cb880000028280000000000000000000000000000000000000000000e565555677777555ee0000000000eee7a99999999aaeee000000000
0088bc777777777777cb880000888800000bbb0000000000000000000000000000000000e565555666556667755e00000000e77a99cccccccc999aae00000000
008bc77777777777777cb8000088a80000beeeb00bbbbbbbbbbbb00000000bb00000000e565dd55565ee55566675e000000e7a99cc00000000cc999ae0000000
00bc7777777777777777cb00008a88000be888ebb2eeeeeeeeeeebbbb0b0beeb000000e5656ddd5555e0eee55665e00000e7a9cc000000000000cc999e000000
00c777777777777777777c00008888000b22222eeeeeee777eeeee28ebeb788b00000e565666ddd555e0000ee5675e0000e79c0000000000000000c99e000000
007777777777777777777700008282000b2eeeee88887788877888287272e8b00000e56577666ddd555e00000e565e0000ea9c0000000000000700ca9e000000
00777777777777777777770000000000be88888e888ee88888ee8882e2e2222b000e5656677666ddd555e0000e5675e00e79c000000000000000700c99e00000
00777777777777777777770000000000b2222222888ee88888ee8882e2e2eeeb00e565d66677666ddd555e0000e565e00ea9c000000000000000000ca9e00000
007777777777777777777700000050000beeeee2889ee88888ee8882e2e2882b0e565ddd66677666ddd555e000e565e0e79c00000000000000000000c99e0000
007777777777777777777700055dd500be8888828989e88888ee8882e2e222b000e555ddd66677666ddd555e00e565e0e79c00000000000000000000ca9e0000
0077777777777777777777000c0dddd0b2888882889ee88888ee8882e2e2ee2b000e555ddd66677666ddd555e0e565e0ea9c00000000000000000000ca9e0000
007777777777777777777700000dd0500b222222888ee88888ee8882e2e288eb0000e555ddd66677666ddd555ee565e0ea9c00000000000000000000ca9e0000
0077777777777777777777000c0ddd500beeeee2888ee88888ee8882e2e2888b00000e555ddd66677666ddd55555675eea9c00000000000000000000c79e0000
00777777777777777777770000055500b2888882888ee88a88ee8882e2e2222b000000e555ddd66677666ddd5556665eea9c00000000000000000000c74e0000
007777777777777777777700000000000b288882888ee8a8a8ee8882828222b0000ee00e555ddd66677666ddd555665eea9c00000000000000000000c74e0000
0077777777777777777777000000000000b22222888ee88a88ee8882e2e2822b00e55e00e555ddd66677666ddd55565eea9c00000000000000000000ca4e0000
007777777777777777777700006d0000000bbbb2228ee88888ee88828282882b0e565e000e555ddd66677666ddd5555e0ea9c000000000000000000ca9e00000
00777777777777777777770006aad0000000000bbb2ee88888ee8882828222b00e5665e000e555ddd66677666ddd555e0ea9c000000000000000000ca4e00000
0077777777777777777777000daad000000000000b22ee888ee888288282222b0e5665eeeeee555ddd66677666ddd5e000e99c0000000000000000c79e000000
00777777777777777777770000dd50000000000000b2ee888ee888288282222b0e56655555555555ddd66677666d5e0000ea9c0000000000000000ca4e000000
0007777777777777777770000000050000000000000b282228822222828222b0e566dddddddddd555ddd666777d5e00000ea99cc000000000000cc794e000000
00007777777777777777000000000050000000000000b2222222222b8b8bbb00e566555dddd6666555ddd666775e0000000ea99acc00000000cc7a94d5e00000
007000000070a0600000000000000000000000000000b2222222bbb0b0b00000e565eee5555dddd6555ddd66d5e000000000e9999acccccccc7a944d6d5e0000
007000000070a06000000000000000000000000000000bbbbbbb0000000000000e5e000eeee5555dd555dddd5e00000000000eee999aaa777a44eee5d6d5e000
007aaa60007aaa600076a660000000000000000000000000000000000000000000e00000000eeee555555dd5e000000000000000ee99999444ee000e5d6d5e00
707aaa60707aaa60067aaa600000000000000000000000000000000000000000000000000000000eeee5555e000000000000000000eeeeeeee000000e5d6d5e0
667aaa60667aaa60067aaa6000000000000000000000000000000000000000000000000000000000000e55e0000000000000000000000000000000000e5d6d5e
067aa6d0067aa660067aa6d0000000000000000000000000000000000000000000000000000000000000ee000000000000000000000000000000000000e5d6de
000666000006660000066600000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000e5de0
007aaad0007aaad0007aaad00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000ee00
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
__sfx__
000100000d0500000000000000000000000000000100001000020060200602000020050202a520197502a5502a5502955020550215500e5500955003550015500055002550000000000000000000000000000000
001000002665029650216500365001650016500065001650016500065000650026500265002650006500165000000000000000000000000000000000000000000000000000000000000000000000000000000000
000a00003b0603b1403b1203b1103b010000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
