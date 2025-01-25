pico-8 cartridge // http://www.pico-8.com
version 42
__lua__
-- ggj 2025 - bubble!
#include logs.lua
#include main.lua
#include dome.lua
#include objects.lua
#include people.lua
#include ui.lua
poke(0x5F2D, 1) -- enable mouse

__gfx__
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00700700000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00077000000000000077700000777000007770000777770007777700077777000000000000000000000000000000000000000000000000000000000000000000
00077000000000000077700000777000007770000777770007777700077777000777770007777700077777000007770000077700000777000000000000000000
00700700000000000070700000707000007070000070700000707000007070000777770007777700077777000007770000077700000777000000000000000000
00000000000880000070700007707000007077000070700007707000007077000070700007707000007077000007770000777700000777700000000000000000
00000000000880000770770000007700077000000770770000007700077000000770770000007700077000000077077000000770007700000000000000000000
00000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
00000000006666600007070000070700000707000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000
0000000006600600007777700077777000777770000000000000000000000000000000000000000000000000000000000000000000aa00000000000000000000
0000000006000600000777000007770000077700000000000000000000000000000000000000000000000000000000000000000000aa00000000000000000000
000000000660060000777770007777700077777000000000000000000000000000000000000000000000000000000000000bb000000bb0000000000000000000
000000000060060000077700000777000007770000000000000000000000000000000000000000000000000000000000000b0000000b00000000000000000000
000000006666660000070700007707000007077000000000000000000000000000000000000000000000000000bb000000bb000000bb00000000000000000000
0000000000000000007707700000077000770000000000000000000000000000000000000000000000000000000b0000000b0000000b00000000000000000000
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
