%token A
%token B

%start <unit> s0
%%

let s102 := s100; s47 | s76; s84
let s23 := s60; s47 | s73; s84
let s132 := s17; s47 | s81; s84
let s108 := s55; s100
let s18 := s116; s47 | s26; s84
let s103 := s84; s115 | s47; s81
let s65 := s84; s113 | s47; s50
let s128 := s107; s47 | s125; s84
let s14 := s84; s100 | s47; s107
let s118 := s47; s17 | s84; s57
let s2 := s47; s100 | s84; s40
let s28 := s63; s84 | s74; s47
let s22 := s102; s84 | s123; s47
let s123 := s84; s74
let s19 := s3; s47 | s13; s84
let s24 := s74; s47 | s81; s84
let s115 := s55; s55
let s90 := s92; s47 | s44; s84
let s48 := s84; s94 | s47; s96
let s109 := s17; s84 | s100; s47
let s92 := s84; s75 | s47; s108
let s66 := s38; s47 | s125; s84
let s83 := s66; s47 | s108; s84
let s31 := s121; s84 | s77; s47
let s29 := s47; s61 | s84; s111
let s45 := s47; s47 | s47; s84
let s59 := s47; s49 | s84; s43
let s37 := s47; s30 | s84; s95
let s36 := s107; s84 | s125; s47
let s82 := s74; s84 | s38; s47
let s61 := s84; s10 | s47; s110
let s79 := s47; s28 | s84; s109
let s33 := s101; s47 | s133; s84
let s12 := s45; s47 | s63; s84
let s91 := s122; s84 | s93; s47
let s122 := s65; s47 | s52; s84
let s21 := s57; s84 | s115; s47
let s8 := s42
let s67 := s102; s47 | s64; s84
let s39 := s113; s84 | s81; s47
let s41 := s84; s124 | s47; s10
let s50 := s47; s47 | s84; s84
let s17 := s47; s84 | s84; s84
let s120 := s98; s84 | s78; s47
let s113 := s55; s47 | s47; s84
let s20 := s84; s128 | s47; s104
let s7 := s84; s1 | s47; s20
let s51 := s84; s113 | s47; s81
let s56 := s84; s83 | s47; s69
let s131 := s84; s127 | s47; s97
let s0 := s8; s11
let s5 := s47; s63 | s84; s125
let s94 := s15; s84 | s127; s47
let s121 := s99; s47 | s27; s84
let s119 := s47; s115 | s84; s57
let s129 := s47; s80 | s84; s131
let s15 := s47; s100 | s84; s45
let s35 := s84; s50 | s47; s76
let s95 := s47; s115 | s84; s107
let s68 := s127; s84 | s51; s47
let s124 := s84; s107
let s75 := s50; s55
let s57 := s47; s84 | s84; s55
let s13 := s47; s33 | s84; s129
let s53 := s106; s47 | s59; s84
let s106 := s16; s84 | s118; s47
let s89 := s84; s125 | s47; s45
let s104 := s45; s84 | s76; s47
let s99 := s47; s56 | s84; s7
let s78 := s84; s74 | s47; s81
let s64 := s17; s47 | s115; s84
let s32 := s50; s84 | s40; s47
let s1 := s47; s24 | s84; s72
let s47 := A
let s80 := s114; s47 | s109; s84
let s88 := s47; s119 | s84; s132
let s105 := s47; s125 | s84; s100
let s6 := s68; s84 | s67; s47
let s110 := s76; s84 | s63; s47
let s38 := s84; s84 | s84; s47
let s49 := s47; s63 | s84; s76
let s26 := s55; s107
let s81 := s47; s84
let s74 := s84; s47
let s96 := s84; s89 | s47; s117
let s77 := s47; s86 | s84; s71
let s135 := s32; s84 | s2; s47
let s133 := s47; s15 | s84; s128
let s42 := s19; s84 | s62; s47
let s30 := s47; s100 | s84; s74
let s27 := s6; s47 | s91; s84
let s63 := s84; s55 | s47; s47
let s62 := s84; s87 | s47; s23
let s76 := s84; s84
let s4 := s84; s135 | s47; s54
let s60 := s41; s47 | s37; s84
let s100 := s47; s47 | s84; s47
let s85 := s47; s112 | s84; s18
let s116 := s125; s84 | s63; s47
let s134 := s57; s47 | s115; s84
let s34 := s52; s47 | s25; s84
let s40 := s47; s47
let s111 := s58; s84 | s126; s47
let s3 := s29; s47 | s130; s84
let s114 := s17; s84 | s107; s47
let s52 := s47; s45 | s84; s74
let s10 := s47; s100 | s84; s81
let s98 := s47; s76 | s84; s100
let s112 := s84; s82 | s47; s103
let s72 := s40; s47 | s45; s84
let s126 := s50; s84 | s113; s47
let s107 := s84; s47 | s47; s84
let s11 := s42; s31
let s55 := s84 | s47
let s54 := s12; s84 | s5; s47
let s130 := s34; s47 | s70; s84
let s84 := B
let s127 := s81; s47 | s17; s84
let s87 := s84; s53 | s47; s9
let s101 := s105; s84 | s14; s47
let s9 := s88; s84 | s120; s47
let s73 := s47; s79 | s84; s22
let s97 := s74; s84 | s50; s47
let s117 := s74; s47
let s70 := s47; s134 | s84; s46
let s58 := s47; s50 | s84; s115
let s125 := s47; s47 | s55; s84
let s46 := s47; s81 | s84; s17
let s86 := s84; s90 | s47; s85
let s25 := s38; s84 | s63; s47
let s69 := s39; s47 | s78; s84
let s43 := s47; s100 | s84; s125
let s93 := s84; s66 | s47; s35
let s44 := s47; s21 | s84; s36
let s16 := s57; s47 | s107; s84
let s71 := s48; s84 | s4; s47
