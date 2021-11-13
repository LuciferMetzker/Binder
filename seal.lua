--[[ � �����
���
������ ���
 ]]
local regex = require 'rex_pcre'
local inicfg = require 'inicfg'
local memory = require 'memory'
local vkeys = require 'vkeys'
local imgui = require 'imgui'
local encoding = require 'encoding'
local ev = require 'lib.samp.events'
local pie = require 'imgui_piemenu'
local rkeys = require 'rkeys'
imgui.ToggleButton = require('imgui_addons').ToggleButton
encoding.default = 'CP1251'
u8 = encoding.UTF8
---------- ��������������
local dlstatus = require('moonloader').download_status
update_state = false 
local script_vers = 1
local script_vers_text = "1.00"
local update_url = "https://raw.githubusercontent.com/LuciferMetzker/Binder/main/update.ini"
local update_path = getWorkingDirectory() .. "/update.ini"
local script_url = "https://github.com/TommyCorona/SampScripts/blob/main/���.luac?raw=true"
local script_path = thisScript().path 
-------------------------------------
local def_ini = {
	HotKey = {
		[1] = "0", [2] = "0", [3] = "0", [4] = "0", [5] = "0", [6] = "0", [7] = "0", [8] = "0", [9] = "0", [10] = "0", -- 1 �����, 2 - ���� ������, 3 ���� ��������, 4 ����������� �������, 5 �������� �������, 6 ���������� �� ���������, 7 ���������� ������������, 8 �������� ����, 9 �������� ������, 10 ���� �����
		[11] = "0", [12] = "0", [13] = "0", [14] = "0", [15] = "0", [16] = "0", [17] = "0", [18] = "0", [19] = "0", [20] = "0", -- 11 �������, 12 �������������, 13 - /lock, 14 - �� ������������, 15 �� ������������, 16 - �� ������������, 17 - �� ������������, 18 - �� ������������, 19 ����� ������ � members, 20 ������� ����� �.,
		[21] = "0", [22] = "0", [23] = "0", [24] = "0", [25] = "0", [26] = "0", [27] = "0", [28] = "0", [29] = "0", [30] = "0", -- 21 ���� ������� � �����, 22 ������� ������ ������, 23 ���� ��������, 24 - �� ������������, 25 ��, 26 ������� �����, 27-30 ���������
		[31] = "0", [32] = "0", [33] = "0", [34] = "0", [35] = "0", [36] = "0", [37] = "0", [38] = "0", [39] = "0", [40] = "0", -- 31-37 ���������, 38-40 - �� ������������
		[41] = "0", [42] = "0", [43] = "0", [44] = "0", [45] = "0", [46] = "0", [47] = "0", [48] = "0", [49] = "0", [50] = "0", -- 41 ������� ������� ��������, 42 ��������� �����, 43 ��������� �������, 44 - piemenu
		[51] = "0", [52] = "0" -- 45-51 - ����� ������
	},

	Commands = {
			[1] = "ob", [2] = "sopr", [3] = "zgruz", [4] = "rgruz", [5] = "bgruz", [6] = "kv", [7] = "e", [8] = "", [9] = "r", [10] = "pr",
			[11] = "hey", [12] = "gr", [13] = "hit", [14] = "cl", [15] = "rk", [16] = "memb", [17] = "chs", [18] = "mp", [19] = "z", [20] = "mem1",
			[21] = "sw", [22] = "st", [23] = "", [24] = "", [25] = "afk", [26] = "", [27] = "mcall", [28] = "showp", [29] = ""
	},

	UserBinder = {
			[1] = "", [2] = "", [3] = "", [4] = "", [5] = "", [6] = "", [7] = "", [8] = "", [9] = "", [10] = "",
			[11] = "",
	},

	UserCBinder = {
			[1] = "", [2] = "", [3] = "", [4] = "", [5] = "", [6] = "", [7] = "", [8] = "", [9] = "", [10] = "",
			[11] = "", [12] = "", [13] = "", [14] = ""
	},

	UserCBinderC = {
			[1] = "", [2] = "", [3] = "", [4] = "", [5] = "", [6] = "", [7] = "", [8] = "", [9] = "", [10] = "",
			[11] = "", [12] = "", [13] = "", [14] = ""
	},

	UserPieMenuNames = {[1] = "", [2] = "", [3] = "", [4] = "", [5] = "", [6] = "", [7] = "", [8] = "", [9] = "", [10] = ""},

	UserPieMenuActions = {[1] = "", [2] = "", [3] = "", [4] = "", [5] = "", [6] = "", [7] = "", [8] = "", [9] = "", [10] = ""},

	UserClist = {
			[1] = "������� �1", [2] = "������� �2", [3] = "������� �3", [4] = "������� �4",
			[5] = "������� �5", [6] = "������� �6", [7] = "������� �7", [8] = "������� �8", [9] = "������� �9",
			[10] = "������� �10", [11] = "������� �11", [12] = "������� �12", [13] = "������� �13", [14] = "������� �14",
			[15] = "������� �15", [16] = "������� �16", [17] = "������� �17", [18] = "������� �18", [19] = "������� �19",
			[20] = "������� �20", [21] = "������� ���λ", [22] = "������� �22", [23] = "������� �23", [24] = "������� �24",
			[25] = "������� �25", [26] = "������� �26", [27] = "������� �27", [28] = "������� �28", [29] = "������� �29",
			[30] = "������� �30", [31] = "������� �31", [32] = "������� �32", [33] = "������� �33"
	},

	rphr = {
		[1] = "", [2] = "", [3] = "", [4] = "", [5] = "", [6] = "", [7] = "", [8] = "", [9] = "", [10] = ""
	},

	bools = {
			[1] = 0, [2] = 0, [3] = 0, [4] = 0, [5] = 0, [6] = 0, [7] = 0, [8] = 0, [9] = 0, [10] = 0, -- 1 �� ������������, 2 - ��������� �������� �� ��, 3 - �������� ����������� � "������� �����", 4 - 10 ����� � ���� ������
			[11] = 0, [12] = 0, [13] = 0, [14] = 0, [15] = 0, [16] = 0, [17] = 0, [18] = 0, [19] = 0, [20] = 0, -- 11 - 14 - ����� � ���� �������, 15 - ������� �� �����, 16-17 �� �����������, 18 ����� ���� � ������, 19 - ����� ��� � ������, 20 - ����� ��� � ������
			[21] = 0, [22] = 0, [23] = 0, [24] = 0, [25] = 0, [26] = 0, [27] = 0, [28] = 0, [29] = 0, [30] = 0, -- 21 - ����� �4 � ������, 22 - ����� ����� � ������, 23 - ����� ������� � ������, 24 - ���������� ������ �� ������, 25 - ��������� overlay, 26 - ���. �����, 27 - ���� ��� � id, 28 - ���� � ���. ����������, 29 - ��, 30 - ���,
			[31] = 0, [32] = 0, [33] = 0, [34] = 0, [35] = 0, [36] = 0, [37] = 0, [38] = 0, [39] = 0, [40] = 0, -- 31 - � �������, 32 - �� � �����, 33 - ��� ����������, 34 - ���� � �����, 35 - ������������, 36 - �� �����, 37 - ���������, 38 - ����� ��������, 39 - ��������� ���� � �����, 40 - �������� ������� �� ���������� ���� � �����
			[41] = 0, [42] = 0, [43] = 0, [44] = 0, [45] = 0, [46] = 0, [47] = 0, [48] = 0, [49] = 0, [50] = 0, -- 41 - ��������� ������, 42 - ������������� ����� � ���������, 43 - �������� +500, 44 - ���������� � ���������� �����, 45 - ����, 46 - �������� � ������� ��, 47 - ���������� ������������, 48 ���������� ����, 49 ��������� �������� ������, 50 - ��������� �������� �����/������, 
			[51] = 0, [52] = 0, [53] = 0, [54] = 0, [55] = 0, [56] = 0, [57] = 0, [58] = 0, [59] = 0, [60] = 0, -- 51 - ��������� ����������� ���������, 52 - ���������� ������� �����, 53 - �������������� �������� �� ���, 54 - ������ ������ � ��������, 55 - /q ��������, 56 - ������������ ������� ���� � ����, 57 - �������������� ��������������, 58 - �������� ������� ����� ������, 59 - ������������
			[61] = 0, [62] = 0, [63] = 0, [64] = 0, [65] = 0, [66] = 0, [67] = 0, [68] = 0, [69] = 0, [70] = 0,
			[71] = 0, [72] = 0, [73] = 0, [74] = 0, [75] = 0, [76] = 0, [77] = 0, [78] = 0, [79] = 0, [80] = 0
	},

	Settings = {["pstatus"] = "0", ["PlayerRank"] = "", ["PlayerSecondName"] = "", ["UserSex"] = 0, ["PlayerFirstName"] = "", ["PlayerU"] = "���", ["tag"] = "[���]:", ["useclist"] = "21"},
}

local config_ini = inicfg.load(def_ini, "config_���") -- ��������� ���
local PlayerU = config_ini.Settings.PlayerU
local tag = config_ini.Settings.tag
local RP = config_ini.Settings.UserSex == 1 and "a" or ""
local useclist = config_ini.Settings.useclist

local guis = {["mainw"] = imgui.ImBool(false)}

local maintabs = {
		tab_main_binds = {
				["status"] = true, ["first"] = true, ["clistparams"] = false,
		},

		tab_user_binds = {
				["status"] = false, ["hk"] = true, ["cmd"] = false, ["pie"] = false
		},

		tab_commands = {
				["status"] = false, ["first"] = true,
		},

		tab_settings = {
				["status"] = false
		},

		auto_bp = {
				["status"] = imgui.ImBool(false)
		},
		
		rphr = {
			["status"] = imgui.ImBool(false)
		},

		user_keys = {
			["status"] = imgui.ImBool(false)
		},	
}

local clists = {
	[16777215] = 0,    [2852758528] = 1,  [2857893711] = 2,  [2857434774] = 3,  [2855182459] = 4, [2863589376] = 5, 
	[2854722334] = 6,  [2858002005] = 7,  [2868839942] = 8,  [2868810859] = 9,  [2868137984] = 10, 
	[2864613889] = 11, [2863857664] = 12, [2862896983] = 13, [2868880928] = 14, [2868784214] = 15, 
	[2868878774] = 16, [2853375487] = 17, [2853039615] = 18, [2853411820] = 19, [2855313575] = 20, 
	[2853260657] = 21, [2861962751] = 22, [2865042943] = 23, [2860620717] = 24, [2868895268] = 25, 
	[2868899466] = 26, [2868167680] = 27, [2868164608] = 28, [2864298240] = 29, [2863640495] = 30, 
	[2864232118] = 31, [2855811128] = 32, [2866272215] = 33,
}

local suspendkeys = 2 -- 0 ������ ��������, 1 -- ������ ��������� -- 2 ������ ���������� ��������

local guibuffers = {
	clistparams = {
			["clist1"] = imgui.ImBuffer(u8(config_ini.UserClist[1]), 256), ["clist2"] = imgui.ImBuffer(u8(config_ini.UserClist[2]), 256), ["clist3"] = imgui.ImBuffer(u8(config_ini.UserClist[3]), 256),
			["clist4"] = imgui.ImBuffer(u8(config_ini.UserClist[4]), 256), ["clist5"] = imgui.ImBuffer(u8(config_ini.UserClist[5]), 256), ["clist6"] = imgui.ImBuffer(u8(config_ini.UserClist[6]), 256),
			["clist7"] = imgui.ImBuffer(u8(config_ini.UserClist[7]), 256), ["clist8"] = imgui.ImBuffer(u8(config_ini.UserClist[8]), 256), ["clist9"] = imgui.ImBuffer(u8(config_ini.UserClist[9]), 256),
			["clist10"] = imgui.ImBuffer(u8(config_ini.UserClist[10]), 256), ["clist11"] = imgui.ImBuffer(u8(config_ini.UserClist[11]), 256), ["clist12"] = imgui.ImBuffer(u8(config_ini.UserClist[12]), 256),
			["clist13"] = imgui.ImBuffer(u8(config_ini.UserClist[13]), 256), ["clist14"] = imgui.ImBuffer(u8(config_ini.UserClist[14]), 256), ["clist15"] = imgui.ImBuffer(u8(config_ini.UserClist[15]), 256),
			["clist16"] = imgui.ImBuffer(u8(config_ini.UserClist[16]), 256), ["clist17"] = imgui.ImBuffer(u8(config_ini.UserClist[17]), 256), ["clist18"] = imgui.ImBuffer(u8(config_ini.UserClist[18]), 256),
			["clist19"] = imgui.ImBuffer(u8(config_ini.UserClist[19]), 256), ["clist20"] = imgui.ImBuffer(u8(config_ini.UserClist[20]), 256), ["clist21"] = imgui.ImBuffer(u8(config_ini.UserClist[21]), 256),
			["clist22"] = imgui.ImBuffer(u8(config_ini.UserClist[22]), 256), ["clist23"] = imgui.ImBuffer(u8(config_ini.UserClist[23]), 256), ["clist24"] = imgui.ImBuffer(u8(config_ini.UserClist[24]), 256),
			["clist25"] = imgui.ImBuffer(u8(config_ini.UserClist[25]), 256), ["clist26"] = imgui.ImBuffer(u8(config_ini.UserClist[26]), 256), ["clist27"] = imgui.ImBuffer(u8(config_ini.UserClist[27]), 256),
			["clist28"] = imgui.ImBuffer(u8(config_ini.UserClist[28]), 256), ["clist29"] = imgui.ImBuffer(u8(config_ini.UserClist[29]), 256), ["clist30"] = imgui.ImBuffer(u8(config_ini.UserClist[30]), 256),
			["clist31"] = imgui.ImBuffer(u8(config_ini.UserClist[31]), 256), ["clist32"] = imgui.ImBuffer(u8(config_ini.UserClist[32]), 256), ["clist33"] = imgui.ImBuffer(u8(config_ini.UserClist[33]), 256)
	},

	ubinds = {
			["bind1"] = imgui.ImBuffer(u8(config_ini.UserBinder[1]), 512), ["bind2"] = imgui.ImBuffer(u8(config_ini.UserBinder[2]), 512), ["bind3"] = imgui.ImBuffer(u8(config_ini.UserBinder[3]), 512),
			["bind4"] = imgui.ImBuffer(u8(config_ini.UserBinder[4]), 512), ["bind5"] = imgui.ImBuffer(u8(config_ini.UserBinder[5]), 512), ["bind6"] = imgui.ImBuffer(u8(config_ini.UserBinder[6]), 512),
			["bind7"] = imgui.ImBuffer(u8(config_ini.UserBinder[7]), 512), ["bind8"] = imgui.ImBuffer(u8(config_ini.UserBinder[8]), 512), ["bind9"] = imgui.ImBuffer(u8(config_ini.UserBinder[9]), 512),
			["bind10"] = imgui.ImBuffer(u8(config_ini.UserBinder[10]), 512), ["bind11"] = imgui.ImBuffer(u8(config_ini.UserBinder[11]), 512)
	},

	ucbinds = {
			["bind1"] = imgui.ImBuffer(u8(config_ini.UserCBinder[1]), 512), ["bind2"] = imgui.ImBuffer(u8(config_ini.UserCBinder[2]), 512), ["bind3"] = imgui.ImBuffer(u8(config_ini.UserCBinder[3]), 512),
			["bind4"] = imgui.ImBuffer(u8(config_ini.UserCBinder[4]), 512), ["bind5"] = imgui.ImBuffer(u8(config_ini.UserCBinder[5]), 512), ["bind6"] = imgui.ImBuffer(u8(config_ini.UserCBinder[6]), 512),
			["bind7"] = imgui.ImBuffer(u8(config_ini.UserCBinder[7]), 512), ["bind8"] = imgui.ImBuffer(u8(config_ini.UserCBinder[8]), 512), ["bind9"] = imgui.ImBuffer(u8(config_ini.UserCBinder[9]), 512),
			["bind10"] = imgui.ImBuffer(u8(config_ini.UserCBinder[10]), 512),["bind11"] = imgui.ImBuffer(u8(config_ini.UserCBinder[11]), 512), ["bind12"] = imgui.ImBuffer(u8(config_ini.UserCBinder[12]), 512),
			["bind13"] = imgui.ImBuffer(u8(config_ini.UserCBinder[13]), 512), ["bind14"] = imgui.ImBuffer(u8(config_ini.UserCBinder[14]), 512)
	},

	ucbindsc = {
			["bind1"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[1]), 512), ["bind2"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[2]), 512), ["bind3"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[3]), 512),
			["bind4"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[4]), 512), ["bind5"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[5]), 512), ["bind6"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[6]), 512),
			["bind7"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[7]), 512), ["bind8"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[8]), 512), ["bind9"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[9]), 512),
			["bind10"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[10]), 512), ["bind11"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[11]), 512), ["bind12"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[12]), 512),
			["bind13"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[13]), 512), ["bind14"] = imgui.ImBuffer(u8(config_ini.UserCBinderC[14]), 512)
	},

	settings = {
			["fname"] = imgui.ImBuffer(u8(config_ini.Settings.PlayerFirstName), 256), ["sname"] = imgui.ImBuffer(u8(config_ini.Settings.PlayerSecondName), 256), ["rank"] = imgui.ImBuffer(u8(config_ini.Settings.PlayerRank), 256),
	},

	rphr = {
		["bind1"] = imgui.ImBuffer(u8(config_ini.rphr[1]), 256), ["bind2"] = imgui.ImBuffer(u8(config_ini.rphr[2]), 256), ["bind3"] = imgui.ImBuffer(u8(config_ini.rphr[3]), 256),
		["bind4"] = imgui.ImBuffer(u8(config_ini.rphr[4]), 256), ["bind5"] = imgui.ImBuffer(u8(config_ini.rphr[5]), 256), ["bind6"] = imgui.ImBuffer(u8(config_ini.rphr[6]), 256),
		["bind7"] = imgui.ImBuffer(u8(config_ini.rphr[7]), 256), ["bind8"] = imgui.ImBuffer(u8(config_ini.rphr[8]), 256), ["bind9"] = imgui.ImBuffer(u8(config_ini.rphr[9]), 256),
		["bind10"] = imgui.ImBuffer(u8(config_ini.rphr[10]), 256)
	},

	commands = {
			["command1"] = imgui.ImBuffer(u8(config_ini.Commands[1]), 256), ["command2"] = imgui.ImBuffer(u8(config_ini.Commands[2]), 256), ["command3"] = imgui.ImBuffer(u8(config_ini.Commands[3]), 256),
			["command4"] = imgui.ImBuffer(u8(config_ini.Commands[4]), 256), ["command5"] = imgui.ImBuffer(u8(config_ini.Commands[5]), 256), ["command6"] = imgui.ImBuffer(u8(config_ini.Commands[6]), 256),
			["command7"] = imgui.ImBuffer(u8(config_ini.Commands[7]), 256), ["command8"] = imgui.ImBuffer(u8(config_ini.Commands[8]), 256), ["command9"] = imgui.ImBuffer(u8(config_ini.Commands[9]), 256),
			["command10"] = imgui.ImBuffer(u8(config_ini.Commands[10]), 256), ["command11"] = imgui.ImBuffer(u8(config_ini.Commands[11]), 256), ["command12"] = imgui.ImBuffer(u8(config_ini.Commands[12]), 256),
			["command13"] = imgui.ImBuffer(u8(config_ini.Commands[13]), 256), ["command14"] = imgui.ImBuffer(u8(config_ini.Commands[14]), 256), ["command15"] = imgui.ImBuffer(u8(config_ini.Commands[15]), 256),
			["command16"] = imgui.ImBuffer(u8(config_ini.Commands[16]), 256), ["command17"] = imgui.ImBuffer(u8(config_ini.Commands[17]), 256), ["command18"] = imgui.ImBuffer(u8(config_ini.Commands[18]), 256),
			["command19"] = imgui.ImBuffer(u8(config_ini.Commands[19]), 256), ["command20"] = imgui.ImBuffer(u8(config_ini.Commands[20]), 256), ["command21"] = imgui.ImBuffer(u8(config_ini.Commands[21]), 256),
			["command22"] = imgui.ImBuffer(u8(config_ini.Commands[22]), 256), ["command23"] = imgui.ImBuffer(u8(config_ini.Commands[23]), 256), ["command24"] = imgui.ImBuffer(u8(config_ini.Commands[24]), 256),
			["command25"] = imgui.ImBuffer(u8(config_ini.Commands[25]), 256), ["command26"] = imgui.ImBuffer(u8(config_ini.Commands[26]), 256), ["command27"] = imgui.ImBuffer(u8(config_ini.Commands[27]), 256),
			["command28"] = imgui.ImBuffer(u8(config_ini.Commands[28]), 256), ["command29"] = imgui.ImBuffer(u8(config_ini.Commands[29]), 256)
	},

	UserPieMenu = {
			names = {
					["name1"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[1]), 256), ["name2"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[2]), 256), ["name3"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[3]), 256),
					["name4"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[4]), 256), ["name5"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[5]), 256), ["name6"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[6]), 256),
					["name7"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[7]), 256), ["name8"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[8]), 256), ["name9"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[9]), 256),
					["name10"] = imgui.ImBuffer(u8(config_ini.UserPieMenuNames[10]), 256)
			},

			actions = {
					["action1"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[1]), 256), ["action2"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[2]), 256), ["action3"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[3]), 256),
					["action4"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[4]), 256), ["action5"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[5]), 256), ["action6"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[6]), 256),
					["action7"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[7]), 256), ["action8"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[8]), 256), ["action9"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[9]), 256),
					["action10"] = imgui.ImBuffer(u8(config_ini.UserPieMenuActions[10]), 256)
			}
	},
}

local togglebools = {
	tab_main_binds = {
			first = {
			
			},

			clistparams = {
					[1] = config_ini.bools[2] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
					[2] = config_ini.bools[3] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
			}
	},

	tab_user_binds = {
			hk = {
				[1] = config_ini.bools[4] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[2] = config_ini.bools[5] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[3] = config_ini.bools[6] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[4] = config_ini.bools[7] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[5] = config_ini.bools[8] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[6] = config_ini.bools[9] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[7] = config_ini.bools[10] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[8] = config_ini.bools[11] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[9] = config_ini.bools[12] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[10] = config_ini.bools[13] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
				[11] = config_ini.bools[14] == 1 and imgui.ImBool(true) or imgui.ImBool(false)
			},

			cmd = {

			}
	},

	tab_commands = {

	},

	tab_settings = {
		[1] = config_ini.Settings.UserSex == 1 and imgui.ImBool(true) or imgui.ImBool(false),
	},

	user_keys = {

	},

	rphr = {

	},

	auto_bp = {
			[1] = config_ini.bools[18] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
			[2] = config_ini.bools[19] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
			[3] = config_ini.bools[20] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
			[4] = config_ini.bools[21] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
			[5] = config_ini.bools[22] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
			[6] = config_ini.bools[23] == 1 and imgui.ImBool(true) or imgui.ImBool(false),
			[7] = config_ini.bools[24] == 1 and imgui.ImBool(true) or imgui.ImBool(false)
	},
}

local target = {["id"] = 1000, ["time"] = 0, ["suct"] = false}
local sx = 0
local sy = 0
local ped

local piearr = {
	action = 0,
	pie_mode = imgui.ImBool(false),
	pie_keyid = 0,
	pie_elements = {},
	
	["weap"] = {
		action = 0,
		pie_mode = imgui.ImBool(false),
		pie_keyid = 0,
		pie_elements = {},
	}
}

-- ���������� ��
local isarmtaken = false
local isdeagletaken = false
local isshotguntaken = false
local issmgtaken = false
local ism4a1taken = false
local isrifletaken = false
local ispartaken = false
local whatwastaken = {}
local AutoDeagle = config_ini.bools[18] == 1 and true or false
local AutoShotgun = config_ini.bools[19] == 1 and true or false
local AutoSMG = config_ini.bools[20] == 1 and true or false
local AutoM4A1 = config_ini.bools[21] == 1 and true or false
local AutoRifle = config_ini.bools[22] == 1 and true or false
local AutoPar = config_ini.bools[23] == 1 and true or false
local AutoOt = config_ini.bools[24] == 1 and true or false
local partimer = 0
local istakesomeone = false -- ����� ���� �� ���� ���-�� �����

-- �������
local isDialogActiveNow = false -- ����� ������� �� � ������ ������ ������
local IsAppear = false -- ����� ������ �� ������ �������
local DialogTitle = ""
local DialogText = ""
local DialogButton1 = ""
local DialogButton2 = ""
local isCorrectClose = false -- ����� ��������� �� ��� ������ ������
local SelectedButton = 0 -- ����� ������ (1 ��� 2) ���� ������
local returnWalue = nil
-- List
local show_dialog_list = imgui.ImBool(false)
local ChoosenRow = -1
local SelectedRow = 0
local StrCol = 0
-- Input
local show_dialog_input = imgui.ImBool(false)
local IsFocused = false -- ����� ��� �� ��������� ����� �� �����
local moonimgui_text_buffer = imgui.ImBuffer(256)
-- msgbox
local show_dialog_msgbox = imgui.ImBool(false)

local lastTargetID = -1
local needtosave = false
local needtoreset = false
local delay = 1000 -- �������� ����� ����������� � ��
local style = imgui.GetStyle()
local colors = style.Colors
local clr = imgui.Col
local ImVec4 = imgui.ImVec4
local imfonts = {mainfont = nil, exFontl = nil, exFont = nil, exFontsquad = nil, font500 = nil, fontmoney = nil, exFontsquadrender = nil, onlinebig = nil, onlinesmal = nil}
local ranksnames = {[1] = "�������", [2] = "��������", [3] = "��.�������", [4] = "�������", [5] = "��.�������", [6] = "��������", [7] = "���������", [8] = "��.���������", [9] = "���������", [10] = "��.���������", [11] = "�������", [12] = "�����", [13] = "������������", [14] = "���������", [15] = "�������"}
local preparecomplete = false
local lastrand = 0

local duel = {
	["mode"] = false, 

	["en"] = {
		["id"] = -1, 
		["hp"] = 0, 
		["arm"] = 0
	}, 
	
	["fightmode"] = false, 
	
	["my"] = {
		["hp"] = 0, 
		["arm"] = 0
	}
}

local cIDs = {
	[1] = "����� 0", [2] = "����� 0", [3] = "����� 0",

	[4] = "����� 1", [5] = "����� 1", [6] = "����� 1",

	[7] = "����� 2", [8] = "����� 2", [9] = "����� 2",

	[10] = "����� 3", [11] = "����� 3", [12] = "����� 3",

	[13] = "����� 4", [14] = "����� 4", [15] = "����� 4",

	[16] = "���� ��", [17] = "���� ��", [18] = "���� ��", [19] = "���� ��", [20] = "���� ��",
	[21] = "���� ��",

	[22] = "������ ��", [23] = "������ ��", [24] = "������ ��", [25] = "������ ��", [26] = "������ ��",

	[27] = "������ ��", [28] = "������ ��", [29] = "������ ��", [30] = "������ ��", [31] = "������ ��",
	[32] = "������ ��", [33] = "������ ��", [34] = "������ ��",

	[35] = "������ ��", [36] = "������ ��", [37] = "������ ��",

	[38] = "������ ��", [39] = "������ ��",

	[40] = "������ �������", [41] = "������ �������",

	[42] = "�-10",

	[43] = "������ �-9",

	[44] = "������ ��", [45] = "������ ��", [46] = "������ ��", [47] = "������ ��", [48] = "������ ��",
	[49] = "������ ��", [50] = "������ ��",

	[51] = "������ ��", [52] = "������ ��", [53] = "������ ��", [54] = "������ ��", [55] = "������ ��",
	[56] = "������ ��", [57] = "������ ��", [58] = "������ ��", [59] = "������ ��",

	[60] = "������ ��", [61] = "������ ��", [62] = "������ ��", [63] = "������ ��", [64] = "������ ��",
	[65] = "������ ��", [66] = "������ ��", [67] = "������ ��", [68] = "������ ��", [69] = "������ ��",
	[70] = "������ ��", [71] = "������ ��", [72] = "������ ��", [73] = "������ ��", [74] = "������ ��",
	[75] = "������ ��",

	[76] = "������� ������", [77] = "������� ������", [78] = "������� ������", [79] = "������� ������", [80] = "������� ������",
	[81] = "������� ������", [82] = "������� ������", [83] = "������� ������", [84] = "������� ������", [85] = "������� ������",

	[86] = "������ ��",

	[87] = "������ ��",

	[88] = "������ ��", [89] = "������ ��", [90] = "������ ��", [91] = "������ ��", [92] = "������ ��",

	[93] = "������ �-9",

	[94] = "���� ��", [95] = "���� ��", [96] = "���� ��", [97] = "���� ��", [98] = "���� ��",
	[99] = "���� ��", [100] = "���� ��", [101] = "���� ��", [102] = "���� ��", [103] = "���� ��",
	[104] = "���� ��", [105] = "���� ��",

	[106] = "�� ��", [107] = "�� ��", [108] = "�� ��", [109] = "�� ��", [110] = "�� ��",

	[111] = "���������", [112] = "���������", [113] = "���������", [114] = "���������", [115] = "���������",

	[116] = "������� ��", [117] = "������� ��", [118] = "������� ��", [119] = "������� ��", [120] = "������� ��",
	[121] = "������� ��", [122] = "������� ��", [123] = "������� ��", [124] = "������� ��", [125] = "������� ��",
	[126] = "������� ��", [127] = "������� ��", [128] = "������� ��", [129] = "������� ��", [130] = "������� ��",
	[131] = "������� ��", [132] = "������� ��", [133] = "������� ��", [134] = "������� ��", [135] = "������� ��",
	[136] = "������� ��", [137] = "������� ��", [138] = "������� ��", [139] = "������� ��", [140] = "������� ��",
	[141] = "������� ��", [142] = "������� ��", [143] = "������� ��", [144] = "������� ��", [145] = "������� ��",
	[146] = "������� ��", [147] = "������� ��", [148] = "������� ��", [149] = "������� ��", [150] = "������� ��",

	[151] = "������� ��", [152] = "������� ��", [153] = "������� ��", [154] = "������� ��", [155] = "������� ��",
	[156] = "������� ��", [157] = "������� ��", [158] = "������� ��", [159] = "������� ��", [160] = "������� ��",
	[161] = "������� ��", [162] = "������� ��", [163] = "������� ��", [164] = "������� ��", [165] = "������� ��",
	[166] = "������� ��", [167] = "������� ��", [168] = "������� ��", [169] = "������� ��", [170] = "������� ��",
	[171] = "������� ��", [172] = "������� ��", [173] = "������� ��", [174] = "������� ��", [175] = "������� ��",
	[176] = "������� ��", [177] = "������� ��", [178] = "������� ��", [179] = "������� ��", [180] = "������� ��",
	[181] = "������� ��", [182] = "������� ��", [183] = "������� ��", [184] = "������� ��", [185] = "������� ��",

	[186] = "������� ��", [187] = "������� ��", [188] = "������� ��", [189] = "������� ��", [190] = "������� ��",
	[191] = "������� ��", [192] = "������� ��", [193] = "������� ��", [194] = "������� ��", [195] = "������� ��",
	[196] = "������� ��", [197] = "������� ��", [198] = "������� ��", [199] = "������� ��", [200] = "������� ��",
	[201] = "������� ��", [202] = "������� ��", [203] = "������� ��", [204] = "������� ��", [205] = "������� ��",
	[206] = "������� ��", [207] = "������� ��", [208] = "������� ��", [209] = "������� ��", [210] = "������� ��",
	[211] = "������� ��", [212] = "������� ��", [213] = "������� ��", [214] = "������� ��", [215] = "������� ��",
	[216] = "������� ��", [217] = "������� ��", [218] = "������� ��", [219] = "������� ��", [220] = "������� ��",
	[221] = "������� ��", [222] = "������� ��",

	[223] = "FBI", [224] = "FBI", [225] = "FBI", [226] = "FBI", [227] = "FBI",
	[228] = "FBI", [229] = "FBI", [230] = "FBI", [231] = "FBI", [232] = "FBI",
	[233] = "FBI", [234] = "FBI", [235] = "FBI", [236] = "FBI", [237] = "FBI",
	[238] = "FBI", [239] = "FBI", [240] = "FBI", [241] = "FBI", [242] = "FBI",
	[243] = "FBI", [244] = "FBI", [245] = "FBI", [246] = "FBI",

	[247] = "����� �� (������)", [248] = "����� �� (������)", [249] = "����� �� (������)", [250] = "����� �� (������)", [251] = "����� �� (������)",

	[252] = "����� ��", [253] = "����� ��", [254] = "����� ��", [255] = "����� ��", [256] = "����� ��",
	[257] = "����� ��", [258] = "����� ��", [259] = "����� ��", [260] = "����� ��", [261] = "����� ��",
	[262] = "�.�.�.�.", [263] = "�.�.�.�.", [264] = "����� ��", [265] = "����� ��", [266] = "����� ��",
	[267] = "����� ��", [268] = "����� ��", [269] = "����� ��",

	[270] = "����� ��", [271] = "����� ��", [272] = "����� ��", [273] = "����� ��",

	[274] = "����� ��", [275] = "����� ��", [276] = "����� ��",

	[277] = "�.�.�.�.", [278] = "�.�.�.�.", [279] = "�.�.�.�.", [280] = "����� ��", [281] = "����� ��",
	[282] = "����� ��",

	[283] = "����� ��", [284] = "����� ��", [285] = "����� ��", [286] = "����� ��", [287] = "����� ��",
	[288] = "����� ��", [289] = "����� ��", [290] = "����� ��", [291] = "����� ��", [292] = "����� ��",
	[293] = "����� ��", [294] = "����� ��", [295] = "����� ��",

	[296] = "������� �����������", [297] = "������� �����������", [298] = "������� �����������", [299] = "������� �����������", [300] = "������� �����������",
	[301] = "������� �����������", [302] = "������� �����������", [303] = "������� �����������", [304] = "������� �����������", [305] = "������� �����������",
	[306] = "������� �����������", [307] = "������� �����������", [308] = "������� �����������", [309] = "������� �����������", [310] = "������� �����������",
	[311] = "������� �����������", [312] = "������� �����������", [313] = "������� �����������",

	[314] = "���� ��", [315] = "���� ��", [316] = "���� ��", [317] = "���� ��", [318] = "���� ��",
	[319] = "���� ��", [320] = "���� ��", [321] = "���� ��", [322] = "���� ��", [323] = "���� ��",

	[324] = "����� ��", [325] = "����� ��", [326] = "����� ��", [327] = "����� ��", [328] = "����� ��",
	[329] = "����� ��", [330] = "����� ��", [331] = "����� ��", [332] = "����� ��", [333] = "����� ��",
	[334] = "����� ��", [335] = "����� ��", [336] = "����� ��", [337] = "����� ��", [338] = "����� ��",
	[339] = "����� ��", [340] = "����� ��", [341] = "����� ��", [342] = "����� ��", [343] = "����� ��",
	[344] = "����� ��", [345] = "����� ��", [346] = "����� ��", [347] = "����� ��", [348] = "����� ��",
	[349] = "����� ��", [350] = "����� ��", [351] = "����� ��", [352] = "����� ��", [353] = "����� ��",
	[354] = "����� ��", [355] = "����� ��", [356] = "����� ��", [357] = "����� ��", [358] = "����� ��",
	[359] = "����� ��", [360] = "����� ��", [361] = "����� ��", [362] = "����� ��", [363] = "����� ��",
	[364] = "����� ��", [365] = "����� ��", [366] = "����� ��", [367] = "����� ��", [368] = "����� ��",
	[369] = "����� ��",

	[370] = "���� ��",

	[371] = "������ ��", [372] = "������ ��", [373] = "������ ��", [374] = "������ ��", [375] = "������ ��",
	[376] = "������ ��", [377] = "������ ��", [378] = "������ ��", [379] = "������ ��", [380] = "������ ��",
	[381] = "������ ��", [382] = "������ ��", [383] = "������ ��", [384] = "������ ��", [385] = "������ ��",
	[386] = "������ ��", [387] = "������ ��", [388] = "������ ��",

	[389] = "������ �����", [390] = "������ �����", [391] = "������ �����", [392] = "������ �����",

	[393] = "������ �-18", [394] = "������ �-18", [395] = "������ �-18", [396] = "������ �-18",

	[397] = "������ ��", [398] = "������ ��", [399] = "������ ��", [400] = "������ ��", [401] = "������ ��",
	[402] = "������ ��", [403] = "������ ��", [404] = "������ ��", [405] = "������ ��", [406] = "������ ��",
	[407] = "������ ��",

	[408] = "������ ��", [409] = "������ ��", [410] = "������ ��", [411] = "������ ��", [412] = "������ ��",
	[413] = "������ ��", [414] = "������ ��", [415] = "������ ��", [416] = "������ ��", [417] = "������ ��",
	[418] = "������ ��", [419] = "������ ��", [420] = "������ ��", [421] = "������ ��",

	[422] = "������ ��", [423] = "������ ��", [424] = "������ ��", [425] = "������ ��", [426] = "������ ��",

	[427] = "������ �-7", [428] = "������ �-7", [429] = "������ �-7", [430] = "������ �-7",

	[431] = "�����", [432] = "�����", [433] = "�����", [434] = "�����", [435] = "�����",
	[436] = "�����", [437] = "�����", [438] = "�����", [439] = "�����", [440] = "�����",
	[441] = "�����", [442] = "�����", [443] = "�����", [444] = "�����", [445] = "�����",

	[446] = "���������", [447] = "���������", [448] = "���������", [449] = "���������", [450] = "���������",
	[451] = "���������", [452] = "���������", [453] = "���������", [454] = "���������", [455] = "���������",
	[456] = "���������", [457] = "���������", [458] = "���������", [459] = "���������", [460] = "���������",
	[461] = "���������", [462] = "���������",

	[463] = "������� ��", [464] = "������� ��", [465] = "������� ��", [466] = "������� ��", [467] = "������� ��",
	[468] = "������� ��", [469] = "������� ��", [470] = "������� ��",

	[471] = "������� ��", [472] = "������� ��", [473] = "������� ��", [474] = "������� ��", [475] = "������� ��",
	[476] = "������� ��", [477] = "������� ��", [478] = "������� ��",

	[479] = "������� ��", [480] = "������� ��", [481] = "������� ��", [482] = "������� ��", [483] = "������� ��",
	[484] = "������� ��", [485] = "������� ��", [486] = "������� ��",

	[487] = "LCn", [488] = "LCn", [489] = "LCn", [490] = "LCn", [491] = "LCn",
	[492] = "LCn", [493] = "LCn", [494] = "LCn", [495] = "LCn", [496] = "LCn",
	[497] = "LCn", [498] = "LCn", [499] = "LCn", [500] = "LCn", [501] = "LCn",
	[502] = "LCn",

	[503] = "Yakuza", [504] = "Yakuza", [505] = "Yakuza", [506] = "Yakuza", [507] = "Yakuza",
	[508] = "Yakuza", [509] = "Yakuza", [510] = "Yakuza", [511] = "Yakuza", [512] = "Yakuza",
	[513] = "Yakuza", [514] = "Yakuza", [515] = "Yakuza", [516] = "Yakuza", [517] = "Yakuza",
	[518] = "Yakuza",

	[519] = "RM", [520] = "RM", [521] = "RM", [522] = "RM", [523] = "RM",
	[524] = "RM", [525] = "RM", [526] = "RM", [527] = "RM", [528] = "RM",
	[529] = "RM", [530] = "RM", [531] = "RM", [532] = "RM", [533] = "RM",
	[534] = "RM",

	[535] = "Rifa", [536] = "Rifa", [537] = "Rifa", [538] = "Rifa", [539] = "Rifa",
	[540] = "Rifa", [541] = "Rifa", [542] = "Rifa",

	[543] = "Groove", [544] = "Groove", [545] = "Groove", [546] = "Groove", [547] = "Groove",
	[548] = "Groove", [549] = "Groove", [550] = "Groove",

	[551] = "Ballas", [552] = "Ballas", [553] = "Ballas", [554] = "Ballas", [555] = "Ballas",
	[556] = "Ballas", [557] = "Ballas", [558] = "Ballas",

	[559] = "Vagos", [560] = "Vagos", [561] = "Vagos", [562] = "Vagos", [563] = "Vagos",
	[564] = "Vagos", [565] = "Vagos", [566] = "Vagos",

	[567] = "Aztec", [568] = "Aztec", [569] = "Aztec", [570] = "Aztec", [571] = "Aztec",
	[572] = "Aztec", [573] = "Aztec", [574] = "Aztec",

	[575] = "Hell Angels MC", [576] = "Hell Angels MC", [577] = "Hell Angels MC", [578] = "Hell Angels MC", [579] = "Hell Angels MC",
	[580] = "Hell Angels MC", [581] = "Hell Angels MC", [582] = "Hell Angels MC", [583] = "Hell Angels MC", [584] = "Hell Angels MC",
	[585] = "Hell Angels MC", [586] = "Hell Angels MC",

	[587] = "Mongols MC", [588] = "Mongols MC", [589] = "Mongols MC", [590] = "Mongols MC", [591] = "Mongols MC",
	[592] = "Mongols MC", [593] = "Mongols MC", [594] = "Mongols MC", [595] = "Mongols MC", [596] = "Mongols MC",
	[597] = "Mongols MC", [598] = "Mongols MC",

	[599] = "Pagans MC", [600] = "Pagans MC", [601] = "Pagans MC", [602] = "Pagans MC", [603] = "Pagans MC",
	[604] = "Pagans MC", [605] = "Pagans MC", [606] = "Pagans MC", [607] = "Pagans MC", [608] = "Pagans MC",
	[609] = "Pagans MC", [610] = "Pagans MC",

	[611] = "Outlaws MC", [612] = "Outlaws MC", [613] = "Outlaws MC", [614] = "Outlaws MC", [615] = "Outlaws MC",
	[616] = "Outlaws MC", [617] = "Outlaws MC", [618] = "Outlaws MC", [619] = "Outlaws MC", [620] = "Outlaws MC",
	[621] = "Outlaws MC", [622] = "Outlaws MC",

	[623] = "Sons of Silence MC", [624] = "Sons of Silence MC", [625] = "Sons of Silence MC", [626] = "Sons of Silence MC", [627] = "Sons of Silence MC",
	[628] = "Sons of Silence MC", [629] = "Sons of Silence MC", [630] = "Sons of Silence MC", [631] = "Sons of Silence MC", [632] = "Sons of Silence MC",
	[633] = "Sons of Silence MC", [634] = "Sons of Silence MC",

	[635] = "Warlocks MC", [636] = "Warlocks MC", [637] = "Warlocks MC", [638] = "Warlocks MC", [639] = "Warlocks MC",
	[640] = "Warlocks MC", [641] = "Warlocks MC", [642] = "Warlocks MC", [643] = "Warlocks MC", [644] = "Warlocks MC",
	[645] = "Warlocks MC", [646] = "Warlocks MC",

	[647] = "Highwaymen MC", [648] = "Highwaymen MC", [649] = "Highwaymen MC", [650] = "Highwaymen MC", [651] = "Highwaymen MC",
	[652] = "Highwaymen MC", [653] = "Highwaymen MC", [654] = "Highwaymen MC", [655] = "Highwaymen MC", [656] = "Highwaymen MC",
	[657] = "Highwaymen MC", [658] = "Highwaymen MC",

	[659] = "Bandidos MC", [660] = "Bandidos MC", [661] = "Bandidos MC", [662] = "Bandidos MC", [663] = "Bandidos MC",
	[664] = "Bandidos MC", [665] = "Bandidos MC", [666] = "Bandidos MC", [667] = "Bandidos MC", [668] = "Bandidos MC",
	[669] = "Bandidos MC", [670] = "Bandidos MC",

	[671] = "Free Souls MC", [672] = "Free Souls MC", [673] = "Free Souls MC", [674] = "Free Souls MC", [675] = "Free Souls MC",
	[676] = "Free Souls MC", [677] = "Free Souls MC", [678] = "Free Souls MC", [679] = "Free Souls MC", [680] = "Free Souls MC",
	[681] = "Free Souls MC", [682] = "Free Souls MC",

	[683] = "Vagos MC", [684] = "Vagos MC", [685] = "Vagos MC", [686] = "Vagos MC", [687] = "Vagos MC",
	[688] = "Vagos MC", [689] = "Vagos MC", [690] = "Vagos MC", [691] = "Vagos MC", [692] = "Vagos MC",
	[693] = "Vagos MC", [694] = "Vagos MC",

	[695] = "�� ��", [696] = "�� ��", [697] = "�� ��", [698] = "�� ��", [699] = "�� ��",
	[700] = "�� ��",

	[701] = "�-14", [702] = "�-14",

	[703] = "�� ��", [704] = "�� ��", [705] = "�� ��", [706] = "�� ��", [707] = "�� ��",
	[708] = "�� ��", [709] = "�� ��", [710] = "�� ��", [711] = "�� ��",

	[712] = "�� ��", [713] = "�� ��", [714] = "�� ��", [715] = "�� ��", [716] = "�� ��",
	[717] = "�� ��", [718] = "�� ��", [719] = "�� ��", [720] = "�� ��", [721] = "�� ��",
	[722] = "�� ��", [723] = "�� ��", [724] = "�� ��",

	[725] = "�� ��", [726] = "�� ��", [727] = "�� ��", [728] = "�� ��", [729] = "�� ��",
	[730] = "�� ��", [731] = "�� ��",

	[732] = "Jefferson", [733] = "Jefferson", [734] = "Jefferson", [735] = "Jefferson", [736] = "Jefferson",
	[737] = "Jefferson", [738] = "Jefferson", [739] = "Jefferson", [740] = "Jefferson", [741] = "Jefferson",
	[742] = "Jefferson", [743] = "Jefferson", [744] = "Jefferson", [745] = "Jefferson",

	[746] = "���� ��", [747] = "���� ��", [748] = "���� ��", [749] = "���� ��", [750] = "���� ��",
	[751] = "���� ��", [752] = "���� ��", [753] = "���� ��", [754] = "���� ��",

	[755] = "�-18", [756] = "�-18", [757] = "�-18", [758] = "�-18",

	[759] = "������� �����", [760] = "������� �����", [761] = "������� �����", [762] = "������� �����", [763] = "������� �����",
	[764] = "������� �����", [765] = "������� �����", [766] = "������� �����", [767] = "������� �����", [768] = "������� �����",
	[769] = "������� �����", [770] = "������� �����", [771] = "������� �����", [772] = "������� �����", [773] = "������� �����",
	[774] = "������� �����", [775] = "������� �����", [776] = "������� �����", [777] = "������� �����", [778] = "������� �����",
	[779] = "������� �����",

	[780] = "���� ��", [781] = "���� ��", [782] = "���� ��", [783] = "���� ��", [784] = "���� ��",
	[785] = "���� ��", [786] = "���� ��", [787] = "���� ��",

	[788] = "������� �����", [789] = "������� �����", [790] = "������� �����", [791] = "������� �����", [792] = "������� �����",
	[793] = "������� �����", [794] = "������� �����",

	[795] = "�� ��", [796] = "�� ��", [797] = "�� ��", [798] = "�� ��", [799] = "�� ��",
	[800] = "�� ��", [801] = "�� ��", [802] = "�� ��", [803] = "�� ��",

	[804] = "�� ��", [805] = "�� ��", [806] = "�� ��", [807] = "�� ��", [808] = "�� ��",
	[809] = "�� ��", [810] = "�� ��", [811] = "�� ��", [812] = "�� ��",

	[813] = "�� ��", [814] = "�� ��", [815] = "�� ��", [816] = "�� ��", [817] = "�� ��",
	[818] = "�� ��", [819] = "�� ��", [820] = "�� ��",

	[821] = "�� �� (��� ������)", [822] = "�� �� (��� ������)", [823] = "�� �� (��� ������)", [824] = "�� �� (��� ������)", [825] = "�� �� (��� ������)",
	[826] = "�� �� (��� ������)", [827] = "�� �� (��� ������)", [828] = "�� �� (��� ������)", [829] = "�� �� (��� ������)", [830] = "�� �� (��� ������)",
	[831] = "�� �� (��� ������)", [832] = "�� �� (��� ������)", [833] = "�� �� (��� ������)", [834] = "�� �� (��� ������)", [835] = "�� �� (��� ������)",
	[836] = "�� �� (��� ������)", [837] = "�� �� (��� ������)", [838] = "�� �� (��� ������)", [839] = "�� �� (��� ������)", [840] = "�� �� (��� ������)",
	[841] = "�� �� (��� ������)", [842] = "�� �� (��� ������)",

	[843] = "���������", [844] = "���������", [845] = "���������", [846] = "���������", [847] = "���������",
	[848] = "���������",

	[849] = "���������� 2", [850] = "���������� 2", [851] = "���������� 2", [852] = "���������� 2", [853] = "���������� 2",
	[854] = "���������� 2", [855] = "���������� 2", [856] = "���������� 2",

	[863] = "���������", [864] = "���������", [865] = "���������",

	[869] = "���������� 2", [870] = "���������� 2",

	[872] = "���������", [873] = "���������", [874] = "���������",

	[878] = "���������� 2", [879] = "���������� 2", [880] = "���������� 2",

	[881] = "������ �-12", [882] = "������ �-12", [883] = "������ �-12", [884] = "������ �-12", [885] = "������ �-12",
	[886] = "������ �-12",

	[887] = "������ ��", [888] = "������ ��", [889] = "������ ��", [890] = "������ ��", [891] = "������ ��",
	[892] = "������ ��",

	[897] = "�� �� (��� ������)", [898] = "�� �� (��� ������)", [899] = "�� �� (��� ������)", [900] = "�� �� (��� ������)", [901] = "�� �� (��� ������)",
	[902] = "�� �� (��� ������)",

	[916] = "���������", [917] = "���������", [918] = "���������", [919] = "���������", [920] = "���������",
	[921] = "���������", [922] = "���������", [923] = "���������", [924] = "���������", [925] = "���������",
	[926] = "���������", [927] = "���������", [928] = "���������", [929] = "���������", [930] = "���������",
	[931] = "���������", [932] = "���������", [933] = "���������", [934] = "���������",

	[935] = "������ �-3", [936] = "������ �-3", [937] = "������ �-3", [938] = "������ �-3", [939] = "������ �-3",
	[940] = "������ �-3", [941] = "������ �-3", [942] = "������ �-3", [943] = "������ �-3", [944] = "������ �-3",
	[945] = "������ �-3", [946] = "������ �-3", [947] = "������ �-3", [948] = "������ �-3", [949] = "������ �-3",
	[950] = "������ �-3", [951] = "������ �-3",

	[1005] = "���� ��", [1006] = "���� ��", [1007] = "���� ��", [1008] = "���� ��", [1009] = "���� ��",
	[1010] = "���� ��", [1011] = "���� ��", [1012] = "���� ��", [1013] = "���� ��", [1014] = "���� ��",
	[1015] = "���� ��", [1016] = "���� ��",

	[1017] = "������ �-12", [1018] = "������ �-12", [1019] = "������ �-12", [1020] = "������ �-12", [1021] = "������ �-12",
	[1022] = "������ �-12", [1023] = "������ �-12", [1024] = "������ �-12"
}

function apply_custom_styles()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

	imgui.GetIO().Fonts:Clear()
	imfonts.mainfont = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14)..'\\times.ttf', 14.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
		-- ����� ������� ��������� ����� ��� ������ ���������:
	        imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14)..'\\times.ttf', 14.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
	        imgui.RebuildFonts()
	 
end
apply_custom_styles()

function imgui.OnDrawFrame()
	-- ############################ Pie Menu
		if piearr.pie_mode.v then
			imgui.OpenPopup('PieMenu')
			if pie.BeginPiePopup('PieMenu', piearr.pie_keyid) then
					for k, v in ipairs(piearr.pie_elements) do
							if v.next == nil then if pie.PieMenuItem(u8(v.name)) then v.action() end
							elseif type(v.next) == 'table' then drawPieSub(v) end
					end
					pie.EndPiePopup()
			end
		end

		if guis.mainw.v then -- �������� ����
			imgui.SwitchContext()
			colors[clr.WindowBg] = ImVec4(0.06, 0.06, 0.06, 0.94)
			imgui.PushFont(imfonts.mainfont)
			imgui.LockPlayer = true
			sampSetChatDisplayMode(0)
			local sw, sh = getScreenResolution()
			imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(850, 730), imgui.Cond.Always)
			imgui.Begin("���.lua", guis.mainw, 4 + 2 + 32)
			local ww = imgui.GetWindowWidth()
			local wh = imgui.GetWindowHeight()
			imgui.SetCursorPos(imgui.ImVec2(ww/2 + 320, wh/2 + 320))
					if imgui.Button(u8("���������"), imgui.ImVec2(80.0, 20.0)) then guis.mainw.v = false imgui.ShowCursor = false imgui.LockPlayer = false sampSetChatDisplayMode(3) sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}���������� ����������...", -1) needtosave = true end
			imgui.SetCursorPos(imgui.ImVec2(ww/2 + 320, wh/2 + 290))
					if imgui.Button(u8("����� ����������"), imgui.ImVec2(80.0, 20.0)) then imgui.ShowCursor, imgui.LockPlayer = false, false sampSetChatDisplayMode(3) sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}���������� ����� ��������...", -1) needtoreset = true guis.mainw.v = false end
			imgui.SetCursorPos(imgui.ImVec2(ww/2 - 260, wh/2 - 320))
					if imgui.Button(u8("�������� �����"), imgui.ImVec2(120.0, 20.0)) then maintabs.tab_main_binds.status, maintabs.tab_user_binds.status, maintabs.tab_commands.status,	maintabs.tab_settings.status, maintabs.auto_bp.status.v, maintabs.rphr.status.v = true, false, false, false, false, false end
			imgui.SetCursorPos(imgui.ImVec2(ww/2 - 120, wh/2 - 320))
					if imgui.Button(u8("���������������� ������"), imgui.ImVec2(160.0, 20.0)) then maintabs.tab_main_binds.status, maintabs.tab_user_binds.status, maintabs.tab_commands.status, maintabs.tab_settings.status, maintabs.auto_bp.status.v, maintabs.rphr.status.v = false, true, false, false, false, false end
			imgui.SetCursorPos(imgui.ImVec2(ww/2 + 70, wh/2 - 320))
					if imgui.Button(u8("�������"), imgui.ImVec2(120.0, 20.0)) then maintabs.tab_main_binds.status, maintabs.tab_user_binds.status, maintabs.tab_commands.status, maintabs.tab_settings.status, maintabs.auto_bp.status.v, maintabs.rphr.status.v = false, false, true, false, false, false end
			imgui.SetCursorPos(imgui.ImVec2(ww/2 + 200, wh/2 - 320))
					if imgui.Button(u8("���������"), imgui.ImVec2(120.0, 20.0)) then maintabs.tab_main_binds.status, maintabs.tab_user_binds.status, maintabs.tab_commands.status, maintabs.tab_settings.status, maintabs.auto_bp.status.v, maintabs.rphr.status.v = false, false, false, true, false, false end

				if maintabs.tab_main_binds.status then
						if maintabs.tab_main_binds.first then
								imgui.NewLine()
								imgui.Hotkey("Name3", 3, 100) imgui.SameLine() imgui.Text(u8("���� ��������"))
								imgui.Hotkey("Name5", 5, 100) imgui.SameLine() imgui.Text(u8("���������������� � ��������� �������"))
								imgui.Hotkey("Name6", 6, 100) imgui.SameLine() imgui.Text(u8("�������� (���������� ���������� �� ���������)"))
								imgui.Hotkey("Name7", 7, 100) imgui.SameLine() imgui.Text(u8("�������� (���������� ������������)"))
								imgui.Hotkey("Name8", 8, 100) imgui.SameLine() imgui.Text(u8("�������� (���������� �������� ����������)"))
								imgui.Hotkey("Name9", 9, 100) imgui.SameLine() imgui.Text(u8("�������� \"�������� \"���\"\""))
								imgui.Hotkey("Name12", 12, 100) imgui.SameLine() imgui.Text(u8("�������� �������������"))
								imgui.Hotkey("Name13", 13, 100) imgui.SameLine() imgui.Text(u8("/lock"))
								imgui.Hotkey("Name20", 20, 100) imgui.SameLine() imgui.Text(u8("������� ����� �������"))
								imgui.Hotkey("Name21", 21, 100) imgui.SameLine() imgui.Text(u8("�������� ���� ������� � �����\n/r || ��� || SOS �-14"))
								imgui.Hotkey("Name22", 22, 100) imgui.SameLine() imgui.Text(u8("������� ������/��������� ������"))
								imgui.Hotkey("Name23", 10, 100) imgui.SameLine() imgui.Text(u8("������� �����"))
								imgui.Hotkey("Name24", 23, 100) imgui.SameLine() imgui.Text(u8("���� ��������"))
						end

						if maintabs.tab_main_binds.clistparams then
								imgui.PushItemWidth(500)
								imgui.InputText(u8'##clist1', guibuffers.clistparams.clist1) imgui.PopItemWidth() imgui.SameLine(600) imgui.PushItemWidth(500) imgui.InputText(u8'##clist27', guibuffers.clistparams.clist27)
								imgui.InputText(u8'##clist2', guibuffers.clistparams.clist2) imgui.PopItemWidth() imgui.SameLine(600) imgui.PushItemWidth(500) imgui.InputText(u8'##clist28', guibuffers.clistparams.clist28)
								imgui.InputText(u8'##clist3', guibuffers.clistparams.clist3) imgui.PopItemWidth() imgui.SameLine(600) imgui.PushItemWidth(500) imgui.InputText(u8'##clist29', guibuffers.clistparams.clist29)
								imgui.InputText(u8'##clist4', guibuffers.clistparams.clist4) imgui.PopItemWidth() imgui.SameLine(600) imgui.PushItemWidth(500) imgui.InputText(u8'##clist30', guibuffers.clistparams.clist30)
								imgui.InputText(u8'##clist5', guibuffers.clistparams.clist5) imgui.PopItemWidth() imgui.SameLine(600) imgui.PushItemWidth(500) imgui.InputText(u8'##clist31', guibuffers.clistparams.clist31)
								imgui.InputText(u8'##clist6', guibuffers.clistparams.clist6) imgui.PopItemWidth() imgui.SameLine(600) imgui.PushItemWidth(500) imgui.InputText(u8'##clist32', guibuffers.clistparams.clist32)
								imgui.InputText(u8'##clist7', guibuffers.clistparams.clist7) imgui.PopItemWidth() imgui.SameLine(600) imgui.PushItemWidth(500) imgui.InputText(u8'##clist33', guibuffers.clistparams.clist33)
								imgui.InputText(u8'##clist8', guibuffers.clistparams.clist8)
								imgui.InputText(u8'##clist9', guibuffers.clistparams.clist9)
								imgui.InputText(u8'##clist10', guibuffers.clistparams.clist10)
								imgui.InputText(u8'##clist11', guibuffers.clistparams.clist11)
								imgui.InputText(u8'##clist12', guibuffers.clistparams.clist12)
								imgui.InputText(u8'##clist13', guibuffers.clistparams.clist13)
								imgui.InputText(u8'##clist14', guibuffers.clistparams.clist14)
								imgui.InputText(u8'##clist15', guibuffers.clistparams.clist15)
								imgui.InputText(u8'##clist16', guibuffers.clistparams.clist16)
								imgui.InputText(u8'##clist17', guibuffers.clistparams.clist17)
								imgui.InputText(u8'##clist18', guibuffers.clistparams.clist18)
								imgui.InputText(u8'##clist19', guibuffers.clistparams.clist19)
								imgui.InputText(u8'##clist20', guibuffers.clistparams.clist20)
								imgui.InputText(u8'##clist22', guibuffers.clistparams.clist22)
								imgui.InputText(u8'##clist23', guibuffers.clistparams.clist23)
								imgui.InputText(u8'##clist24', guibuffers.clistparams.clist24)
								imgui.InputText(u8'##clist25', guibuffers.clistparams.clist25)
								imgui.InputText(u8'##clist26', guibuffers.clistparams.clist26)
								imgui.PopItemWidth()
						end
						
						
						
						imgui.SetCursorPos(imgui.ImVec2(ww/2 + 320, wh/2 - 30))
							if imgui.Button(u8("1"), imgui.ImVec2(80.0, 20.0)) then maintabs.tab_main_binds.first, maintabs.tab_main_binds.clistparams = true, false end
						imgui.SetCursorPos(imgui.ImVec2(ww/2 + 320, wh/2))
							if imgui.Button(u8("��������� �����"), imgui.ImVec2(80.0, 20.0)) then maintabs.tab_main_binds.first, maintabs.tab_main_binds.clistparams = false, true end
				end

				if maintabs.rphr.status.v then
					imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
					imgui.SetNextWindowSize(imgui.ImVec2(400, 400), imgui.Cond.Always)
					imgui.Begin(u8("��������� �����"), maintabs.rphr.status, 4 + 2 + 32)
					imgui.Text(u8("���� �� �������� ���� ����� ������� ��������� �������.\n�������������� ���������������� �����."))
					imgui.NewLine()
					imgui.Hotkey("Name42", 42, 100) imgui.SameLine() imgui.Text(u8("������� ���������")) imgui.NewLine()
					imgui.PushItemWidth(500)
					imgui.InputText(u8'##rphr1', guibuffers.rphr.bind1)
					imgui.InputText(u8'##rphr2', guibuffers.rphr.bind2)
					imgui.InputText(u8'##rphr3', guibuffers.rphr.bind3)
					imgui.InputText(u8'##rphr4', guibuffers.rphr.bind4)
					imgui.InputText(u8'##rphr5', guibuffers.rphr.bind5)
					imgui.InputText(u8'##rphr6', guibuffers.rphr.bind6)
					imgui.InputText(u8'##rphr7', guibuffers.rphr.bind7)
					imgui.InputText(u8'##rphr8', guibuffers.rphr.bind8)
					imgui.InputText(u8'##rphr9', guibuffers.rphr.bind9)
					imgui.InputText(u8'##rphr10', guibuffers.rphr.bind10)
					imgui.PopItemWidth()
					imgui.End()
				end

				if maintabs.tab_user_binds.status then
						if maintabs.tab_user_binds.hk then
								imgui.NewLine()
								imgui.Text(u8("������� ���������")) imgui.SameLine(300)  imgui.Text(u8("��������")) imgui.NewLine()
								imgui.Hotkey("Name27", 27, 100) imgui.SameLine() imgui.InputText(u8'##bind1', guibuffers.ubinds.bind1) imgui.SameLine() if imgui.ToggleButton("enter1", togglebools.tab_user_binds.hk[1]) then config_ini.bools[4] = togglebools.tab_user_binds.hk[1].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name28", 28, 100) imgui.SameLine() imgui.InputText(u8'##bind2', guibuffers.ubinds.bind2) imgui.SameLine() if imgui.ToggleButton("enter2", togglebools.tab_user_binds.hk[2]) then config_ini.bools[5] = togglebools.tab_user_binds.hk[2].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name29", 29, 100) imgui.SameLine() imgui.InputText(u8'##bind3', guibuffers.ubinds.bind3) imgui.SameLine() if imgui.ToggleButton("enter3", togglebools.tab_user_binds.hk[3]) then config_ini.bools[6] = togglebools.tab_user_binds.hk[3].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name30", 30, 100) imgui.SameLine() imgui.InputText(u8'##bind4', guibuffers.ubinds.bind4) imgui.SameLine() if imgui.ToggleButton("enter4", togglebools.tab_user_binds.hk[4]) then config_ini.bools[7] = togglebools.tab_user_binds.hk[4].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name31", 31, 100) imgui.SameLine() imgui.InputText(u8'##bind5', guibuffers.ubinds.bind5) imgui.SameLine() if imgui.ToggleButton("enter5", togglebools.tab_user_binds.hk[5]) then config_ini.bools[8] = togglebools.tab_user_binds.hk[5].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name32", 32, 100) imgui.SameLine() imgui.InputText(u8'##bind6', guibuffers.ubinds.bind6) imgui.SameLine() if imgui.ToggleButton("enter6", togglebools.tab_user_binds.hk[6]) then config_ini.bools[9] = togglebools.tab_user_binds.hk[6].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name33", 33, 100) imgui.SameLine() imgui.InputText(u8'##bind7', guibuffers.ubinds.bind7) imgui.SameLine() if imgui.ToggleButton("enter7", togglebools.tab_user_binds.hk[7]) then config_ini.bools[10] = togglebools.tab_user_binds.hk[7].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name34", 34, 100) imgui.SameLine() imgui.InputText(u8'##bind8', guibuffers.ubinds.bind8) imgui.SameLine() if imgui.ToggleButton("enter8", togglebools.tab_user_binds.hk[8]) then config_ini.bools[11] = togglebools.tab_user_binds.hk[8].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name35", 35, 100) imgui.SameLine() imgui.InputText(u8'##bind9', guibuffers.ubinds.bind9) imgui.SameLine() if imgui.ToggleButton("enter9", togglebools.tab_user_binds.hk[9]) then config_ini.bools[12] = togglebools.tab_user_binds.hk[9].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name36", 36, 100) imgui.SameLine() imgui.InputText(u8'##bind10', guibuffers.ubinds.bind10) imgui.SameLine() if imgui.ToggleButton("enter10", togglebools.tab_user_binds.hk[10]) then config_ini.bools[13] = togglebools.tab_user_binds.hk[10].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter")) imgui.NewLine()
								imgui.Hotkey("Name37", 37, 100) imgui.SameLine() imgui.InputText(u8'##bind11', guibuffers.ubinds.bind11) imgui.SameLine() if imgui.ToggleButton("enter11", togglebools.tab_user_binds.hk[11]) then config_ini.bools[14] = togglebools.tab_user_binds.hk[11].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("Enter"))
						end

						if maintabs.tab_user_binds.cmd then
								imgui.NewLine()
								imgui.Text(u8("������� ���������")) imgui.SameLine(300)  imgui.Text(u8("��������")) imgui.NewLine()
								imgui.PushItemWidth(100)
								imgui.InputText(u8'##ucbindsc1', guibuffers.ucbindsc.bind1) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds1', guibuffers.ucbinds.bind1) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc2', guibuffers.ucbindsc.bind2) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds2', guibuffers.ucbinds.bind2) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc3', guibuffers.ucbindsc.bind3) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds3', guibuffers.ucbinds.bind3) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc4', guibuffers.ucbindsc.bind4) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds4', guibuffers.ucbinds.bind4) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc5', guibuffers.ucbindsc.bind5) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds5', guibuffers.ucbinds.bind5) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc6', guibuffers.ucbindsc.bind6) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds6', guibuffers.ucbinds.bind6) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc7', guibuffers.ucbindsc.bind7) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds7', guibuffers.ucbinds.bind7) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc8', guibuffers.ucbindsc.bind8) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds8', guibuffers.ucbinds.bind8) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc9', guibuffers.ucbindsc.bind9) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds9', guibuffers.ucbinds.bind9) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc10', guibuffers.ucbindsc.bind10) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds10', guibuffers.ucbinds.bind10) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc11', guibuffers.ucbindsc.bind11) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds11', guibuffers.ucbinds.bind11) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc12', guibuffers.ucbindsc.bind12) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds12', guibuffers.ucbinds.bind12) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc13', guibuffers.ucbindsc.bind13) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds13', guibuffers.ucbinds.bind13) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##ucbindsc14', guibuffers.ucbindsc.bind14) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##ucbinds14', guibuffers.ucbinds.bind14) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.PopItemWidth()
						end

						if maintabs.tab_user_binds.pie then
								imgui.NewLine()
								imgui.Text(u8("Pie menu - ��� �������� ���������� ���� ��� �������� ������� ���������. �� ������ ��������� �� ������ ��������. ����������� ������� ���������, �������� �� ������ ����� � ��������� �������."))
								imgui.Hotkey("Name44", 44, 100) imgui.SameLine() imgui.Text(u8("������� ��������� (������ ��������� ������� ��������������)")) imgui.NewLine()
								imgui.Text(u8("��� ������")) imgui.SameLine(200)  imgui.Text(u8("��������")) imgui.NewLine()
								imgui.PushItemWidth(100)
								imgui.InputText(u8'##piename1', guibuffers.UserPieMenu.names.name1) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction1', guibuffers.UserPieMenu.actions.action1) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##piename2', guibuffers.UserPieMenu.names.name2) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction2', guibuffers.UserPieMenu.actions.action2) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##piename3', guibuffers.UserPieMenu.names.name3) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction3', guibuffers.UserPieMenu.actions.action3) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##piename4', guibuffers.UserPieMenu.names.name4) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction4', guibuffers.UserPieMenu.actions.action4) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##piename5', guibuffers.UserPieMenu.names.name5) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction5', guibuffers.UserPieMenu.actions.action5) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##piename6', guibuffers.UserPieMenu.names.name6) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction6', guibuffers.UserPieMenu.actions.action6) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##piename7', guibuffers.UserPieMenu.names.name7) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction7', guibuffers.UserPieMenu.actions.action7) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##piename8', guibuffers.UserPieMenu.names.name8) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction8', guibuffers.UserPieMenu.actions.action8) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##piename9', guibuffers.UserPieMenu.names.name9) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction9', guibuffers.UserPieMenu.actions.action9) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.InputText(u8'##piename10', guibuffers.UserPieMenu.names.name10) imgui.SameLine() imgui.PushItemWidth(500) imgui.InputText(u8'##pieaction10', guibuffers.UserPieMenu.actions.action10) imgui.PushItemWidth(100) imgui.NewLine()
								imgui.PopItemWidth()
						end

						imgui.SetCursorPos(imgui.ImVec2(ww/2 + 320, wh/2 - 30))
								if imgui.Button(u8("�� �������"), imgui.ImVec2(80.0, 20.0)) then maintabs.tab_user_binds.hk, maintabs.tab_user_binds.cmd, maintabs.user_keys.status.v, maintabs.tab_user_binds.pie = true, false, false, false end
						imgui.SetCursorPos(imgui.ImVec2(ww/2 + 320, wh/2))
								if imgui.Button(u8("�� �������"), imgui.ImVec2(80.0, 20.0)) then maintabs.tab_user_binds.hk, maintabs.tab_user_binds.cmd,maintabs.user_keys.status.v, maintabs.tab_user_binds.pie = false, true, false, false end
						imgui.SetCursorPos(imgui.ImVec2(ww/2 + 320, wh/2 + 30))
								if imgui.Button(u8("Pie menu"), imgui.ImVec2(80.0, 20.0)) then maintabs.tab_user_binds.hk, maintabs.tab_user_binds.cmd,maintabs.user_keys.status.v, maintabs.tab_user_binds.pie = false, false, false, true end
						imgui.SetCursorPos(imgui.ImVec2(ww/2 + 320, wh/2 + 60))
								if imgui.Button(u8("������ ������"), imgui.ImVec2(80.0, 20.0)) then maintabs.user_keys.status.v = true end
				end

				if maintabs.tab_commands.status then
						if maintabs.tab_commands.first then
							imgui.PushItemWidth(100) imgui.InputText(u8'##commands1', guibuffers.commands.command1) imgui.PopItemWidth() imgui.SameLine() imgui.PushItemWidth(100) imgui.Text(u8("�������� � ���������� ��������")) imgui.PopItemWidth()
							imgui.PushItemWidth(100) imgui.InputText(u8'##commands2', guibuffers.commands.command2) imgui.PopItemWidth() imgui.SameLine() imgui.PushItemWidth(100) imgui.Text(u8("�������� � ������������� ���������")) imgui.PopItemWidth()
							imgui.PushItemWidth(100) imgui.InputText(u8'##commands6', guibuffers.commands.command6) imgui.PopItemWidth() imgui.SameLine() imgui.PushItemWidth(100) imgui.Text(u8("�������� � �������� ��������")) imgui.PopItemWidth()
							imgui.PushItemWidth(100) imgui.InputText(u8'##commands9', guibuffers.commands.command9) imgui.PopItemWidth() imgui.SameLine() imgui.PushItemWidth(100) imgui.Text(u8("�������� � ����� � �����")) imgui.PopItemWidth()
							imgui.PushItemWidth(100) imgui.InputText(u8'##commands11', guibuffers.commands.command11) imgui.PopItemWidth() imgui.SameLine() imgui.PushItemWidth(100) imgui.Text(u8("������������� � ��������� �������")) imgui.PopItemWidth()
							imgui.PushItemWidth(100) imgui.InputText(u8'##commands14', guibuffers.commands.command14) imgui.PopItemWidth() imgui.SameLine() imgui.PushItemWidth(100) imgui.Text(u8("������� ��������� �����")) imgui.PopItemWidth()
							imgui.PushItemWidth(100) imgui.InputText(u8'##commands28', guibuffers.commands.command28) imgui.PopItemWidth() imgui.SameLine() imgui.PushItemWidth(100) imgui.Text(u8("�������� ������� � �������������")) imgui.PopItemWidth()
						end

						imgui.SetCursorPos(imgui.ImVec2(ww/2 + 320, wh/2 - 30))
								if imgui.Button(u8("1"), imgui.ImVec2(80.0, 20.0)) then maintabs.tab_commands.first, maintabs.tab_commands.second = true, false end
				end

				if maintabs.tab_settings.status then
						local selected_item = imgui.ImInt(tonumber(config_ini.Settings.pstatus))
						imgui.NewLine()
						imgui.Text(u8("������� ���� ���")) imgui.SameLine(150) 
						imgui.Text(u8("������� ���� �������")) imgui.SameLine(300) 
						imgui.Text(u8("������� ���� ������")) imgui.SameLine(450)
						imgui.Text(u8("������� ��� ������ � ������")) imgui.SameLine(610) 
						imgui.Text(u8("������� ���")) 
						imgui.NewLine()

						imgui.PushItemWidth(140)
						imgui.InputText(u8'##fname', guibuffers.settings.fname) imgui.SameLine(150) 
						imgui.InputText(u8'##sname', guibuffers.settings.sname) imgui.SameLine(300) 
						imgui.InputText(u8'##rank', guibuffers.settings.rank) imgui.SameLine(450) imgui.PopItemWidth()
						imgui.PushItemWidth(160) if imgui.Combo(u8'', selected_item, {u8'����� ���', u8'���� ���', u8'�������� ���� ���'}, 3) then config_ini.Settings.pstatus = selected_item.v config_ini.UserClist[21] = selected_item.v == 2 and "������� �����-����� ����� ��������� ����� ���λ" or selected_item.v == 1 and "������� �����-����� ����� ���λ" or "������� ���λ" end imgui.PopItemWidth() imgui.SameLine(610)
						if imgui.ToggleButton("usersex", togglebools.tab_settings[1]) then RP = togglebools.tab_settings[1].v and "�" or "" config_ini.Settings.UserSex = togglebools.tab_settings[1].v and 1 or 0 end imgui.NewLine() 
						
						if imgui.Button(u8("������� ����� ��������� �������������� ������ �� �� ������"), imgui.ImVec2(400.0, 20.0)) then maintabs.auto_bp.status.v = true end
						if imgui.Button(u8("������� ����� ��������� �������� ��������� ��������� � ���"), imgui.ImVec2(400.0, 20.0)) then maintabs.rphr.status.v = true end
				end
				
				if maintabs.user_keys.status.v then
						imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						imgui.SetNextWindowSize(imgui.ImVec2(1000, 300), imgui.Cond.Always)
						imgui.Begin(u8("������ ���������������� ������"), maintabs.user_keys.status, 4 + 2 + 32)
						imgui.Text(u8("��� ������������� ����� ������� ��� � ����������� ����� � ������ ����� ����� @. ���� ���� ����� ������� �� ���� �� ����������������� ��������.\n��������: \"��� ID : @MyID@\" ������: \"��� ID : 231\". ������ ������:\n@enter@ - ��������� ������ �� ��������� ������ (�������� " .. tostring(delay) .. " ��.) - �� �������� ��� �������������� ������� Enter � ���������������� �����.\n@Hour@ - ���������� ������� ��� (0-23) ������ ����������\n@Min@ - ���������� ������� ������ (0-60) ������ ����������\n@Sec@ - ���������� ������� ������� ������ ����������\n@Date@ - ���������� ������� ���� � ������� " .. os.date("%d.%m.%Y") .. "\n@MyID@ - ���������� ��� ������� ID\n@KV@ - ���������� ��� ������� �������\n@clist@ - ���������� �������� �������� ������ � ����������� ������ (������� �31)\n@tid@ - ���������� ID ���������� ������ � �������/�������� ������/��������� ���� (��� ���������� ��������)."))
						imgui.End()
				end

				if maintabs.auto_bp.status.v then
						imgui.SetNextWindowPos(imgui.ImVec2(sw / 2, sh / 2), imgui.Cond.Always, imgui.ImVec2(0.5, 0.5))
						imgui.SetNextWindowSize(imgui.ImVec2(310, 300), imgui.Cond.Always)
						imgui.Begin(u8("��������� ��������������� ������ �� �� ������"), maintabs.auto_bp.status, 4 + 2 + 32)
						if imgui.ToggleButton("bp1", togglebools.auto_bp[1]) then config_ini.bools[18], AutoDeagle = togglebools.auto_bp[1].v and 1 or 0, togglebools.auto_bp[1].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("����� Desert Eagle")) imgui.NewLine()
						if imgui.ToggleButton("bp2", togglebools.auto_bp[2]) then config_ini.bools[19], AutoShotgun = togglebools.auto_bp[2].v and 1 or 0, togglebools.auto_bp[2].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("����� Shotgun")) imgui.NewLine()
						if imgui.ToggleButton("bp3", togglebools.auto_bp[3]) then config_ini.bools[20], AutoSMG = togglebools.auto_bp[3].v and 1 or 0, togglebools.auto_bp[3].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("����� SMG")) imgui.NewLine()
						if imgui.ToggleButton("bp4", togglebools.auto_bp[4]) then config_ini.bools[21], AutoM4A1 = togglebools.auto_bp[4].v and 1 or 0, togglebools.auto_bp[4].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("����� M4A1")) imgui.NewLine()
						if imgui.ToggleButton("bp5", togglebools.auto_bp[5]) then config_ini.bools[22], AutoRifle = togglebools.auto_bp[5].v and 1 or 0, togglebools.auto_bp[5].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("����� Country Rifle")) imgui.NewLine()
						if imgui.ToggleButton("bp6", togglebools.auto_bp[6]) then config_ini.bools[23], AutoPar = togglebools.auto_bp[6].v and 1 or 0, togglebools.auto_bp[6].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("����� �������")) imgui.NewLine()
						if imgui.ToggleButton("bp7", togglebools.auto_bp[7]) then config_ini.bools[24], AutoOt = togglebools.auto_bp[7].v and 1 or 0, togglebools.auto_bp[7].v and 1 or 0 end imgui.SameLine() imgui.Text(u8("���������� ������ �� ������"))
						imgui.End()
				end

				imgui.ShowCursor = true
				imgui.End()
				imgui.PopFont()
		end
		-- ###################################### Overlay
end

function ev.onShowDialog(dialogid, style, title, button1, button2, text)
	--	print(dialogid, style, title, button1, button2, text)
		if dialogid == 245 and title == "����� ������" then
				istakesomeone = false
				if AutoDeagle then
					local a = getAmmoInCharWeapon(PLAYER_PED, 24)
					if a <= 61 then sampSendDialogResponse(dialogid, 1, 0, "") istakesomeone = true isdeagletaken = true return false end
				end
	
				if AutoShotgun then
					local a = getAmmoInCharWeapon(PLAYER_PED, 25)
					if a <= 28 then sampSendDialogResponse(dialogid, 1, 1, "") istakesomeone = true isshotguntaken = true return false end
				end
	
				if AutoSMG then
					local a = getAmmoInCharWeapon(PLAYER_PED, 29)
					if a <= 178 then sampSendDialogResponse(dialogid, 1, 2, "") istakesomeone = true issmgtaken = true return false end
				end
	
				if AutoM4A1 then
					local a = getAmmoInCharWeapon(PLAYER_PED, 31)
					if a <= 290 then sampSendDialogResponse(dialogid, 1, 3, "") istakesomeone = true ism4a1taken = true return false end
				end
	
				if AutoRifle then
					local a = getAmmoInCharWeapon(PLAYER_PED, 33)
					if a <= 28 then sampSendDialogResponse(dialogid, 1, 4, "") istakesomeone = true isrifletaken = true return false end
				end
	
				if AutoPar and (os.time() > partimer) then
					local a = getAmmoInCharWeapon(PLAYER_PED, 46)
					if a ~= 1 then sampSendDialogResponse(dialogid, 1, 6, "") istakesomeone = true ispartaken = true partimer = os.time() + 60 return false end
				end
	
				if not isarmtaken then sampSendDialogResponse(dialogid, 1, 5, "") istakesomeone = true isarmtaken = true return false end
	
				if not istakesomeone then
						if AutoOt then
								 local otsrt = ""
								if isarmtaken then otsrt = "����������" end
								if isdeagletaken then otsrt = otsrt == "" and "Desert Eagle" or "" .. otsrt .. ", Desert Eagle" end
								if isshotguntaken then otsrt = otsrt == "" and "Shotgun" or "" .. otsrt .. ", Shotgun" end
								if issmgtaken then otsrt = otsrt == "" and "HK MP-5" or "" .. otsrt .. ", HK MP-5" end
								if ism4a1taken then otsrt = otsrt == "" and "M4A1" or "" .. otsrt .. ", M4A1" end
								if isrifletaken then otsrt = otsrt == "" and "Country Rifle" or "" .. otsrt .. ", Country Rifle" end
								if ispartaken then otsrt = otsrt == "" and "�������" or "" .. otsrt .. ", �������" end
								if otsrt ~= "" then sampSendChat("/me ����" .. RP .. " �� ������ " .. otsrt .. "") end
						end
						sampCloseCurrentDialogWithButton(0)
						isarmtaken, isdeagletaken, isshotguntaken, issmgtaken, ism4a1taken, isrifletaken, ispartaken, istakesomeone, whatwastaken = false, false, false, false, false, false, false, false, {}
						if config_ini.bools[46] == 1 and skipd[1].pid == skipd[2][6] then sampSendPickedUpPickup(skipd[2][5]) end
						return false
				end
		end
end

function ev.onServerMessage(col, text)
	local date = text:match("�������� ���� ������� �� (.*)") -- ������� �� ��� ����
	if date ~= nil then
		local datetime = {}
		datetime.year, datetime.month, datetime.day = string.match(date,"(%d%d%d%d)%/(%d%d)%/(%d%d)")
		if math.floor((os.difftime(os.time(datetime), os.time())) / 3600 / 24) <= 7 then sampAddChatMessage("{FF0000}[LUA]: ��������!{FFFAFA} �� ����� ���� �������� ������ ������.", 0xffff0000) end
	end

	if text:match("������� .* ����� ��������������� ��� ���������� �� %d+ ����.*") then sampSendChat("/ac repair") return end
	
	local cost = tonumber(text:match("������� .* ����� ��������� ��� ���������� �� (%d+) ����.*"))
	if cost ~= nil then
		if cost <= 3000 then lua_thread.create(function() wait(600) sampSendChat("/ac refill") end) return end
	end
	
	local re0 = regex.new("(�������|��������|��.�������|�������|��.�������|��������|���������|��.���������|���������|��.���������|�������|�����|������������|���������|�������)  (.*)\\_(.*)\\[([0-9]+)\\]\\: (.*)") --
	local z, fn, sn, id, txt = re0:match(text)
	if txt ~= nil and col == -1920073729 then
		local clist = string.sub(string.format('%x', sampGetPlayerColor(id)), 3)
		clist = clist == "ffff" and "fffafa" or clist
		sampAddChatMessage(" {8470FF}" .. z .. " {" .. clist .. "}" .. fn .. "_" .. sn .. "[" .. id .. "]{8470FF}: " .. txt .. "", 0xFF8470FF)
		return false
	end
	if not duel.mode then
		local myid = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
		local myn, myf = sampGetPlayerNickname(myid):match("(.*)%_(.*)")
		local f, n = text:match(" (.*)%_(.*) ������.? �������� ��� ���� " .. myn .. " " .. myf .. "")
		if f == nil then return end
		local nick = "" .. f .. "_" .. n .. ""
		local id = sampGetPlayerIdByNickname(nick)
		if f ~= nil then
			duel.mode = true
			duel.en.id = id
			lua_thread.create(function()
				sampAddChatMessage("{FF0000}[LUA]: {fffafa}" .. nick .. "[" .. id .. "] �������� ��� �� �����. ������� Y ��� �������� � N ��� ������", 0x00FFFAFA)
				while true do wait(0) if isKeyDown(vkeys.VK_Y) then break end if isKeyDown(vkeys.VK_N) then sampAddChatMessage("{FF0000}[LUA]: {FFFAFA}����������� ���������.", 0xFFFF0000) sampSendChat("/me ��������" .. RP .. " �� ��������� ��������") duel.mode = false duel.en = -1 return end end
				if not duel.mode then sampAddChatMessage("{FF0000}[LUA]: {FFFAFA}����� ��������.", 0xFFFF0000) duel.mode = false duel.en.id = -1 return end

				duel.fightmode = true
				duel.en.hp = sampGetPlayerHealth(id)
				duel.en.arm = sampGetPlayerArmor(id)
				duel.my.hp = sampGetPlayerHealth(myid)
				duel.my.arm = sampGetPlayerArmor(myid)
				local abc = ((duel.en.hp ~= duel.my.hp) or (duel.my.arm ~= duel.en.arm)) and "�������� �����" or "�����"
				sampAddChatMessage("{FF0000}[LUA]: {FFFAFA}����������� �������. ������� ������", 0xFFFF0000)
				sampSendChat("/me ������" .. RP .. " ��������� ��������")
				wait(1300)
				sampSendChat("/do *����� �����*: \"".. abc .. ": " .. myn .. " " .. myf .. " vs " .. f .. " " .. n .. " �������� ����� 3!\"")
				math.randomseed(os.time())
				local A_Index = 1

				while true do
					wait(0)
					local myHP = sampGetPlayerHealth(myid)
					local myARM = sampGetPlayerArmor(myid)
					local enHP = sampGetPlayerHealth(id)
					local enARM = sampGetPlayerArmor(id)

					if myHP ~= duel.my.hp or enHP ~= duel.en.hp or myARM ~= duel.my.arm or enARM ~= duel.en.arm then 
						wait(600)
						sampSendChat("/do *����� �����*: \"���������! ����� ��������!\"")
						duel.mode = false
						duel.en.id = -1
						duel.fightmode = false
						return
					end

					wait(1000)
					local delay = math.random(1, 3)
					wait(4000 - delay * 1000)
					sampSendChat("/do *����� �����*: \"" .. (A_Index == 1 and "2!" or A_Index == 2 and "1!" or "GO!") .. "\"")
					if A_Index == 3 then break end
					A_Index = A_Index + 1
				end

				while true do
					wait(0)
					local myHP = sampGetPlayerHealth(myid)
					local enHP = sampGetPlayerHealth(id)
					if myHP <= 12 or enHP <= 12 then 
						sampSendChat("/do *����� �����*: \"".. abc .. " ��������! ���������� - " .. (myHP <= 12 and "".. f .. " " .. n .. "" or "" .. myn .. " " .. myf .. "") .. "!\"")
						duel.mode = false
						duel.en.id = -1
						duel.fightmode = false
						return
					end
				end
			end) 
		end
	end
end

function getTableUsersByUrl(url) -- ��������� ����� �����
    local n_file, bool, users = os.getenv('TEMP')..os.time(), false, {}
    downloadUrlToFile(url, n_file, function(id, status)
        if status == 6 then bool = true end
    end)
    while not doesFileExist(n_file) do wait(0) end
    if bool then
        local file = io.open(n_file, 'r')
        for w in file:lines() do
            local n, d = w:match('(.*): (.*)')
            users[#users+1] = { name = n, date = d }
        end
        file:close()
        os.remove(n_file)
    end
    return users
end

function isAvailableUser(users, name) -- ��������� ����� �����
    for i, k in pairs(users) do
        if k.name == name then
            local d, m, y = k.date:match('(%d+)%.(%d+)%.(%d+)')
            local time = {
                day = tonumber(d),
                isdst = true,
                wday = 0,
                yday = 0,
                year = tonumber(y),
                month = tonumber(m),
                hour = 0
            }
            if os.time(time) >= os.time() then return true end
        end
    end
    return false
end

site = 'https://raw.githubusercontent.com/TommyCorona/SampScripts/main/dostup.txt'

function main()
	if not isSampLoaded() or not isSampfuncsLoaded() then return end
	while not isSampAvailable() do wait(100) end
	sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������� ������� ��������.",-1)
	prepare()
	while not preparecomplete do wait(0) end
	rkeys.unRegisterHotKey(makeHotKey(13))
	imgui.Process = true
	imgui.ShowCursor = false
	imgui.LockPlayer = false
	ped = getCharPointer(PLAYER_PED)
	downloadUrlToFile(update_url, update_path, function(id, status)
		if status == dlstatus.STATUS_ENDDOWNLOADDATA then
			updateIni = inicfg.load(nil, update_path)
			if tonumber(updateIni.info.vers) > script_vers then
				sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}���� ����������! ������: " .. updateIni.info.vers_text, -1)
				update_state = true
			end
			os.remove(update_path)
		end
	end)
	while true do
		wait(0)
		if update_state then
			downloadUrlToFile(script_url, script_path, function(id, status)
				if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ������� ��������", -1)
					thisScript():reload()
				end
			end)
			break
		end
		if suspendkeys == 2 then
			rkeys.registerHotKey(makeHotKey(13), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_13() end)
			rkeys.registerHotKey(makeHotKey(3), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_3() end)
			rkeys.registerHotKey(makeHotKey(5), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_5() end)
			rkeys.registerHotKey(makeHotKey(6), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_6() end)
			rkeys.registerHotKey(makeHotKey(7), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_7() end)
			rkeys.registerHotKey(makeHotKey(8), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_8() end)
			rkeys.registerHotKey(makeHotKey(9), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_9() end)
			rkeys.registerHotKey(makeHotKey(10), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_10() end)
			rkeys.registerHotKey(makeHotKey(12), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_12() end)
			rkeys.registerHotKey(makeHotKey(20), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_20() end)
			rkeys.registerHotKey(makeHotKey(21), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_21() end)
			rkeys.registerHotKey(makeHotKey(22), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_22() end)
			rkeys.registerHotKey(makeHotKey(23), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_23() end)
			rkeys.registerHotKey(makeHotKey(27), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_27() end)
			rkeys.registerHotKey(makeHotKey(28), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_28() end)
			rkeys.registerHotKey(makeHotKey(29), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_29() end)
			rkeys.registerHotKey(makeHotKey(30), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_30() end)
			rkeys.registerHotKey(makeHotKey(31), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_31() end)
			rkeys.registerHotKey(makeHotKey(32), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_32() end)
			rkeys.registerHotKey(makeHotKey(33), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_33() end)
			rkeys.registerHotKey(makeHotKey(34), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_34() end)
			rkeys.registerHotKey(makeHotKey(35), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_35() end)
			rkeys.registerHotKey(makeHotKey(36), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_36() end)
			rkeys.registerHotKey(makeHotKey(37), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_37() end)
			rkeys.registerHotKey(makeHotKey(42), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_42() end)

			sampRegisterChatCommand(config_ini.Commands[1], cmd_ob)
			sampRegisterChatCommand(config_ini.Commands[2], cmd_sopr)
			sampRegisterChatCommand(config_ini.Commands[6], cmd_kv)
			sampRegisterChatCommand(config_ini.Commands[11], hk_5)
			sampRegisterChatCommand(config_ini.Commands[14], cmd_cl)
			sampRegisterChatCommand(config_ini.Commands[28], cmd_showp)
			sampRegisterChatCommand(config_ini.Commands[9], cmd_r)
			sampRegisterChatCommand("piss", function() sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������, � �� ����� ��������", 0xfffffafa) return end)
			sampRegisterChatCommand("iznas", function() sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������, ��� ��������!", 0xfffffafa) return end)
			sampRegisterChatCommand("sw", cmd_sw)
			sampRegisterChatCommand("st", cmd_st)
			sampRegisterChatCommand("duel", cmd_duel)

			sampRegisterChatCommand(config_ini.UserCBinderC[1], cmd_u1)
			sampRegisterChatCommand(config_ini.UserCBinderC[2], cmd_u2)
			sampRegisterChatCommand(config_ini.UserCBinderC[3], cmd_u3)
			sampRegisterChatCommand(config_ini.UserCBinderC[4], cmd_u4)
			sampRegisterChatCommand(config_ini.UserCBinderC[5], cmd_u5)
			sampRegisterChatCommand(config_ini.UserCBinderC[6], cmd_u6)
			sampRegisterChatCommand(config_ini.UserCBinderC[7], cmd_u7)
			sampRegisterChatCommand(config_ini.UserCBinderC[8], cmd_u8)
			sampRegisterChatCommand(config_ini.UserCBinderC[9], cmd_u9)
			sampRegisterChatCommand(config_ini.UserCBinderC[10], cmd_u10)
			sampRegisterChatCommand(config_ini.UserCBinderC[11], cmd_u11)
			sampRegisterChatCommand(config_ini.UserCBinderC[12], cmd_u12)
			sampRegisterChatCommand(config_ini.UserCBinderC[13], cmd_u13)
			sampRegisterChatCommand(config_ini.UserCBinderC[14], cmd_u14)
			sampRegisterChatCommand(config_ini.UserCBinderC[15], cmd_u15)
			sampRegisterChatCommand(config_ini.UserCBinderC[16], cmd_u16)
			sampRegisterChatCommand(config_ini.UserCBinderC[17], cmd_u17)
			sampRegisterChatCommand(config_ini.UserCBinderC[18], cmd_u18)
			
			piearr.action = 0
			piearr.pie_mode.v = false -- ����� PieMenu
			piearr.pie_keyid = makeHotKey(44)[1]
			piearr.pie_elements =	{}

			if config_ini.UserPieMenuNames[1] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[1], action = function() piearr.action = 1 end, next = nil}) end
			if config_ini.UserPieMenuNames[2] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[2], action = function() piearr.action = 2 end, next = nil}) end
			if config_ini.UserPieMenuNames[3] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[3], action = function() piearr.action = 3 end, next = nil}) end
			if config_ini.UserPieMenuNames[4] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[4], action = function() piearr.action = 4 end, next = nil}) end
			if config_ini.UserPieMenuNames[5] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[5], action = function() piearr.action = 5 end, next = nil}) end
			if config_ini.UserPieMenuNames[6] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[6], action = function() piearr.action = 6 end, next = nil}) end
			if config_ini.UserPieMenuNames[7] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[7], action = function() piearr.action = 7 end, next = nil}) end
			if config_ini.UserPieMenuNames[8] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[8], action = function() piearr.action = 8 end, next = nil}) end
			if config_ini.UserPieMenuNames[9] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[9], action = function() piearr.action = 9 end, next = nil}) end
			if config_ini.UserPieMenuNames[10] ~= "" then table.insert(piearr.pie_elements, {name = config_ini.UserPieMenuNames[10], action = function() piearr.action = 10 end, next = nil}) end
			suspendkeys = 0
		end

		if not guis.mainw.v and not SetMode and not piearr.pie_mode.v then imgui.ShowCursor = false imgui.LockPlayer = false if suspendkeys == 1 then suspendkeys = 2 sampSetChatDisplayMode(3) end end

		if needtosave then
			needtosave = false
			lua_thread.create(function()
				config_ini.UserClist[1] = tostring(u8:decode(guibuffers.clistparams.clist1.v))
				config_ini.UserClist[2] = tostring(u8:decode(guibuffers.clistparams.clist2.v))
				config_ini.UserClist[3] = tostring(u8:decode(guibuffers.clistparams.clist3.v))
				config_ini.UserClist[4] = tostring(u8:decode(guibuffers.clistparams.clist4.v))
				config_ini.UserClist[5] = tostring(u8:decode(guibuffers.clistparams.clist5.v))
				config_ini.UserClist[6] = tostring(u8:decode(guibuffers.clistparams.clist6.v))
				config_ini.UserClist[7] = tostring(u8:decode(guibuffers.clistparams.clist7.v))
				config_ini.UserClist[8] = tostring(u8:decode(guibuffers.clistparams.clist8.v))
				config_ini.UserClist[9] = tostring(u8:decode(guibuffers.clistparams.clist9.v))
				config_ini.UserClist[10] = tostring(u8:decode(guibuffers.clistparams.clist10.v))
				config_ini.UserClist[11] = tostring(u8:decode(guibuffers.clistparams.clist11.v))
				config_ini.UserClist[12] = tostring(u8:decode(guibuffers.clistparams.clist12.v))
				config_ini.UserClist[13] = tostring(u8:decode(guibuffers.clistparams.clist13.v))
				config_ini.UserClist[14] = tostring(u8:decode(guibuffers.clistparams.clist14.v))
				config_ini.UserClist[15] = tostring(u8:decode(guibuffers.clistparams.clist15.v))
				config_ini.UserClist[16] = tostring(u8:decode(guibuffers.clistparams.clist16.v))
				config_ini.UserClist[17] = tostring(u8:decode(guibuffers.clistparams.clist17.v))
				config_ini.UserClist[18] = tostring(u8:decode(guibuffers.clistparams.clist18.v))
				config_ini.UserClist[19] = tostring(u8:decode(guibuffers.clistparams.clist19.v))
				config_ini.UserClist[20] = tostring(u8:decode(guibuffers.clistparams.clist20.v))
				config_ini.UserClist[22] = tostring(u8:decode(guibuffers.clistparams.clist22.v))
				config_ini.UserClist[23] = tostring(u8:decode(guibuffers.clistparams.clist23.v))
				config_ini.UserClist[24] = tostring(u8:decode(guibuffers.clistparams.clist24.v))
				config_ini.UserClist[25] = tostring(u8:decode(guibuffers.clistparams.clist25.v))
				config_ini.UserClist[26] = tostring(u8:decode(guibuffers.clistparams.clist26.v))
				config_ini.UserClist[27] = tostring(u8:decode(guibuffers.clistparams.clist27.v))
				config_ini.UserClist[28] = tostring(u8:decode(guibuffers.clistparams.clist28.v))
				config_ini.UserClist[29] = tostring(u8:decode(guibuffers.clistparams.clist29.v))
				config_ini.UserClist[30] = tostring(u8:decode(guibuffers.clistparams.clist30.v))
				config_ini.UserClist[31] = tostring(u8:decode(guibuffers.clistparams.clist31.v))
				config_ini.UserClist[32] = tostring(u8:decode(guibuffers.clistparams.clist32.v))
				config_ini.UserClist[33] = tostring(u8:decode(guibuffers.clistparams.clist33.v))

				config_ini.UserBinder[1] = tostring(u8:decode(guibuffers.ubinds.bind1.v))
				config_ini.UserBinder[2] = tostring(u8:decode(guibuffers.ubinds.bind2.v))
				config_ini.UserBinder[3] = tostring(u8:decode(guibuffers.ubinds.bind3.v))
				config_ini.UserBinder[4] = tostring(u8:decode(guibuffers.ubinds.bind4.v))
				config_ini.UserBinder[5] = tostring(u8:decode(guibuffers.ubinds.bind5.v))
				config_ini.UserBinder[6] = tostring(u8:decode(guibuffers.ubinds.bind6.v))
				config_ini.UserBinder[7] = tostring(u8:decode(guibuffers.ubinds.bind7.v))
				config_ini.UserBinder[8] = tostring(u8:decode(guibuffers.ubinds.bind8.v))
				config_ini.UserBinder[9] = tostring(u8:decode(guibuffers.ubinds.bind9.v))
				config_ini.UserBinder[10] = tostring(u8:decode(guibuffers.ubinds.bind10.v))
				config_ini.UserBinder[11] = tostring(u8:decode(guibuffers.ubinds.bind11.v))

				config_ini.UserCBinder[1] = tostring(u8:decode(guibuffers.ucbinds.bind1.v))
				config_ini.UserCBinder[2] = tostring(u8:decode(guibuffers.ucbinds.bind2.v))
				config_ini.UserCBinder[3] = tostring(u8:decode(guibuffers.ucbinds.bind3.v))
				config_ini.UserCBinder[4] = tostring(u8:decode(guibuffers.ucbinds.bind4.v))
				config_ini.UserCBinder[5] = tostring(u8:decode(guibuffers.ucbinds.bind5.v))
				config_ini.UserCBinder[6] = tostring(u8:decode(guibuffers.ucbinds.bind6.v))
				config_ini.UserCBinder[7] = tostring(u8:decode(guibuffers.ucbinds.bind7.v))
				config_ini.UserCBinder[8] = tostring(u8:decode(guibuffers.ucbinds.bind8.v))
				config_ini.UserCBinder[9] = tostring(u8:decode(guibuffers.ucbinds.bind9.v))
				config_ini.UserCBinder[10] = tostring(u8:decode(guibuffers.ucbinds.bind10.v))
				config_ini.UserCBinder[11] = tostring(u8:decode(guibuffers.ucbinds.bind11.v))
				config_ini.UserCBinder[12] = tostring(u8:decode(guibuffers.ucbinds.bind12.v))
				config_ini.UserCBinder[13] = tostring(u8:decode(guibuffers.ucbinds.bind13.v))
				config_ini.UserCBinder[14] = tostring(u8:decode(guibuffers.ucbinds.bind14.v))

				config_ini.UserCBinderC[1] = tostring(u8:decode(guibuffers.ucbindsc.bind1.v))
				config_ini.UserCBinderC[2] = tostring(u8:decode(guibuffers.ucbindsc.bind2.v))
				config_ini.UserCBinderC[3] = tostring(u8:decode(guibuffers.ucbindsc.bind3.v))
				config_ini.UserCBinderC[4] = tostring(u8:decode(guibuffers.ucbindsc.bind4.v))
				config_ini.UserCBinderC[5] = tostring(u8:decode(guibuffers.ucbindsc.bind5.v))
				config_ini.UserCBinderC[6] = tostring(u8:decode(guibuffers.ucbindsc.bind6.v))
				config_ini.UserCBinderC[7] = tostring(u8:decode(guibuffers.ucbindsc.bind7.v))
				config_ini.UserCBinderC[8] = tostring(u8:decode(guibuffers.ucbindsc.bind8.v))
				config_ini.UserCBinderC[9] = tostring(u8:decode(guibuffers.ucbindsc.bind9.v))
				config_ini.UserCBinderC[10] = tostring(u8:decode(guibuffers.ucbindsc.bind10.v))
				config_ini.UserCBinderC[11] = tostring(u8:decode(guibuffers.ucbindsc.bind11.v))
				config_ini.UserCBinderC[12] = tostring(u8:decode(guibuffers.ucbindsc.bind12.v))
				config_ini.UserCBinderC[13] = tostring(u8:decode(guibuffers.ucbindsc.bind13.v))
				config_ini.UserCBinderC[14] = tostring(u8:decode(guibuffers.ucbindsc.bind14.v))

				config_ini.Commands[1] = tostring(u8:decode(guibuffers.commands.command1.v))
				config_ini.Commands[2] = tostring(u8:decode(guibuffers.commands.command2.v))
				config_ini.Commands[6] = tostring(u8:decode(guibuffers.commands.command6.v))
				config_ini.Commands[7] = tostring(u8:decode(guibuffers.commands.command7.v))
				config_ini.Commands[9] = tostring(u8:decode(guibuffers.commands.command9.v))
				config_ini.Commands[11] = tostring(u8:decode(guibuffers.commands.command11.v))
				config_ini.Commands[14] = tostring(u8:decode(guibuffers.commands.command14.v))
				config_ini.Commands[28] = tostring(u8:decode(guibuffers.commands.command28.v))

				config_ini.Settings.PlayerFirstName = tostring(u8:decode(guibuffers.settings.fname.v))
				config_ini.Settings.PlayerSecondName = tostring(u8:decode(guibuffers.settings.sname.v))
				config_ini.Settings.PlayerRank = tostring(u8:decode(guibuffers.settings.rank.v))		
				PlayerU = config_ini.Settings.PlayerU
				useclist = config_ini.Settings.useclist
				tag = config_ini.Settings.tag

				config_ini.UserPieMenuNames[1] = tostring(u8:decode(guibuffers.UserPieMenu.names.name1.v))
				config_ini.UserPieMenuNames[2] = tostring(u8:decode(guibuffers.UserPieMenu.names.name2.v))
				config_ini.UserPieMenuNames[3] = tostring(u8:decode(guibuffers.UserPieMenu.names.name3.v))
				config_ini.UserPieMenuNames[4] = tostring(u8:decode(guibuffers.UserPieMenu.names.name4.v))
				config_ini.UserPieMenuNames[5] = tostring(u8:decode(guibuffers.UserPieMenu.names.name5.v))
				config_ini.UserPieMenuNames[6] = tostring(u8:decode(guibuffers.UserPieMenu.names.name6.v))
				config_ini.UserPieMenuNames[7] = tostring(u8:decode(guibuffers.UserPieMenu.names.name7.v))
				config_ini.UserPieMenuNames[8] = tostring(u8:decode(guibuffers.UserPieMenu.names.name8.v))
				config_ini.UserPieMenuNames[9] = tostring(u8:decode(guibuffers.UserPieMenu.names.name9.v))
				config_ini.UserPieMenuNames[10] = tostring(u8:decode(guibuffers.UserPieMenu.names.name10.v))

				config_ini.UserPieMenuActions[1] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action1.v))
				config_ini.UserPieMenuActions[2] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action2.v))
				config_ini.UserPieMenuActions[3] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action3.v))
				config_ini.UserPieMenuActions[4] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action4.v))
				config_ini.UserPieMenuActions[5] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action5.v))
				config_ini.UserPieMenuActions[6] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action6.v))
				config_ini.UserPieMenuActions[7] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action7.v))
				config_ini.UserPieMenuActions[8] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action8.v))
				config_ini.UserPieMenuActions[9] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action9.v))
				config_ini.UserPieMenuActions[10] = tostring(u8:decode(guibuffers.UserPieMenu.actions.action10.v))

				config_ini.rphr[1] = tostring(u8:decode(guibuffers.rphr.bind1.v))
				config_ini.rphr[2] = tostring(u8:decode(guibuffers.rphr.bind2.v))
				config_ini.rphr[3] = tostring(u8:decode(guibuffers.rphr.bind3.v))
				config_ini.rphr[4] = tostring(u8:decode(guibuffers.rphr.bind4.v))
				config_ini.rphr[5] = tostring(u8:decode(guibuffers.rphr.bind5.v))
				config_ini.rphr[6] = tostring(u8:decode(guibuffers.rphr.bind6.v))
				config_ini.rphr[7] = tostring(u8:decode(guibuffers.rphr.bind7.v))
				config_ini.rphr[8] = tostring(u8:decode(guibuffers.rphr.bind8.v))
				config_ini.rphr[9] = tostring(u8:decode(guibuffers.rphr.bind9.v))
				config_ini.rphr[10] = tostring(u8:decode(guibuffers.rphr.bind10.v))
				
				inicfg.save(config_ini, "config_���")
				sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}��������� ���� ������� ���������", -1)
			end)
		end

		if needtoreset then
			os.remove("Moonloader\\config\\config_���.ini")
			sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}��������� ���� ������� ��������. ������� ����������...", -1)
			needtoreset = false
			wait(0)
			thisScript():reload()
		end

		-- ��������� ������� �� ������� (�� ��� ��� �������� ����� ������ ����� �����)
		if time then setTimeOfDay(time, 0) end
					
		-- ��������� Pie Menu
		if isKeyDown(makeHotKey(44)[1]) and piearr.action == 0 and not sampIsChatInputActive() and not sampIsDialogActive(-1) and not isSampfuncsConsoleActive() then 
			wait(0) 
			piearr.pie_mode.v = true 
			imgui.ShowCursor = true 
		else 
			wait(0) 
			piearr.pie_mode.v = false 
			imgui.ShowCursor = false 
		end

		-- �������� �� ������ � Pie Menu
		if piearr.action ~= 0 then
				local SB = formatbind(config_ini.UserPieMenuActions[piearr.action])
				if SB ~= nil then for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end end
				piearr.action = 0
		end
	end
end

function cmd_duel(sparams)
	if sparams == "-1" then sampSendChat("/me ��������" .. RP .. " �� ��������� ��������") duel.mode = false duel.en.id = -1 return end
	local id = tonumber(sparams)
	local myid = select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))
	if id == nil or (id < 0 and id > 999) or not sampIsPlayerConnected(id) then sampAddChatMessage("{FF0000}[LUA]: {FFFAFA}����� �������", 0xFFFF0000) return end
	if not sampGetCharHandleBySampPlayerId(id) then sampAddChatMessage("{FF0000}[LUA]: {FFFAFA}����� �� ������", 0xFFFF0000) return end
	local n, f = sampGetPlayerNickname(id):match("(.*)%_(.*)")
	sampSendChat("/me ������" .. RP .. " �������� ��� ���� " .. n .. " " .. f .. "")
	duel.mode = true
	duel.en.id = id
	--duel.en.hp = sampGetPlayerHealth(id)
	--duel.en.arm = sampGetPlayerArmor(id)
	--duel.my.hp = sampGetPlayerHealth(myid)
	--duel.my.arm = sampGetPlayerArmor(myid)
end

function sampGetPlayerIdByNickname(nick)
	local _, myid = sampGetPlayerIdByCharHandle(playerPed)
	if tostring(nick) == sampGetPlayerNickname(myid) then return myid end
	for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
end

function hk_42()
	lua_thread.create(function()
		local tarr = {}
		for k, v in ipairs(config_ini.rphr) do if v ~= "" then table.insert(tarr, v) end end
		math.randomseed(os.time())
		local num = math.random(1, table.maxn(tarr))
		if num == lastrand then if num == table.maxn(tarr) then num = 1 else num = num + 1 end end
		local SB = formatbind(tarr[num])
		if SB == nil then return end
		lastrand = num
		for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
	end)
end

function cmd_r(sparams)
	if sparams == "" then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� ��������. ������� /" .. config_ini.Commands[9] .. " [�����]", -1) return end
	local t = strunsplit(sparams, 80)
	isSending = true
	lua_thread.create(function() for k, v in ipairs(t) do sampSendChat("/f " .. tag .. " " .. v .. "") wait(1300) end isSending = false end)
end

function cmd_st(sparams)
		local hour = tonumber(sparams)
		if hour ~= nil and hour >= 0 and hour <= 23 then
				time = hour
				patch_samp_time_set(true)
		else
				patch_samp_time_set(false)
				time = nil
		end
end

function cmd_sw(sparams)
		local weather = tonumber(sparams)
	  if weather ~= nil and weather >= 0 and weather <= 45 then
	    	forceWeatherNow(weather)
	  end
end

function patch_samp_time_set(enable)
		if enable and default == nil then
				default = readMemory(sampGetBase() + 0x9C0A0, 4, true)
				writeMemory(sampGetBase() + 0x9C0A0, 4, 0x000008C2, true)
		elseif enable == false and default ~= nil then
				writeMemory(sampGetBase() + 0x9C0A0, 4, default, true)
				default = nil
		end
end

function cmd_showp(sparams)
	lua_thread.create(
				function()
						wait(0)
						if tonumber(sparams) ~= nil and tonumber(sparams) >= 0 and tonumber(sparams) <= 999 then sampSendChat("/showpass " .. sparams .. "") wait(delay) end
						sampSendChat("/me �������" .. RP .. " ������������� � �������� ����")
						wait(delay)
						isSending = true
						sampSendChat("/do � �������������: Army SF | " .. config_ini.Settings.PlayerFirstName .. " " .. config_ini.Settings.PlayerSecondName .. " | " .. config_ini.Settings.PlayerRank .. " | ���")
						isSending = false
					end
		)
end

function hk_3()
	lua_thread.create(
			function()
					if not showdialog(1, "���� ��������", "{FFFAFA}[1] - ���������\n[2] - �������������\n[3] - ������� ������� � ��������\n[4] - ������� �������� � ��������\n[5] - �������� ��������� �� ����\n[6] - �������� �������������� � ���������� ����\n[7] - ������� ����/�������\n[0] - ������", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
					res = waitForChooseInDialog(1)
					if res == "" then sampSendChat("/f " .. tag .. " �������!") return end
					
					if not res or tonumber(res) == nil or (tonumber(res) < 0 or tonumber(res) > 7) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end

					if res == "1" then
							local zzz = {[1] = "��������� ������������", [2] = "��� �������� �������������", [3] = "��� �������� �������������", [4] = "������ �������� �������������", [5] = "���� ��������� �������������", [6] = "����� ��������� �������������", [7] = "���� ��������� �������������", [8] = "������ ��������� �������������", [9] = "������ ��������� �������������", [10] = "������ ��������� �������������"}

							if not showdialog(1, "���������", "���������� ���������. �� 1 �� 10.", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
							res = waitForChooseInDialog(1)
							if not res or tonumber(res) == nil or zzz[tonumber(res)] == nil then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end
							local kol = tonumber(res)

							wait(0)
							if not showdialog(1, "���������", "������� �� �-1 �� �-24", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
							res = waitForChooseInDialog(1)
							if not res or res == "" or tonumber(res) == 0 then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end
							local b, n = res:match("([�-�])-(%d+)")
							if b == nil or (tonumber(n) < 1 or tonumber(n) > 24) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� �������.", -1) return end
							local kv = "" .. b .. "-" .. n .. ""

							wait(0)
							if not showdialog(1, "���������", "�������� ������?\n[1] - ��������(�) ������(�)\n[2] - �������� �� ������\n[3] - ��������� ��������� � ���� �������� ������", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
							res = waitForChooseInDialog(1)
							if not res or tonumber(res) == nil or tonumber(res) == 0 or (tonumber(res) < 0 or tonumber(res) > 3) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end

							local obdokl = "/f " .. tag .. " " .. zzz[kol] ..  ""
							local obdokl2 = iskv and " � �������� " .. kv .. "." or " ."
							local obdokl3
							if tonumber(res) == 2 then obdokl3 = "" elseif tonumber(res) == 3 or kol == 1 then obdokl3 = " �������� ������" elseif tonumber(res) == 1 and kol > 1 then obdokl3 = " ��������� �������" end
							local dokl = obdokl .. obdokl2 .. obdokl3
							sampSendChat(dokl)
					end

					if res == "2" then
							if not showdialog(1, "������� ����� ����������", "[1] - Los-Santos Police Department\n[2] - San-Fierro Police Department\n[3] - Las-Venturas Police Departmen\n[4] - Federal Bureau of Investigation\n[5] - San-Fierro Army\n[6] - San-Fierro\n[0] - ����� (������� 0)", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
							res = waitForChooseInDialog(1)
							if not res or res == "" or (tonumber(res) ~= nil and (tonumber(res) < 0 or tonumber(res) > 6)) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end
							if tonumber(res) == 0 then sampSendChat("/f " .. tag .. " ������� � ������������� ���") return end
							local arr = {
									["1"] = "Police LS", ["ls"] = "Police LS", ["lspd"] = "Police LS", ["��"] = "Police LS", ["����"] = "Police LS",
									["2"] = "Police SF", ["sfpd"] = "Police SF", ["����"] = "Police SF",
									["3"] = "Police LV", ["lv"] = "Police LV", ["lvpd"] = "Police LV", ["��"] = "Police LV", ["����"] = "Police LV",
									["4"] = "FBI", ["fbi"] = "FBI", ["���"] = "FBI",
									["5"] = "Army SF", ["sfa"] = "Army SF", ["���"] = "Army SF",
									["6"] = "�. San-Fierro", ["sf"] = "�. San-Fierro", ["��"] = "�. San-Fierro"
							}

							if arr[res] ~= nil then sampSendChat("/f " .. tag .. " ������� � ������������� ��� �� " .. arr[res] .. "") else sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������� ������ ����� ����������.", -1) end
					end

					if res == "3" then
							if not showdialog(1, "������� ����� ����������", "[1] - Los-Santos Police Department\n[2] - San-Fierro Police Department\n[3] - Las-Venturas Police Departmen\n[4] - Federal Bureau of Investigation\n[5] - San-Fierro Army\n[6] - San-Fierro\n[0] - ����� (������� 0)", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
							res = waitForChooseInDialog(1)
							if not res or res == "" or (tonumber(res) ~= nil and (tonumber(res) < 0 or tonumber(res) > 6)) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end
							if tonumber(res) == 0 then sampSendChat("/f " .. tag .. " ������� �������, ������������.") return end
							local arr = {
									["1"] = "Police LS", ["ls"] = "Police LS", ["lspd"] = "Police LS", ["��"] = "Police LS", ["����"] = "Police LS",
									["2"] = "Police SF", ["sfpd"] = "Police SF", ["����"] = "Police SF",
									["3"] = "Police LV", ["lv"] = "Police LV", ["lvpd"] = "Police LV", ["��"] = "Police LV", ["����"] = "Police LV",
									["4"] = "FBI", ["fbi"] = "FBI", ["���"] = "FBI",
									["5"] = "Army SF", ["sfa"] = "Army SF", ["���"] = "Army SF",
									["6"] = "�. San-Fierro", ["sf"] = "�. San-Fierro", ["��"] = "�. San-Fierro"
							}

							local kv = kvadrat()
							if arr[res] ~= nil then sampSendChat("/f " .. tag .. " ������� ������� � �������� " .. kv .. ", ������������ �� " .. arr[res] .. "") else sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������� ������ ����� ����������.", -1) end
					end

					if res == "4" then
							if not showdialog(1, "���� �����(������� �����)", "\n[0] - �����\n[1] - ����\n[2] - Las-Venturas Police Department\n[3] - Los-Santos Police Department\n[4] - San-Fierro Police Department\n[5] - San-Fierro Army\n[6] - Federal Bureau of Investigation\n[7] - San-Fierro", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
							res = waitForChooseInDialog(1)
							if not res or res == "" or (tonumber(res) ~= nil and (tonumber(res) < 0 or tonumber(res) > 7)) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end
							local kv = kvadrat()
							if tonumber(res) == 0 then sampSendChat("/f " .. tag .. " ������� ��������, ����� ������") return end
							local arr = {
									["1"] = "�� ����", ["lva"] = "�� ����", ["���"] = "�� ����",
									["2"] = "� Police LV", ["lv"] = "� Police LV", ["lvpd"] = "� Police LV", ["��"] = "� Police LV", ["����"] = "� Police LV",
									["3"] = "� Police LS", ["ls"] = "� Police LS", ["lspd"] = "� Police LS", ["��"] = "� Police LS", ["����"] = "� Police LS",
									["4"] = "� Police SF", ["sfpd"] = "� Police SF", ["����"] = "� Police SF",
									["5"] = "� Army SF", ["sfa"] = "� Army SF", ["���"] = "� Army SF",
									["6"] = "� FBI", ["fbi"] = "� FBI", ["���"] = "� FBI",
									["7"] = "� �. San-Fierro", ["sf"] = "� �. San-Fierro", ["��"] = "� �. San-Fierro"
							}


							if arr[res] ~= nil then
									sampSendChat("/f " .. tag .. " ������� �������� � �������� " .. kv .. ", ����� " .. arr[res] .. "")
							else
									sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������� ������ ����� ����������.", -1)
							end
					end

					if res == "5" then
							if not showdialog(1, "������ ���������", "������� �� �-1 �� �-24", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
							res = waitForChooseInDialog(1)
							if not res or res == "" then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end
							local b, n = res:match("([�-�])-(%d+)")
							if b == nil or (tonumber(n) < 1 or tonumber(n) > 24) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� �������.", -1) return end
							local kv = "" .. b .. "-" .. n .. ""
							sampSendChat("/f " .. tag .. " �������� � �������� " .. kv .. " ��������� �� ����")
					end

					if res == "6" then
							if not showdialog(1, "���� �����(������� �����)", "\n[0] - �����\n[1] - ����\n[2] - Las-Venturas Police Department\n[3] - Los-Santos Police Department\n[4] - San-Fierro Police Department\n[5] - San-Fierro Army\n[6] - Federal Bureau of Investigation\n[7] - San-Fierro", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}}������ ��� �������� ����������� ����.", -1) return end
							res = waitForChooseInDialog(1)
							if not res or res == "" or (tonumber(res) ~= nil and (tonumber(res) < 0 or tonumber(res) > 7)) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end
							if tonumber(res) == 0 then sampSendChat("/f " .. tag .. " �������� �������������� � ���������� ����") return end
							local arr = {
									["1"] = "�� ����", ["lva"] = "�� ����", ["���"] = "�� ����",
									["2"] = "� Police LS", ["ls"] = "� Police LS", ["lspd"] = "� Police LS", ["��"] = "� Police LS", ["����"] = "� Police LS",
									["3"] = "� Police SF", ["sfpd"] = "� Police SF", ["����"] = "� Police SF",
									["4"] = "� Police LV", ["lv"] = "� Police LV", ["lvpd"] = "� Police LV", ["��"] = "� Police LV", ["����"] = "� Police LV",
									["5"] = "� FBI", ["fbi"] = "� FBI", ["���"] = "� FBI",
									["6"] = "� Army SF", ["sfa"] = "� Army SF", ["���"] = "� Army SF",
									["7"] = "� �. San-Fierro", ["sf"] = "� �. San-Fierro", ["��"] = "� �. San-Fierro"
							}

							local kv = kvadrat()
							if arr[res] ~= nil then sampSendChat("/f " .. tag .. " �������� �������������� � �������� " .. kv .. " � ���������� ���� " .. arr[res] .. "") else sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������� ������ ����� ����������.", -1)	end
					end

					if res == "7" then
							if not showdialog(1, "������� ����/�������", "\n[0] - ������� �������\n[1] - ������� ����", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
							res = waitForChooseInDialog(1)
							if not res or res == "" or (tonumber(res) ~= nil and (tonumber(res) < 0 or tonumber(res) > 1))then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end
							local kv = kvadrat()
							if res == "0" then sampSendChat("/f " .. tag .. " ������� " .. kv .. " �������. ���������� ������� ��������������") else sampSendChat("/f " .. tag .. " ������� " .. kv .. " ����. ���������� ������� �� ����������") end
					end						
			end
	)
end

function hk_5()
	lua_thread.create(
			function()
					wait(0)
					sampSendChat("������� �����! " .. config_ini.Settings.PlayerRank .. " " .. config_ini.Settings.PlayerFirstName .. " " .. config_ini.Settings.PlayerSecondName .. "")
					wait(1600)
					sampSendChat("���������� ���� ���������")
			end
	)
end

function hk_6()
	lua_thread.create(
			function()
					wait(0)
					local A_Index = 0
					local c = ismegaphone() and "/m" or "/s"
					while true do
							if A_Index == 20 then break end
							local text = sampGetChatString(99 - A_Index)

							local re1 = regex.new("(.*)\\_(.*) ��������?\\: ��������\\! ��� ������ �������� ��������� ��������� �� ����� ����� ������� ����� �� ���������\\!\\!\\!")
							local re2 = regex.new("\\{\\{ ������ (.*)\\_(.*)\\: ��������\\! ��� ������ �������� ��������� ��������� �� ����� ����� ������� ����� �� ���������\\! \\}\\}")
							if re1:match(text) ~= nil or re2:match(text) ~= nil then sampSendChat("" .. c .. " ������ ���������� �� ��������� ���������! ��� �� ������� ����� �� ���������!") return end
							A_Index = A_Index + 1
					-- Aleksandr_Belka �������: ��������! ��� ������ �������� ��������� ��������� �� ����� ����� ������� ����� �� ���������!!!
					-- Aleksandr_Belka ������: ��������! ���������� ������������!!!
					-- {{ ������ Aleksandr_Belka: ��������! ���������� ������������! }}
					end
					sampSendChat("" .. c .. " ��������! ��� ������ �������� ��������� ��������� �� ����� ����� ������� ����� �� ���������!")
			end
	)
end

function hk_7()
	lua_thread.create(
			function()
					wait(0)
					local A_Index = 0
					local c = ismegaphone() and "/m" or "/s"
					local text = isCharInAnyCar(PLAYER_PED) and "��������, ���������� ������������!" or "������!"
					local text2 = isCharInAnyCar(PLAYER_PED) and "��������, ���������� ������������! ��� �� ������� ����� �� ���������!" or "������! �������� ����!"
					while true do
							if A_Index == 20 then break end
							local ch = sampGetChatString(99 - A_Index)
							local re = regex.new("(.*\\_.* ��������?|\\{\\{ ������ .*\\_.*)\\: (��������, ���������� ������������|������)\\!(\\!\\!| \\}\\})")
							--[[ local re1 = regex.new("(.*)\\_(.*) ��������?\\: ��������\\! ���������� ������������\\!\\!\\!")
							local re2 = regex.new("\\{\\{ ������ (.*)\\_(.*)\\: ��������\\! ���������� ������������\\! \\}\\}") ]]
							if re:match(ch) ~= nil then sampSendChat("" .. c .. " " .. text2 .. "") return end
							A_Index = A_Index + 1
					-- Aleksandr_Belka �������: ��������! ���������� ������������!!!
					-- {{ ������ Aleksandr_Belka: ��������! ���������� ������������! }}
					end
					sampSendChat("" .. c .. " " .. text .. "")
			end
	)
end

function hk_8()
	lua_thread.create(
			function()
					wait(0)
					local A_Index = 0
					local c = ismegaphone() and "/m" or "/s"
					if isCharInArea2d(PLAYER_PED, -500, 1100, 900, 2600, false) and not isCharInArea2d(PLAYER_PED, -84, 1606, 464, 2148, false) then
						sampSendChat("" .. c .. " ��������! �� ������ ������� ����������� �������! ��� � �����������, ������� ����� �� ���������!")
					else
						while true do
								if A_Index == 20 then break end
								local text = sampGetChatString(99 - A_Index)
								local re1 = regex.new("(.*)\\_(.*) ��������?\\: ��������\\! �� ���������� �� ���������� ����������\\! ���������� �������� �\\!\\!\\!")
								local re2 = regex.new("\\{\\{ ������ (.*)\\_(.*)\\: ��������\\! �� ���������� �� ���������� ����������\\! ���������� �������� �\\! \\}\\}")
								if re1:match(text) ~= nil or re2:match(text) ~= nil then sampSendChat("" .. c .. " ������ �������� ���������� ����������! ��� �� ������� ����� �� ���������!") return end
								A_Index = A_Index + 1
						-- Aleksandr_Belka �������: ��������! ���������� ������������!!!
						-- {{ ������ Aleksandr_Belka: ��������! ���������� ������������! }}
						end
						sampSendChat("" .. c .. " ��������! �� ���������� �� ���������� ����������! ���������� �������� �!")
					end
			end
	)
end


function hk_9()
	local c = ismegaphone() and "/m" or "/s"
	sampSendChat("" .. c .. " ���� ������! ���� �����, ������� ������, ����� � ���! �������� \"���\"!")
end

function hk_10()
	lua_thread.create(
			function()
					if not showdialog(1, "����� �����", "0-33", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
					local res = waitForChooseInDialog(1)
					if not res or res == "" or (tonumber(res) ~= nil and (tonumber(res) < 0 or tonumber(res) > 33)) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end

					local result, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
					if not result then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ���� ID", -1) return end
					local myclist = clists[sampGetPlayerColor(myid)]
					if myclist == nil then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ����� ������ �����", -1) return end
					if tonumber(res) == myclist then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ���� ������ ���� �����.", -1) return end
					local result, sid = sampGetPlayerSkin(myid)
					if not result then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ID ������ �����", -1) return end
					if ((sid == 287 or sid == 191) and myclist ~= 7 and myclist ~= 0) or (myclist ~= 0 and (sid ~= 287 and sid ~= 191)) then
							sampSendChat("/me ����" .. RP .. " " .. config_ini.UserClist[myclist] .. "")
							wait(1300)
					end

					sampSendChat("/clist " .. res .. "")
					if ((tonumber(res) == 7) and ((sid == 287) or (sid == 191))) or (tonumber(res) == 0) then return end

					wait(1300)
					sampSendChat("/me �����" .. RP .. " " .. config_ini.UserClist[tonumber(res)] .. "")
			end
	)
end

function hk_12()
	lua_thread.create(
			function()
					sampSendChat("/me �������" .. RP .. " ������������� � �������� ����")
					wait(delay)
					isSending = true
					sampSendChat("/do � �������������: Army LV | " .. config_ini.Settings.PlayerFirstName .. " " .. config_ini.Settings.PlayerSecondName .. " | " .. config_ini.Settings.PlayerRank .. " | " .. PlayerU .. "")
					isSending = false
				end
	)
end

function hk_13()
	if not sampIsChatInputActive() and not sampIsDialogActive(-1) and not isSampfuncsConsoleActive() then sampSendChat("/lock") end
end

function hk_20()
	lua_thread.create(function()
		wait(0)
		local A_Index = 0
		while true do
			if A_Index == 30 then break end
			local text = sampGetChatString(99 - A_Index)
			local re1 = regex.new(" \\{8470FF\\}(.*) \\{.*\\}(.*)\\_(.*)\\[(.*)\\]\\{8470FF\\}:  (.*)((.*)������(.*)���|(.*)������(.*)����(.*)���|(.*)������(.*)������(.*)|(.*)������(.*)����(.*)������(.*)|(.*)������(.*)����(.*)����(.*)|(.*)������(.*)����(.*)|(.*)������(.*)����(.*)���(.*)|(.*)������(.*)���(.*)|(.*)������(.*)�����(.*))")
			local zv, _, sname = re1:match(text)
			
			if zv ~= nil then
				local ranksnesokr = {["��.�������"] = "������� �������", ["��.�������"] = "������� �������", ["��.���������"] = "������� ���������", ["��.���������"] = "������� ���������"}
				local pRank = ranksnesokr[zv] ~= nil and ranksnesokr[zv] or zv
				sampSendChat("/f " .. tag .. " ������� �����, ������� " .. pRank .. " " .. sname .. "!")
				return
			end
			A_Index = A_Index + 1
		end
		
		sampSendChat("/f " .. tag .. " ������� �����!")
	end)
end

function hk_21()
		local x, y, z = getCharCoordinates(PLAYER_PED)

		sampSendChat("/f " .. tag .. " SOS " .. kvadrat() .. "")
end

function hk_22()
		lua_thread.create(
				function()
						local res, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
						if not res then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ���� ID", -1) return end
						local myclist = clists[sampGetPlayerColor(myid)]
						if myclist == nil then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ����� ������ �����", -1) return end
						if myclist == 0 then
								sampSendChat("/clist " .. useclist .. "")
								wait(1300)
								local newmyclist = clists[sampGetPlayerColor(myid)]
								if newmyclist == nil then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ����� ������ �����", -1) return end
								if newmyclist ~= tonumber(useclist) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}����� �� ��� �����", -1) return end
								sampSendChat("/me �����" .. RP .. " " .. config_ini.UserClist[newmyclist] .. "")
						else
								sampSendChat("/clist 0")
								wait(1300)
								local newmyclist = clists[sampGetPlayerColor(myid)]
								if newmyclist == nil then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ����� ������ �����", -1) return end
								if newmyclist ~= 0 then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}����� �� ��� ����", -1) return end
								sampSendChat("/me ����" .. RP .. " " .. config_ini.UserClist[myclist] .. "")
						end
				end
		)
end

function hk_23()
		lua_thread.create(
				function()
						wait(0)
						if not showdialog(1, "���� ��������", "�������� �����\n[1] - ����� ��������\n[2] - ���������� �� ���������\n[3] - ������ � ��������� ���������\n[4] - ��������� ��������\n[5] - �������� ��������", "Ok") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� �������� ����������� ����.", -1) return end
						local res = waitForChooseInDialog(1)
						if not res or res == "" or (tonumber(res) ~= nil and (tonumber(res) < 1 or tonumber(res) > 5)) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ��� ������.", -1) return end
						if type(tonumber(res)) ~= "number" or tonumber(res) < 1 or tonumber(res) > 5 then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������� ����� �� 1 �� 4.", -1) return end
						local res = tonumber(res)
						if res == 1 then sampSendChat("/f " .. tag .. " ���� " .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) .. ", ����� �������� �� �� �� LVa.") end
						if res == 2 then sampSendChat("/f " .. tag .. " ���� " .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) .. ", �������� �� �� ���������, ����� ���� �� �� LVa.") end
						if res == 3 then
								local A_Index = 0
								while true do
										if A_Index == 30 then break end
										local text = sampGetChatString(99 - A_Index)
										local sklad = text:match("�� ������� ������: (%d%d%d)%d%d%d%/%d+")
										if sklad ~= nil then sampSendChat("/f " .. tag .. " ���� " .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) .. ", �������� �� �� �� LVa. ���������: " .. sklad .. "/500.") return end
										A_Index = A_Index + 1
								end
								sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������� ���������� ���������� ��������", -1)
						end
						if res == 4 then sampSendChat("/f " .. tag .. " ���� " .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) .. ", ��������� ��������.") end
						if res == 5 then sampSendChat("/f " .. tag .. " ���� " .. select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) .. ", ���������� ��������, ���� �� ����.") end
				end
		)
end

function hk_27()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[1])
					if SB == nil then return end
					if (config_ini.bools[4] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_28()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[2])
					if SB == nil then return end
					if (config_ini.bools[5] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_29()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[3])
					if SB == nil then return end
					if (config_ini.bools[6] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_30()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[4])
					if SB == nil then return end
					if (config_ini.bools[7] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_31()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[5])
					if SB == nil then return end
					if (config_ini.bools[8] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_32()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[6])
					if SB == nil then return end
					if (config_ini.bools[9] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_33()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[7])
					if SB == nil then return end
					if (config_ini.bools[10] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_34()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[8])
					if SB == nil then return end
					if (config_ini.bools[11] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_35()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[9])
					if SB == nil then return end
					if (config_ini.bools[12] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_36()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[10])
					if SB == nil then return end
					if (config_ini.bools[13] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function hk_37()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserBinder[11])
					if SB == nil then return end
					if (config_ini.bools[14] == 1) then
							for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
					else
							sampSetChatInputEnabled(true)
							sampSetChatInputText(SB[1])
					end
			end
	)
end

function cmd_ob(sparams)
	if sparams == "" then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� ��������. ������� /" .. config_ini.Commands[1] .. " [����������] [�������/0 - ������� �������] [1-3]", -1) sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}1 - ��������(�) ������(�); 2 - �������� �� ������; 3 - ��������� ��������� � ���� ��������", -1) return end
	local params = {}
	for v in string.gmatch(sparams, "[^%s]+") do table.insert(params, v) end
	local zzz = {[1] = "��������� ������������", [2] = "��� �������� �������������", [3] = "��� �������� �������������", [4] = "������ �������� �������������", [5] = "���� ��������� �������������", [6] = "����� ��������� �������������", [7] = "���� ��������� �������������", [8] = "������ ��������� �������������", [9] = "������ ��������� �������������", [10] = "������ ��������� �������������"}
	if tonumber(params[1]) == nil or zzz[tonumber(params[1])] == nil then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� ���������� ���������.", -1) return end
	local kol = tonumber(params[1])
	if params[2] == "" then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� �������.", -1) return end
	local b, n = params[2]:match("([�-�])-(%d+)")
	if (b == nil or (tonumber(n) < 1 or tonumber(n) > 24)) and (tonumber(params[2]) ~= 0) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� �������.", -1) return end
	local kv = tonumber(params[2]) == 0 and kvadrat() or "" .. b .. "-" .. n .. ""
	if tonumber(params[3]) == nil or (tonumber(params[3]) < 1 or tonumber(params[3]) > 3) then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� �������� �3.", -1) return end

	local obdokl = "/r " .. tag .. " " .. zzz[kol] ..  ""
	local obdokl2 = " � �������� " .. kv .. "."
	local obdokl3
	if tonumber(params[3]) == 2 then obdokl3 = "" elseif tonumber(params[3]) == 3 or kol == 1 then obdokl3 = " �������� ������" elseif tonumber(params[3]) == 1 and kol > 1 then obdokl3 = " ��������� �������" end
	local dokl = obdokl .. obdokl2 .. obdokl3
	sampSendChat(dokl)
end

function cmd_sopr(sparams)
	if sparams == "" then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}}�������� ��������. ������� /" .. config_ini.Commands[2] .. " [����� ����������/0 - �����]", -1) return end
	local x, y, z = getCharCoordinates(PLAYER_PED)
	local zone = calculateZone(x, y, z)
	local arr = {
			["1"] = "Police LS", ["ls"] = "Police LS", ["lspd"] = "Police LS", ["��"] = "Police LS", ["����"] = "Police LS",
			["2"] = "Police SF", ["sfpd"] = "Police SF", ["����"] = "Police SF",
			["3"] = "Police LV", ["lv"] = "Police LV", ["lvpd"] = "Police LV", ["��"] = "Police LV", ["����"] = "Police LV",
			["4"] = "FBI", ["fbi"] = "FBI", ["���"] = "FBI",
			["5"] = "Army SF", ["sfa"] = "Army SF", ["���"] = "Army SF",
			["6"] = "�. San-Fierro", ["sf"] = "�. San-Fierro", ["��"] = "�. San-Fierro"
	}

	if arr[sparams] == nil and sparams ~= "0" then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������� ������ ����� ����������", -1) return end
	if zone == "Restricted Area" then
			if sparams == "0" then sampSendChat("/f " .. tag .. " ������� � ������������� ���") return end
			sampSendChat("/f " .. tag .. " ������� � ������������� ������ ��� �� " .. arr[sparams] .. "")
	else
			if sparams == "0" then sampSendChat("/f " .. tag .. " ������� �������, ������������") return end
			sampSendChat("/f " .. tag .. " ������� ������� � �������� " .. kvadrat() .. ", ������������ �� " .. arr[sparams] .. "")
	end
end

function cmd_kv(sparams)
	if sparams == "" or (sparams ~= "0" and sparams ~= "1") then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� ��������. ������� /" .. config_ini.Commands[6] .. " [0 - �������/1 - ����]", -1) return end
	local d = sparams == "0" and "�������. ���������� ������� ��������������" or "����. ���������� ������� �� ����������"
	sampSendChat("/f " .. tag .. " ������� " .. kvadrat() .. " " .. d .. "")
end

function cmd_cl(sparams)
	lua_thread.create(
			function()
					wait(0)
					if tonumber(sparams) ~= nil and tonumber(sparams) >= 0 and tonumber(sparams) <= 33 then
							local res, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
							if not res then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ���� ID", -1) return end
							local myclist = clists[sampGetPlayerColor(myid)]
							if myclist == nil then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ����� ������ �����", -1) return end
							if sparams == myclist then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ���� ������ ���� �����.", -1) return end
							local res, sid = sampGetPlayerSkin(myid)
							if not res then sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�� ������� ������ ID ������ �����", -1) return end
							if ((sid == 287 or sid == 191) and myclist ~= 7 and myclist ~= 0) or (myclist ~= 0 and (sid ~= 287 and sid ~= 191)) then
									sampSendChat("/me ����" .. RP .. " " .. config_ini.UserClist[myclist] .. "")
									wait(1300)
							end

							sampSendChat("/clist " .. sparams .. "")
							if ((tonumber(sparams) == 7) and ((sid == 287) or (sid == 191))) or (tonumber(sparams) == 0) then return end

							wait(1300)
							sampSendChat("/me �����" .. RP .. " " .. config_ini.UserClist[tonumber(sparams)] .. "")
					else
							sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}�������� ��������. ������� /" .. config_ini.Commands[14] .. " [0-33]", -1)
					end
			end
	)
end

function cmd_u1()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[1])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u2()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[2])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u3()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[3])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u4()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[4])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u5()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[5])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u6()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[6])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u7()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[7])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u8()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[8])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u9()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[9])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u10()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[10])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u11()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[11])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u12()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[12])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u13()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[13])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u14()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[14])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u15()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[15])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u16()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[16])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u17()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[17])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end

function cmd_u18()
	lua_thread.create(
			function()
					wait(0)
					local SB = formatbind(config_ini.UserCBinder[18])
					if SB == nil then return end
					for k, v in ipairs(SB) do sampSendChat(v) wait(delay) end
			end
	)
end


function formatbind(str)
	local str = tostring(str)
	local rarr = {}
	if str:match("@Hour@") then str = str:gsub("@Hour@", os.date("%H")) end
	if str:match("@Min@") then str = str:gsub("@Min@", os.date("%M")) end
	if str:match("@Sec@") then str = str:gsub("@Sec@", os.date("%S")) end
	if str:match("@Date@") then str = str:gsub("@Date@", os.date("%d.%m.%Y")) end
	if str:match("@KV@") then str = str:gsub("@KV@", kvadrat()) end
	if str:match("@MyID@") then str = str:gsub("@MyID@", tostring(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))) end
	if str:match("@clist@") then str = str:gsub("@clist@", config_ini.UserClist[clists[sampGetPlayerColor(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)))]]) end
	if str:match("@enter@") then str = str:gsub("@enter@", "\n") end
	for v in str:gmatch('[^\n]+') do table.insert(rarr, v) end
	if rarr[1] == nil then rarr[1] = str end
	return rarr
end

function cmd_s()
	lua_thread.create(function()
		for k, v in ipairs(config_ini.HotKey) do local hk = makeHotKey(k) if hk[1] ~= 0 then rkeys.unRegisterHotKey(hk) end end
		for k, v in ipairs(config_ini.Commands) do sampUnregisterChatCommand(v) end
		for k, v in ipairs(config_ini.UserCBinderC) do sampUnregisterChatCommand(v) end
		piearr.action = 0
		piearr.pie_mode.v = false -- ����� PieMenu
		piearr.pie_keyid = 0
		piearr.pie_elements = {}

		suspendkeys = 1
		guis.mainw.v = not guis.mainw.v
	end)
end

function prepare()
	lua_thread.create(function()
		while true do wait(0) local x, y, z = getActiveCameraCoordinates() if (x ~= 1093 and x ~= -1826.8193359375) or (y ~= -2036 and y ~= 1074.6199951172) or (z ~= 90 and z ~= 191.18589782715) then break end end
		local result, myid = sampGetPlayerIdByCharHandle(PLAYER_PED)
		sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}���� ���������� ������� � ������. �� ���������� ������� �������� ���� ���.", -1)
		rkeys.registerHotKey(makeHotKey(13), true, function() if sampIsChatInputActive() or sampIsDialogActive(-1) or isSampfuncsConsoleActive() then return end hk_13() end)
		local nick = sampGetPlayerNickname(myid)
		local f, s = nick:match("(.*)%_(.*)")
		config_ini.UserClist[21] = config_ini.Settings.pstatus == 2 and "������� �����-����� ����� ��������� ����� ���λ" or config_ini.Settings.pstatus == 1 and "������� �����-����� ����� ���λ" or "������� ���λ"

		if config_ini.Settings.PlayerFirstName == "" or config_ini.Settings.PlayerSecondName == "" or config_ini.Settings.PlayerRank == "" then
			wait(delay)
			sampSendChat("/stats")
			while not sampIsDialogActive() do wait(0) end
			local text = sampGetDialogText()
			wait(100)
			sampCloseCurrentDialogWithButton(0) sampCloseCurrentDialogWithButton(0) sampCloseCurrentDialogWithButton(0)
			for v in text:gmatch('[^\n]+') do
				local fn, sn = v:match("���	(%a+)_(%a+)")
				if fn ~= nil then
							config_ini.Settings.PlayerFirstName = u8:decode(fn)
							guibuffers.settings.fname.v = u8(fn)
							config_ini.Settings.PlayerSecondName = u8:decode(sn)
							guibuffers.settings.sname.v = u8(sn)
					end
	
				local rank = v:match("����	(.*) %[%d+%]")
				if rank ~= nil then
					local ranksnesokr = {["��.�������"] = "������� �������", ["��.�������"] = "������� �������", ["��.���������"] = "������� ���������", ["��.���������"] = "������� ���������"}
							local pRank = ranksnesokr[rank] ~= nil and ranksnesokr[rank] or rank
					config_ini.Settings.PlayerRank = u8:decode(pRank)
							guibuffers.settings.rank.v = u8(pRank)
				end
			end
			needtosave = true
		end

		sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}���������� ���������. ����� �������� ���� ������� - /show.", -1)
		sampRegisterChatCommand("show", cmd_s)
		while not isSampAvailable() do wait(0) end
    	while sampGetCurrentServerName() == 'SA-MP' do wait(0) end
   		local users = getTableUsersByUrl(site) -- ����� ������� ������.
    	local _, myid = sampGetPlayerIdByCharHandle(playerPed) -- ����� ���� ��.
    	if not isAvailableUser(users, sampGetPlayerNickname(myid)) then -- ���� ���� ��� ������ ��� � ������ ���� ����� ����, ��..
        	sampAddChatMessage("{8f0ce2}[���]: {FFFAFA}������ ������������. ���������� � �����������.", -1)
        	thisScript():unload() -- ��������� ������.
   		 end
		preparecomplete = true
	end)
end

function string.split(str, delim, plain) -- bh FYP
	local tokens, pos, plain = {}, 1, not (plain == false) --[[ delimiter is plain text by default ]]
	repeat
		local npos, epos = string.find(str, delim, pos, plain)
		table.insert(tokens, string.sub(str, pos, npos and npos - 1))
		pos = epos and epos + 1
	until not pos
	return tokens
 end

function imgui.Hotkey(name, numkey, width)
	imgui.BeginChild(name, imgui.ImVec2(width, 30), true)
	imgui.PushItemWidth(width)

	local hstr = ""
	for _, v in ipairs(string.split(config_ini.HotKey[numkey], ", ")) do
			if v ~= "0" then
					hstr = hstr == "" and tostring(vkeys.id_to_name(tonumber(v))) or "" .. hstr .. " + " .. tostring(vkeys.id_to_name(tonumber(v))) .. ""
			end
	end
	hstr = (hstr == "" or hstr == "nil") and "���" or hstr

	imgui.Text(u8(hstr))
	imgui.PopItemWidth()
	imgui.EndChild()
	if imgui.IsItemClicked() then
			lua_thread.create(
					function()
						local curkeys = ""
						local tbool = false
						while true do
								wait(0)
								if not tbool then
										for k, v in pairs(vkeys) do
												sv = tostring(v)
												if isKeyDown(v) and (v == vkeys.VK_MENU or v == vkeys.VK_CONTROL or v == vkeys.VK_SHIFT or v == vkeys.VK_LMENU or v == vkeys.VK_RMENU or v == vkeys.VK_RCONTROL or v == vkeys.VK_LCONTROL or v == vkeys.VK_LSHIFT or v == vkeys.VK_RSHIFT) then
														if v ~= vkeys.VK_MENU and v ~= vkeys.VK_CONTROL and v ~= vkeys.VK_SHIFT then
																if not curkeys:find(sv) then
																		curkeys = tostring(curkeys):len() == 0 and sv or curkeys .. " " .. sv
																end
														end
												end
										end

										for k, v in pairs(vkeys) do
												sv = tostring(v)
												if isKeyDown(v) and (v ~= vkeys.VK_MENU and v ~= vkeys.VK_CONTROL and v ~= vkeys.VK_SHIFT and v ~= vkeys.VK_LMENU and v ~= vkeys.VK_RMENU and v ~= vkeys.VK_RCONTROL and v ~= vkeys.VK_LCONTROL and v ~= vkeys.VK_LSHIFT and v ~=vkeys. VK_RSHIFT) then
														 if not curkeys:find(sv) then
																curkeys = tostring(curkeys):len() == 0 and sv or curkeys .. " " .. sv
																tbool = true
														end
												end
										end
								else
										tbool2 = false
										for k, v in pairs(vkeys) do
												sv = tostring(v)
												if isKeyDown(v) and (v ~= vkeys.VK_MENU and v ~= vkeys.VK_CONTROL and v ~= vkeys.VK_SHIFT and v ~= vkeys.VK_LMENU and v ~= vkeys.VK_RMENU and v ~= vkeys.VK_RCONTROL and v ~= vkeys.VK_LCONTROL and v ~= vkeys.VK_LSHIFT and v ~=vkeys. VK_RSHIFT) then
														tbool2 = true
														if not curkeys:find(sv) then
																curkeys = tostring(curkeys):len() == 0 and sv or curkeys .. " " .. sv
														end
												end
										end

										if not tbool2 then break end
								end
						end

						local keys = ""
						if tonumber(curkeys) == vkeys.VK_BACK then
								config_ini.HotKey[numkey] = "0"
						else
								local tNames = string.split(curkeys, " ")
								for _, v in ipairs(tNames) do
										local val = (tonumber(v) == 162 or tonumber(v) == 163) and 17 or (tonumber(v) == 160 or tonumber(v) == 161) and 16 or (tonumber(v) == 164 or tonumber(v) == 165) and 18 or tonumber(v)
										keys = keys == "" and val or "" .. keys .. ", " .. val .. ""
								end
						end

						config_ini.HotKey[numkey] = keys
					end
			)
	end
end

function makeHotKey(numkey)
	local rett = {}
	for _, v in ipairs(string.split(config_ini.HotKey[numkey], ", ")) do
			if tonumber(v) ~= 0 then table.insert(rett, tonumber(v)) end
	end
	return rett
end

function showdialog(style, title, text, button1, button2)
	if isDialogActiveNow then return false end
	sampShowDialog(9048, title, text, button1, button2, style)
	 isDialogActiveNow = true
	return true
end

function waitForChooseInDialog(style)
	if style ~= 0 and style ~= 1 and style ~= 2 then return nil end
	while sampIsDialogActive(9048) do wait(100) end
	local result, button, list, input = sampHasDialogRespond(9048)
	returnWalue = style == 1 and input or list
	isDialogActiveNow = false
	if style == 0 or button == 0 then return nil end
	return returnWalue
end


function imgui.TextColoredRGB(text)
	local style = imgui.GetStyle()
	local colors = style.Colors
	local ImVec4 = imgui.ImVec4

	local explode_argb = function(argb)
			local a = bit.band(bit.rshift(argb, 24), 0xFF)
			local r = bit.band(bit.rshift(argb, 16), 0xFF)
			local g = bit.band(bit.rshift(argb, 8), 0xFF)
			local b = bit.band(argb, 0xFF)
			return a, r, g, b
	end

	local getcolor = function(color)
			if color:sub(1, 6):upper() == 'SSSSSS' then
					local r, g, b = colors[1].x, colors[1].y, colors[1].z
					local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
					return ImVec4(r, g, b, a / 255)
			end

			local color = type(color) == 'string' and tonumber(color, 16) or color
			if type(color) ~= 'number' then return end
			local r, g, b, a = explode_argb(color)
			return imgui.ImColor(r, g, b, a):GetVec4()
	end

	local render_text = function(text_)
			  for w in text_:gmatch('[^\r\n]+') do
						 local text, colors_, m = {}, {}, 1
					  w = w:gsub('{(......)}', '{%1FF}')
					  while w:find('{........}') do
							  local n, k = w:find('{........}')
							  local color = getcolor(w:sub(n + 1, k - 1))
							  if color then
									  text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
									  colors_[#colors_ + 1] = color
									  m = n
							  end

							  w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
					  end

					  if text[0] then
							  for i = 0, #text do
									  imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
										if imgui.IsItemClicked() then	if SelectedRow == A_Index then ChoosenRow = SelectedRow	else	SelectedRow = A_Index	end	end
										imgui.SameLine(nil, 0)
							  end

								imgui.NewLine()
					  else
								imgui.Text(u8(w))
								if imgui.IsItemClicked() then	if SelectedRow == A_Index then ChoosenRow = SelectedRow	else	SelectedRow = A_Index	end	end
						end
			  end
	end
	render_text(text)
end


function kvadrat()
    local KV = {
        [1] = "�",
        [2] = "�",
        [3] = "�",
        [4] = "�",
        [5] = "�",
        [6] = "�",
        [7] = "�",
        [8] = "�",
        [9] = "�",
        [10] = "�",
        [11] = "�",
        [12] = "�",
        [13] = "�",
        [14] = "�",
        [15] = "�",
        [16] = "�",
        [17] = "�",
        [18] = "�",
        [19] = "�",
        [20] = "�",
        [21] = "�",
        [22] = "�",
        [23] = "�",
        [24] = "�",
    }
    local X, Y, Z = getCharCoordinates(playerPed)
    X = math.ceil((X + 3000) / 250)
    Y = math.ceil((Y * - 1 + 3000) / 250)
    Y = KV[Y]
    local KVX = (Y.."-"..X)
    return KVX
end

function drawPieSub(v)
  if pie.BeginPieMenu(u8(v.name)) then
    for i, l in ipairs(v.next) do
      if l.next == nil then
        if pie.PieMenuItem(u8(l.name)) then l.action() end
      elseif type(l.next) == 'table' then
        drawPieSub(l)
      end
    end
    pie.EndPieMenu()
  end
end


function ismegaphone()
	if isCharOnFoot(PLAYER_PED) then return false end
	local carhandle = storeCarCharIsInNoSave(PLAYER_PED)-- ��������� handle ����������
	if carhandle < 0 then return false end
	local cid = select(2, sampGetVehicleIdByCarHandle(carhandle))
	if cIDs[cid] ~= nil and (cIDs[cid] == "����� ��" or cIDs[cid] == "����� ��" or cIDs[cid] == "������� �����������" or cIDs[cid] == "������� ��" or cIDs[cid] == "������� ��" or cIDs[cid] == "������� ��" or cIDs[cid] == "FBI" or cIDs[cid] == "���� ��" or cIDs[cid] == "�.�.�.�.") then return true end
	return false
end

function sampGetPlayerSkin(id)
    if not id or not sampIsPlayerConnected(tonumber(id)) and not tonumber(id) == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) then return false end -- ��������� ��������
    local isLocalPlayer = tonumber(id) == select(2, sampGetPlayerIdByCharHandle(PLAYER_PED)) -- ���������, �������� �� ���� ��������� �������
    local result, handle = sampGetCharHandleBySampPlayerId(tonumber(id)) -- �������� CharHandle �� SAMP-ID
    local result, handle = sampGetCharHandleBySampPlayerId(tonumber(id)) -- �������� CharHandle �� SAMP-ID
    if not result and not isLocalPlayer then return false end -- ���������, ������� �� ��� CharHandle
    local skinid = getCharModel(isLocalPlayer and PLAYER_PED or handle) -- �������� ���� ������ CharHandle
    if skinid < 0 or skinid > 311 then return false end -- ��������� ���������� ������ �����, ������ ID ������������ ������ SAMP
    return true, skinid -- ���������� ������ � ID �����
end


function calculateZone(x, y, z)
    local streets = {
	{"Restricted Area", -91.586, 1655.050, -50.000, 421.234, 2123.010, 250.000},
	{"Restricted Area", 117.000000,2091.000000,-500.0,436.000000,2145.000000,500.0},
	{"Restricted Area", -58.000000,1584.000000,-500,436.000000,1655.000000,500},
	{"Restricted Area", 83.000000,1570.000000,-500,380.000000,1575.000000,500},
	{"Restricted Area", 161.000000,1546.000000,-500,409.000000,1664.000000,500},
	{"Restricted Area", 84.000000,1577.000000,-500,226.000000,1637.000000,500},
	{"Restricted Area", 376.000000,1695.000000,-500,483.000000,1699.000000,500},
	{"Restricted Area", 408.000000,1691.000000,-500,518.000000,1775.000000,500},
	{"Restricted Area", 418.000000,1733.000000,-500,471.000000,2151.000000,500},
	{"Restricted Area", 476.000000,1746.000000,-500,579.000000,1877.000000,500},
	{"Restricted Area", 457.000000,1882.000000,-500,597.000000,1993.000000,500},
	{"Restricted Area", 436.000000,1985.000000,-500,552.000000,2133.000000,500},
	{"Avispa Country Club", -2667.810, -302.135, -28.831, -2646.400, -262.320, 71.169},
    {"Easter Bay Airport", -1315.420, -405.388, 15.406, -1264.400, -209.543, 25.406},
    {"Avispa Country Club", -2550.040, -355.493, 0.000, -2470.040, -318.493, 39.700},
    {"Easter Bay Airport", -1490.330, -209.543, 15.406, -1264.400, -148.388, 25.406},
    {"Garcia", -2395.140, -222.589, -5.3, -2354.090, -204.792, 200.000},
    {"Shady Cabin", -1632.830, -2263.440, -3.0, -1601.330, -2231.790, 200.000},
    {"East Los Santos", 2381.680, -1494.030, -89.084, 2421.030, -1454.350, 110.916},
    {"LVA Freight Depot", 1236.630, 1163.410, -89.084, 1277.050, 1203.280, 110.916},
    {"Blackfield Intersection", 1277.050, 1044.690, -89.084, 1315.350, 1087.630, 110.916},
    {"Avispa Country Club", -2470.040, -355.493, 0.000, -2270.040, -318.493, 46.100},
    {"Temple", 1252.330, -926.999, -89.084, 1357.000, -910.170, 110.916},
    {"Unity Station", 1692.620, -1971.800, -20.492, 1812.620, -1932.800, 79.508},
    {"LVA Freight Depot", 1315.350, 1044.690, -89.084, 1375.600, 1087.630, 110.916},
    {"Los Flores", 2581.730, -1454.350, -89.084, 2632.830, -1393.420, 110.916},
    {"Starfish Casino", 2437.390, 1858.100, -39.084, 2495.090, 1970.850, 60.916},
    {"Easter Bay Chemicals", -1132.820, -787.391, 0.000, -956.476, -768.027, 200.000},
    {"Downtown Los Santos", 1370.850, -1170.870, -89.084, 1463.900, -1130.850, 110.916},
    {"Esplanade East", -1620.300, 1176.520, -4.5, -1580.010, 1274.260, 200.000},
    {"Market Station", 787.461, -1410.930, -34.126, 866.009, -1310.210, 65.874},
    {"Linden Station", 2811.250, 1229.590, -39.594, 2861.250, 1407.590, 60.406},
    {"Montgomery Intersection", 1582.440, 347.457, 0.000, 1664.620, 401.750, 200.000},
    {"Frederick Bridge", 2759.250, 296.501, 0.000, 2774.250, 594.757, 200.000},
    {"Yellow Bell Station", 1377.480, 2600.430, -21.926, 1492.450, 2687.360, 78.074},
    {"Downtown Los Santos", 1507.510, -1385.210, 110.916, 1582.550, -1325.310, 335.916},
    {"Jefferson", 2185.330, -1210.740, -89.084, 2281.450, -1154.590, 110.916},
    {"Mulholland", 1318.130, -910.170, -89.084, 1357.000, -768.027, 110.916},
    {"Avispa Country Club", -2361.510, -417.199, 0.000, -2270.040, -355.493, 200.000},
    {"Jefferson", 1996.910, -1449.670, -89.084, 2056.860, -1350.720, 110.916},
    {"Julius Thruway West", 1236.630, 2142.860, -89.084, 1297.470, 2243.230, 110.916},
    {"Jefferson", 2124.660, -1494.030, -89.084, 2266.210, -1449.670, 110.916},
    {"Julius Thruway North", 1848.400, 2478.490, -89.084, 1938.800, 2553.490, 110.916},
    {"Rodeo", 422.680, -1570.200, -89.084, 466.223, -1406.050, 110.916},
    {"Cranberry Station", -2007.830, 56.306, 0.000, -1922.000, 224.782, 100.000},
    {"Downtown Los Santos", 1391.050, -1026.330, -89.084, 1463.900, -926.999, 110.916},
    {"Redsands West", 1704.590, 2243.230, -89.084, 1777.390, 2342.830, 110.916},
    {"Little Mexico", 1758.900, -1722.260, -89.084, 1812.620, -1577.590, 110.916},
    {"Blackfield Intersection", 1375.600, 823.228, -89.084, 1457.390, 919.447, 110.916},
    {"Los Santos International", 1974.630, -2394.330, -39.084, 2089.000, -2256.590, 60.916},
    {"Beacon Hill", -399.633, -1075.520, -1.489, -319.033, -977.516, 198.511},
    {"Rodeo", 334.503, -1501.950, -89.084, 422.680, -1406.050, 110.916},
    {"Richman", 225.165, -1369.620, -89.084, 334.503, -1292.070, 110.916},
    {"Downtown Los Santos", 1724.760, -1250.900, -89.084, 1812.620, -1150.870, 110.916},
    {"The Strip", 2027.400, 1703.230, -89.084, 2137.400, 1783.230, 110.916},
    {"Downtown Los Santos", 1378.330, -1130.850, -89.084, 1463.900, -1026.330, 110.916},
    {"Blackfield Intersection", 1197.390, 1044.690, -89.084, 1277.050, 1163.390, 110.916},
    {"Conference Center", 1073.220, -1842.270, -89.084, 1323.900, -1804.210, 110.916},
    {"Montgomery", 1451.400, 347.457, -6.1, 1582.440, 420.802, 200.000},
    {"Foster Valley", -2270.040, -430.276, -1.2, -2178.690, -324.114, 200.000},
    {"Blackfield Chapel", 1325.600, 596.349, -89.084, 1375.600, 795.010, 110.916},
    {"Los Santos International", 2051.630, -2597.260, -39.084, 2152.450, -2394.330, 60.916},
    {"Mulholland", 1096.470, -910.170, -89.084, 1169.130, -768.027, 110.916},
    {"Yellow Bell Gol Course", 1457.460, 2723.230, -89.084, 1534.560, 2863.230, 110.916},
    {"The Strip", 2027.400, 1783.230, -89.084, 2162.390, 1863.230, 110.916},
    {"Jefferson", 2056.860, -1210.740, -89.084, 2185.330, -1126.320, 110.916},
    {"Mulholland", 952.604, -937.184, -89.084, 1096.470, -860.619, 110.916},
    {"Aldea Malvada", -1372.140, 2498.520, 0.000, -1277.590, 2615.350, 200.000},
    {"Las Colinas", 2126.860, -1126.320, -89.084, 2185.330, -934.489, 110.916},
    {"Las Colinas", 1994.330, -1100.820, -89.084, 2056.860, -920.815, 110.916},
    {"Richman", 647.557, -954.662, -89.084, 768.694, -860.619, 110.916},
    {"LVA Freight Depot", 1277.050, 1087.630, -89.084, 1375.600, 1203.280, 110.916},
    {"Julius Thruway North", 1377.390, 2433.230, -89.084, 1534.560, 2507.230, 110.916},
    {"Willowfield", 2201.820, -2095.000, -89.084, 2324.000, -1989.900, 110.916},
    {"Julius Thruway North", 1704.590, 2342.830, -89.084, 1848.400, 2433.230, 110.916},
    {"Temple", 1252.330, -1130.850, -89.084, 1378.330, -1026.330, 110.916},
    {"Little Mexico", 1701.900, -1842.270, -89.084, 1812.620, -1722.260, 110.916},
    {"Queens", -2411.220, 373.539, 0.000, -2253.540, 458.411, 200.000},
    {"Las Venturas Airport", 1515.810, 1586.400, -12.500, 1729.950, 1714.560, 87.500},
    {"Richman", 225.165, -1292.070, -89.084, 466.223, -1235.070, 110.916},
    {"Temple", 1252.330, -1026.330, -89.084, 1391.050, -926.999, 110.916},
    {"East Los Santos", 2266.260, -1494.030, -89.084, 2381.680, -1372.040, 110.916},
    {"Julius Thruway East", 2623.180, 943.235, -89.084, 2749.900, 1055.960, 110.916},
    {"Willowfield", 2541.700, -1941.400, -89.084, 2703.580, -1852.870, 110.916},
    {"Las Colinas", 2056.860, -1126.320, -89.084, 2126.860, -920.815, 110.916},
    {"Julius Thruway East", 2625.160, 2202.760, -89.084, 2685.160, 2442.550, 110.916},
    {"Rodeo", 225.165, -1501.950, -89.084, 334.503, -1369.620, 110.916},
    {"Las Brujas", -365.167, 2123.010, -3.0, -208.570, 2217.680, 200.000},
    {"Julius Thruway East", 2536.430, 2442.550, -89.084, 2685.160, 2542.550, 110.916},
    {"Rodeo", 334.503, -1406.050, -89.084, 466.223, -1292.070, 110.916},
    {"Vinewood", 647.557, -1227.280, -89.084, 787.461, -1118.280, 110.916},
    {"Rodeo", 422.680, -1684.650, -89.084, 558.099, -1570.200, 110.916},
    {"Julius Thruway North", 2498.210, 2542.550, -89.084, 2685.160, 2626.550, 110.916},
    {"Downtown Los Santos", 1724.760, -1430.870, -89.084, 1812.620, -1250.900, 110.916},
    {"Rodeo", 225.165, -1684.650, -89.084, 312.803, -1501.950, 110.916},
    {"Jefferson", 2056.860, -1449.670, -89.084, 2266.210, -1372.040, 110.916},
    {"Hampton Barns", 603.035, 264.312, 0.000, 761.994, 366.572, 200.000},
    {"Temple", 1096.470, -1130.840, -89.084, 1252.330, -1026.330, 110.916},
    {"Kincaid Bridge", -1087.930, 855.370, -89.084, -961.950, 986.281, 110.916},
    {"Verona Beach", 1046.150, -1722.260, -89.084, 1161.520, -1577.590, 110.916},
    {"Commerce", 1323.900, -1722.260, -89.084, 1440.900, -1577.590, 110.916},
    {"Mulholland", 1357.000, -926.999, -89.084, 1463.900, -768.027, 110.916},
    {"Rodeo", 466.223, -1570.200, -89.084, 558.099, -1385.070, 110.916},
    {"Mulholland", 911.802, -860.619, -89.084, 1096.470, -768.027, 110.916},
    {"Mulholland", 768.694, -954.662, -89.084, 952.604, -860.619, 110.916},
    {"Julius Thruway South", 2377.390, 788.894, -89.084, 2537.390, 897.901, 110.916},
    {"Idlewood", 1812.620, -1852.870, -89.084, 1971.660, -1742.310, 110.916},
    {"Ocean Docks", 2089.000, -2394.330, -89.084, 2201.820, -2235.840, 110.916},
    {"Commerce", 1370.850, -1577.590, -89.084, 1463.900, -1384.950, 110.916},
    {"Julius Thruway North", 2121.400, 2508.230, -89.084, 2237.400, 2663.170, 110.916},
    {"Temple", 1096.470, -1026.330, -89.084, 1252.330, -910.170, 110.916},
    {"Glen Park", 1812.620, -1449.670, -89.084, 1996.910, -1350.720, 110.916},
    {"Easter Bay Airport", -1242.980, -50.096, 0.000, -1213.910, 578.396, 200.000},
    {"Martin Bridge", -222.179, 293.324, 0.000, -122.126, 476.465, 200.000},
    {"The Strip", 2106.700, 1863.230, -89.084, 2162.390, 2202.760, 110.916},
    {"Willowfield", 2541.700, -2059.230, -89.084, 2703.580, -1941.400, 110.916},
    {"Marina", 807.922, -1577.590, -89.084, 926.922, -1416.250, 110.916},
    {"Las Venturas Airport", 1457.370, 1143.210, -89.084, 1777.400, 1203.280, 110.916},
    {"Idlewood", 1812.620, -1742.310, -89.084, 1951.660, -1602.310, 110.916},
    {"Esplanade East", -1580.010, 1025.980, -6.1, -1499.890, 1274.260, 200.000},
    {"Downtown Los Santos", 1370.850, -1384.950, -89.084, 1463.900, -1170.870, 110.916},
    {"The Mako Span", 1664.620, 401.750, 0.000, 1785.140, 567.203, 200.000},
    {"Rodeo", 312.803, -1684.650, -89.084, 422.680, -1501.950, 110.916},
    {"Pershing Square", 1440.900, -1722.260, -89.084, 1583.500, -1577.590, 110.916},
    {"Mulholland", 687.802, -860.619, -89.084, 911.802, -768.027, 110.916},
    {"Gant Bridge", -2741.070, 1490.470, -6.1, -2616.400, 1659.680, 200.000},
    {"Las Colinas", 2185.330, -1154.590, -89.084, 2281.450, -934.489, 110.916},
    {"Mulholland", 1169.130, -910.170, -89.084, 1318.130, -768.027, 110.916},
    {"Julius Thruway North", 1938.800, 2508.230, -89.084, 2121.400, 2624.230, 110.916},
    {"Commerce", 1667.960, -1577.590, -89.084, 1812.620, -1430.870, 110.916},
    {"Rodeo", 72.648, -1544.170, -89.084, 225.165, -1404.970, 110.916},
    {"Roca Escalante", 2536.430, 2202.760, -89.084, 2625.160, 2442.550, 110.916},
    {"Rodeo", 72.648, -1684.650, -89.084, 225.165, -1544.170, 110.916},
    {"Market", 952.663, -1310.210, -89.084, 1072.660, -1130.850, 110.916},
    {"Las Colinas", 2632.740, -1135.040, -89.084, 2747.740, -945.035, 110.916},
    {"Mulholland", 861.085, -674.885, -89.084, 1156.550, -600.896, 110.916},
    {"King's", -2253.540, 373.539, -9.1, -1993.280, 458.411, 200.000},
    {"Redsands East", 1848.400, 2342.830, -89.084, 2011.940, 2478.490, 110.916},
    {"Downtown", -1580.010, 744.267, -6.1, -1499.890, 1025.980, 200.000},
    {"Conference Center", 1046.150, -1804.210, -89.084, 1323.900, -1722.260, 110.916},
    {"Richman", 647.557, -1118.280, -89.084, 787.461, -954.662, 110.916},
    {"Ocean Flats", -2994.490, 277.411, -9.1, -2867.850, 458.411, 200.000},
    {"Greenglass College", 964.391, 930.890, -89.084, 1166.530, 1044.690, 110.916},
    {"Glen Park", 1812.620, -1100.820, -89.084, 1994.330, -973.380, 110.916},
    {"LVA Freight Depot", 1375.600, 919.447, -89.084, 1457.370, 1203.280, 110.916},
    {"Regular Tom", -405.770, 1712.860, -3.0, -276.719, 1892.750, 200.000},
    {"Verona Beach", 1161.520, -1722.260, -89.084, 1323.900, -1577.590, 110.916},
    {"East Los Santos", 2281.450, -1372.040, -89.084, 2381.680, -1135.040, 110.916},
    {"Caligula's Palace", 2137.400, 1703.230, -89.084, 2437.390, 1783.230, 110.916},
    {"Idlewood", 1951.660, -1742.310, -89.084, 2124.660, -1602.310, 110.916},
    {"Pilgrim", 2624.400, 1383.230, -89.084, 2685.160, 1783.230, 110.916},
    {"Idlewood", 2124.660, -1742.310, -89.084, 2222.560, -1494.030, 110.916},
    {"Queens", -2533.040, 458.411, 0.000, -2329.310, 578.396, 200.000},
    {"Downtown", -1871.720, 1176.420, -4.5, -1620.300, 1274.260, 200.000},
    {"Commerce", 1583.500, -1722.260, -89.084, 1758.900, -1577.590, 110.916},
    {"East Los Santos", 2381.680, -1454.350, -89.084, 2462.130, -1135.040, 110.916},
    {"Marina", 647.712, -1577.590, -89.084, 807.922, -1416.250, 110.916},
    {"Richman", 72.648, -1404.970, -89.084, 225.165, -1235.070, 110.916},
    {"Vinewood", 647.712, -1416.250, -89.084, 787.461, -1227.280, 110.916},
    {"East Los Santos", 2222.560, -1628.530, -89.084, 2421.030, -1494.030, 110.916},
    {"Rodeo", 558.099, -1684.650, -89.084, 647.522, -1384.930, 110.916},
    {"Easter Tunnel", -1709.710, -833.034, -1.5, -1446.010, -730.118, 200.000},
    {"Rodeo", 466.223, -1385.070, -89.084, 647.522, -1235.070, 110.916},
    {"Redsands East", 1817.390, 2202.760, -89.084, 2011.940, 2342.830, 110.916},
    {"The Clown's Pocket", 2162.390, 1783.230, -89.084, 2437.390, 1883.230, 110.916},
    {"Idlewood", 1971.660, -1852.870, -89.084, 2222.560, -1742.310, 110.916},
    {"Montgomery Intersection", 1546.650, 208.164, 0.000, 1745.830, 347.457, 200.000},
    {"Willowfield", 2089.000, -2235.840, -89.084, 2201.820, -1989.900, 110.916},
    {"Temple", 952.663, -1130.840, -89.084, 1096.470, -937.184, 110.916},
    {"Prickle Pine", 1848.400, 2553.490, -89.084, 1938.800, 2863.230, 110.916},
    {"Los Santos International", 1400.970, -2669.260, -39.084, 2189.820, -2597.260, 60.916},
    {"Garver Bridge", -1213.910, 950.022, -89.084, -1087.930, 1178.930, 110.916},
    {"Garver Bridge", -1339.890, 828.129, -89.084, -1213.910, 1057.040, 110.916},
    {"Kincaid Bridge", -1339.890, 599.218, -89.084, -1213.910, 828.129, 110.916},
    {"Kincaid Bridge", -1213.910, 721.111, -89.084, -1087.930, 950.022, 110.916},
    {"Verona Beach", 930.221, -2006.780, -89.084, 1073.220, -1804.210, 110.916},
    {"Verdant Bluffs", 1073.220, -2006.780, -89.084, 1249.620, -1842.270, 110.916},
    {"Vinewood", 787.461, -1130.840, -89.084, 952.604, -954.662, 110.916},
    {"Vinewood", 787.461, -1310.210, -89.084, 952.663, -1130.840, 110.916},
    {"Commerce", 1463.900, -1577.590, -89.084, 1667.960, -1430.870, 110.916},
    {"Market", 787.461, -1416.250, -89.084, 1072.660, -1310.210, 110.916},
    {"Rockshore West", 2377.390, 596.349, -89.084, 2537.390, 788.894, 110.916},
    {"Julius Thruway North", 2237.400, 2542.550, -89.084, 2498.210, 2663.170, 110.916},
    {"East Beach", 2632.830, -1668.130, -89.084, 2747.740, -1393.420, 110.916},
    {"Fallow Bridge", 434.341, 366.572, 0.000, 603.035, 555.680, 200.000},
    {"Willowfield", 2089.000, -1989.900, -89.084, 2324.000, -1852.870, 110.916},
    {"Chinatown", -2274.170, 578.396, -7.6, -2078.670, 744.170, 200.000},
    {"El Castillo del Diablo", -208.570, 2337.180, 0.000, 8.430, 2487.180, 200.000},
    {"Ocean Docks", 2324.000, -2145.100, -89.084, 2703.580, -2059.230, 110.916},
    {"Easter Bay Chemicals", -1132.820, -768.027, 0.000, -956.476, -578.118, 200.000},
    {"The Visage", 1817.390, 1703.230, -89.084, 2027.400, 1863.230, 110.916},
    {"Ocean Flats", -2994.490, -430.276, -1.2, -2831.890, -222.589, 200.000},
    {"Richman", 321.356, -860.619, -89.084, 687.802, -768.027, 110.916},
    {"Green Palms", 176.581, 1305.450, -3.0, 338.658, 1520.720, 200.000},
    {"Richman", 321.356, -768.027, -89.084, 700.794, -674.885, 110.916},
    {"Starfish Casino", 2162.390, 1883.230, -89.084, 2437.390, 2012.180, 110.916},
    {"East Beach", 2747.740, -1668.130, -89.084, 2959.350, -1498.620, 110.916},
    {"Jefferson", 2056.860, -1372.040, -89.084, 2281.450, -1210.740, 110.916},
    {"Downtown Los Santos", 1463.900, -1290.870, -89.084, 1724.760, -1150.870, 110.916},
    {"Downtown Los Santos", 1463.900, -1430.870, -89.084, 1724.760, -1290.870, 110.916},
    {"Garver Bridge", -1499.890, 696.442, -179.615, -1339.890, 925.353, 20.385},
    {"Julius Thruway South", 1457.390, 823.228, -89.084, 2377.390, 863.229, 110.916},
    {"East Los Santos", 2421.030, -1628.530, -89.084, 2632.830, -1454.350, 110.916},
    {"Greenglass College", 964.391, 1044.690, -89.084, 1197.390, 1203.220, 110.916},
    {"Las Colinas", 2747.740, -1120.040, -89.084, 2959.350, -945.035, 110.916},
    {"Mulholland", 737.573, -768.027, -89.084, 1142.290, -674.885, 110.916},
    {"Ocean Docks", 2201.820, -2730.880, -89.084, 2324.000, -2418.330, 110.916},
    {"East Los Santos", 2462.130, -1454.350, -89.084, 2581.730, -1135.040, 110.916},
    {"Ganton", 2222.560, -1722.330, -89.084, 2632.830, -1628.530, 110.916},
    {"Avispa Country Club", -2831.890, -430.276, -6.1, -2646.400, -222.589, 200.000},
    {"Willowfield", 1970.620, -2179.250, -89.084, 2089.000, -1852.870, 110.916},
    {"Esplanade North", -1982.320, 1274.260, -4.5, -1524.240, 1358.900, 200.000},
    {"The High Roller", 1817.390, 1283.230, -89.084, 2027.390, 1469.230, 110.916},
    {"Ocean Docks", 2201.820, -2418.330, -89.084, 2324.000, -2095.000, 110.916},
    {"Last Dime Motel", 1823.080, 596.349, -89.084, 1997.220, 823.228, 110.916},
    {"Bayside Marina", -2353.170, 2275.790, 0.000, -2153.170, 2475.790, 200.000},
    {"King's", -2329.310, 458.411, -7.6, -1993.280, 578.396, 200.000},
    {"El Corona", 1692.620, -2179.250, -89.084, 1812.620, -1842.270, 110.916},
    {"Blackfield Chapel", 1375.600, 596.349, -89.084, 1558.090, 823.228, 110.916},
    {"The Pink Swan", 1817.390, 1083.230, -89.084, 2027.390, 1283.230, 110.916},
    {"Julius Thruway West", 1197.390, 1163.390, -89.084, 1236.630, 2243.230, 110.916},
    {"Los Flores", 2581.730, -1393.420, -89.084, 2747.740, -1135.040, 110.916},
    {"The Visage", 1817.390, 1863.230, -89.084, 2106.700, 2011.830, 110.916},
    {"Prickle Pine", 1938.800, 2624.230, -89.084, 2121.400, 2861.550, 110.916},
    {"Verona Beach", 851.449, -1804.210, -89.084, 1046.150, -1577.590, 110.916},
    {"Robada Intersection", -1119.010, 1178.930, -89.084, -862.025, 1351.450, 110.916},
    {"Linden Side", 2749.900, 943.235, -89.084, 2923.390, 1198.990, 110.916},
    {"Ocean Docks", 2703.580, -2302.330, -89.084, 2959.350, -2126.900, 110.916},
    {"Willowfield", 2324.000, -2059.230, -89.084, 2541.700, -1852.870, 110.916},
    {"King's", -2411.220, 265.243, -9.1, -1993.280, 373.539, 200.000},
    {"Commerce", 1323.900, -1842.270, -89.084, 1701.900, -1722.260, 110.916},
    {"Mulholland", 1269.130, -768.027, -89.084, 1414.070, -452.425, 110.916},
    {"Marina", 647.712, -1804.210, -89.084, 851.449, -1577.590, 110.916},
    {"Battery Point", -2741.070, 1268.410, -4.5, -2533.040, 1490.470, 200.000},
    {"The Four Dragons Casino", 1817.390, 863.232, -89.084, 2027.390, 1083.230, 110.916},
    {"Blackfield", 964.391, 1203.220, -89.084, 1197.390, 1403.220, 110.916},
    {"Julius Thruway North", 1534.560, 2433.230, -89.084, 1848.400, 2583.230, 110.916},
    {"Yellow Bell Gol Course", 1117.400, 2723.230, -89.084, 1457.460, 2863.230, 110.916},
    {"Idlewood", 1812.620, -1602.310, -89.084, 2124.660, -1449.670, 110.916},
    {"Redsands West", 1297.470, 2142.860, -89.084, 1777.390, 2243.230, 110.916},
    {"Doherty", -2270.040, -324.114, -1.2, -1794.920, -222.589, 200.000},
    {"Hilltop Farm", 967.383, -450.390, -3.0, 1176.780, -217.900, 200.000},
    {"Las Barrancas", -926.130, 1398.730, -3.0, -719.234, 1634.690, 200.000},
    {"Pirates in Men's Pants", 1817.390, 1469.230, -89.084, 2027.400, 1703.230, 110.916},
    {"City Hall", -2867.850, 277.411, -9.1, -2593.440, 458.411, 200.000},
    {"Avispa Country Club", -2646.400, -355.493, 0.000, -2270.040, -222.589, 200.000},
    {"The Strip", 2027.400, 863.229, -89.084, 2087.390, 1703.230, 110.916},
    {"Hashbury", -2593.440, -222.589, -1.0, -2411.220, 54.722, 200.000},
    {"Los Santos International", 1852.000, -2394.330, -89.084, 2089.000, -2179.250, 110.916},
    {"Whitewood Estates", 1098.310, 1726.220, -89.084, 1197.390, 2243.230, 110.916},
    {"Sherman Reservoir", -789.737, 1659.680, -89.084, -599.505, 1929.410, 110.916},
    {"El Corona", 1812.620, -2179.250, -89.084, 1970.620, -1852.870, 110.916},
    {"Downtown", -1700.010, 744.267, -6.1, -1580.010, 1176.520, 200.000},
    {"Foster Valley", -2178.690, -1250.970, 0.000, -1794.920, -1115.580, 200.000},
    {"Las Payasadas", -354.332, 2580.360, 2.0, -133.625, 2816.820, 200.000},
    {"Valle Ocultado", -936.668, 2611.440, 2.0, -715.961, 2847.900, 200.000},
    {"Blackfield Intersection", 1166.530, 795.010, -89.084, 1375.600, 1044.690, 110.916},
    {"Ganton", 2222.560, -1852.870, -89.084, 2632.830, -1722.330, 110.916},
    {"Easter Bay Airport", -1213.910, -730.118, 0.000, -1132.820, -50.096, 200.000},
    {"Redsands East", 1817.390, 2011.830, -89.084, 2106.700, 2202.760, 110.916},
    {"Esplanade East", -1499.890, 578.396, -79.615, -1339.890, 1274.260, 20.385},
    {"Caligula's Palace", 2087.390, 1543.230, -89.084, 2437.390, 1703.230, 110.916},
    {"Royal Casino", 2087.390, 1383.230, -89.084, 2437.390, 1543.230, 110.916},
    {"Richman", 72.648, -1235.070, -89.084, 321.356, -1008.150, 110.916},
    {"Starfish Casino", 2437.390, 1783.230, -89.084, 2685.160, 2012.180, 110.916},
    {"Mulholland", 1281.130, -452.425, -89.084, 1641.130, -290.913, 110.916},
    {"Downtown", -1982.320, 744.170, -6.1, -1871.720, 1274.260, 200.000},
    {"Hankypanky Point", 2576.920, 62.158, 0.000, 2759.250, 385.503, 200.000},
    {"K.A.C.C. Military Fuels", 2498.210, 2626.550, -89.084, 2749.900, 2861.550, 110.916},
    {"Harry Gold Parkway", 1777.390, 863.232, -89.084, 1817.390, 2342.830, 110.916},
    {"Bayside Tunnel", -2290.190, 2548.290, -89.084, -1950.190, 2723.290, 110.916},
    {"Ocean Docks", 2324.000, -2302.330, -89.084, 2703.580, -2145.100, 110.916},
    {"Richman", 321.356, -1044.070, -89.084, 647.557, -860.619, 110.916},
    {"Randolph Industrial Estate", 1558.090, 596.349, -89.084, 1823.080, 823.235, 110.916},
    {"East Beach", 2632.830, -1852.870, -89.084, 2959.350, -1668.130, 110.916},
    {"Flint Water", -314.426, -753.874, -89.084, -106.339, -463.073, 110.916},
    {"Blueberry", 19.607, -404.136, 3.8, 349.607, -220.137, 200.000},
    {"Linden Station", 2749.900, 1198.990, -89.084, 2923.390, 1548.990, 110.916},
    {"Glen Park", 1812.620, -1350.720, -89.084, 2056.860, -1100.820, 110.916},
    {"Downtown", -1993.280, 265.243, -9.1, -1794.920, 578.396, 200.000},
    {"Redsands West", 1377.390, 2243.230, -89.084, 1704.590, 2433.230, 110.916},
    {"Richman", 321.356, -1235.070, -89.084, 647.522, -1044.070, 110.916},
    {"Gant Bridge", -2741.450, 1659.680, -6.1, -2616.400, 2175.150, 200.000},
    {"Lil' Probe Inn", -90.218, 1286.850, -3.0, 153.859, 1554.120, 200.000},
    {"Flint Intersection", -187.700, -1596.760, -89.084, 17.063, -1276.600, 110.916},
    {"Las Colinas", 2281.450, -1135.040, -89.084, 2632.740, -945.035, 110.916},
    {"Sobell Rail Yards", 2749.900, 1548.990, -89.084, 2923.390, 1937.250, 110.916},
    {"The Emerald Isle", 2011.940, 2202.760, -89.084, 2237.400, 2508.230, 110.916},
    {"El Castillo del Diablo", -208.570, 2123.010, -7.6, 114.033, 2337.180, 200.000},
    {"Santa Flora", -2741.070, 458.411, -7.6, -2533.040, 793.411, 200.000},
    {"Playa del Seville", 2703.580, -2126.900, -89.084, 2959.350, -1852.870, 110.916},
    {"Market", 926.922, -1577.590, -89.084, 1370.850, -1416.250, 110.916},
    {"Queens", -2593.440, 54.722, 0.000, -2411.220, 458.411, 200.000},
    {"Pilson Intersection", 1098.390, 2243.230, -89.084, 1377.390, 2507.230, 110.916},
    {"Spinybed", 2121.400, 2663.170, -89.084, 2498.210, 2861.550, 110.916},
    {"Pilgrim", 2437.390, 1383.230, -89.084, 2624.400, 1783.230, 110.916},
    {"Blackfield", 964.391, 1403.220, -89.084, 1197.390, 1726.220, 110.916},
    {"'The Big Ear'", -410.020, 1403.340, -3.0, -137.969, 1681.230, 200.000},
    {"Dillimore", 580.794, -674.885, -9.5, 861.085, -404.790, 200.000},
    {"El Quebrados", -1645.230, 2498.520, 0.000, -1372.140, 2777.850, 200.000},
    {"Esplanade North", -2533.040, 1358.900, -4.5, -1996.660, 1501.210, 200.000},
    {"Easter Bay Airport", -1499.890, -50.096, -1.0, -1242.980, 249.904, 200.000},
    {"Fisher's Lagoon", 1916.990, -233.323, -100.000, 2131.720, 13.800, 200.000},
    {"Mulholland", 1414.070, -768.027, -89.084, 1667.610, -452.425, 110.916},
    {"East Beach", 2747.740, -1498.620, -89.084, 2959.350, -1120.040, 110.916},
    {"San Andreas Sound", 2450.390, 385.503, -100.000, 2759.250, 562.349, 200.000},
    {"Shady Creeks", -2030.120, -2174.890, -6.1, -1820.640, -1771.660, 200.000},
    {"Market", 1072.660, -1416.250, -89.084, 1370.850, -1130.850, 110.916},
    {"Rockshore West", 1997.220, 596.349, -89.084, 2377.390, 823.228, 110.916},
    {"Prickle Pine", 1534.560, 2583.230, -89.084, 1848.400, 2863.230, 110.916},
    {"Easter Basin", -1794.920, -50.096, -1.04, -1499.890, 249.904, 200.000},
    {"Leafy Hollow", -1166.970, -1856.030, 0.000, -815.624, -1602.070, 200.000},
    {"LVA Freight Depot", 1457.390, 863.229, -89.084, 1777.400, 1143.210, 110.916},
    {"Prickle Pine", 1117.400, 2507.230, -89.084, 1534.560, 2723.230, 110.916},
    {"Blueberry", 104.534, -220.137, 2.3, 349.607, 152.236, 200.000},
    {"El Castillo del Diablo", -464.515, 2217.680, 0.000, -208.570, 2580.360, 200.000},
    {"Downtown", -2078.670, 578.396, -7.6, -1499.890, 744.267, 200.000},
    {"Rockshore East", 2537.390, 676.549, -89.084, 2902.350, 943.235, 110.916},
    {"San Fierro Bay", -2616.400, 1501.210, -3.0, -1996.660, 1659.680, 200.000},
    {"Paradiso", -2741.070, 793.411, -6.1, -2533.040, 1268.410, 200.000},
    {"The Camel's Toe", 2087.390, 1203.230, -89.084, 2640.400, 1383.230, 110.916},
    {"Old Venturas Strip", 2162.390, 2012.180, -89.084, 2685.160, 2202.760, 110.916},
    {"Juniper Hill", -2533.040, 578.396, -7.6, -2274.170, 968.369, 200.000},
    {"Juniper Hollow", -2533.040, 968.369, -6.1, -2274.170, 1358.900, 200.000},
    {"Roca Escalante", 2237.400, 2202.760, -89.084, 2536.430, 2542.550, 110.916},
    {"Julius Thruway East", 2685.160, 1055.960, -89.084, 2749.900, 2626.550, 110.916},
    {"Verona Beach", 647.712, -2173.290, -89.084, 930.221, -1804.210, 110.916},
    {"Foster Valley", -2178.690, -599.884, -1.2, -1794.920, -324.114, 200.000},
    {"Arco del Oeste", -901.129, 2221.860, 0.000, -592.090, 2571.970, 200.000},
    {"Fallen Tree", -792.254, -698.555, -5.3, -452.404, -380.043, 200.000},
    {"The Farm", -1209.670, -1317.100, 114.981, -908.161, -787.391, 251.981},
    {"The Sherman Dam", -968.772, 1929.410, -3.0, -481.126, 2155.260, 200.000},
    {"Esplanade North", -1996.660, 1358.900, -4.5, -1524.240, 1592.510, 200.000},
    {"Financial", -1871.720, 744.170, -6.1, -1701.300, 1176.420, 300.000},
    {"Garcia", -2411.220, -222.589, -1.14, -2173.040, 265.243, 200.000},
    {"Montgomery", 1119.510, 119.526, -3.0, 1451.400, 493.323, 200.000},
    {"Creek", 2749.900, 1937.250, -89.084, 2921.620, 2669.790, 110.916},
    {"Los Santos International", 1249.620, -2394.330, -89.084, 1852.000, -2179.250, 110.916},
    {"Santa Maria Beach", 72.648, -2173.290, -89.084, 342.648, -1684.650, 110.916},
    {"Mulholland Intersection", 1463.900, -1150.870, -89.084, 1812.620, -768.027, 110.916},
    {"Angel Pine", -2324.940, -2584.290, -6.1, -1964.220, -2212.110, 200.000},
    {"Verdant Meadows", 37.032, 2337.180, -3.0, 435.988, 2677.900, 200.000},
    {"Octane Springs", 338.658, 1228.510, 0.000, 664.308, 1655.050, 200.000},
    {"Come-A-Lot", 2087.390, 943.235, -89.084, 2623.180, 1203.230, 110.916},
    {"Redsands West", 1236.630, 1883.110, -89.084, 1777.390, 2142.860, 110.916},
    {"Santa Maria Beach", 342.648, -2173.290, -89.084, 647.712, -1684.650, 110.916},
    {"Verdant Bluffs", 1249.620, -2179.250, -89.084, 1692.620, -1842.270, 110.916},
    {"Las Venturas Airport", 1236.630, 1203.280, -89.084, 1457.370, 1883.110, 110.916},
    {"Flint Range", -594.191, -1648.550, 0.000, -187.700, -1276.600, 200.000},
    {"Verdant Bluffs", 930.221, -2488.420, -89.084, 1249.620, -2006.780, 110.916},
    {"Palomino Creek", 2160.220, -149.004, 0.000, 2576.920, 228.322, 200.000},
    {"Ocean Docks", 2373.770, -2697.090, -89.084, 2809.220, -2330.460, 110.916},
    {"Easter Bay Airport", -1213.910, -50.096, -4.5, -947.980, 578.396, 200.000},
    {"Whitewood Estates", 883.308, 1726.220, -89.084, 1098.310, 2507.230, 110.916},
    {"Calton Heights", -2274.170, 744.170, -6.1, -1982.320, 1358.900, 200.000},
    {"Easter Basin", -1794.920, 249.904, -9.1, -1242.980, 578.396, 200.000},
    {"Los Santos Inlet", -321.744, -2224.430, -89.084, 44.615, -1724.430, 110.916},
    {"Doherty", -2173.040, -222.589, -1.0, -1794.920, 265.243, 200.000},
    {"Mount Chiliad", -2178.690, -2189.910, -47.917, -2030.120, -1771.660, 576.083},
    {"Fort Carson", -376.233, 826.326, -3.0, 123.717, 1220.440, 200.000},
    {"Foster Valley", -2178.690, -1115.580, 0.000, -1794.920, -599.884, 200.000},
    {"Ocean Flats", -2994.490, -222.589, -1.0, -2593.440, 277.411, 200.000},
    {"Fern Ridge", 508.189, -139.259, 0.000, 1306.660, 119.526, 200.000},
    {"Bayside", -2741.070, 2175.150, 0.000, -2353.170, 2722.790, 200.000},
    {"Las Venturas Airport", 1457.370, 1203.280, -89.084, 1777.390, 1883.110, 110.916},
    {"Blueberry Acres", -319.676, -220.137, 0.000, 104.534, 293.324, 200.000},
    {"Palisades", -2994.490, 458.411, -6.1, -2741.070, 1339.610, 200.000},
    {"North Rock", 2285.370, -768.027, 0.000, 2770.590, -269.740, 200.000},
    {"Hunter Quarry", 337.244, 710.840, -115.239, 860.554, 1031.710, 203.761},
    {"Los Santos International", 1382.730, -2730.880, -89.084, 2201.820, -2394.330, 110.916},
    {"Missionary Hill", -2994.490, -811.276, 0.000, -2178.690, -430.276, 200.000},
    {"San Fierro Bay", -2616.400, 1659.680, -3.0, -1996.660, 2175.150, 200.000},
    {"Restricted Area", -91.586, 1655.050, -50.000, 421.234, 2123.010, 250.000},
    {"Mount Chiliad", -2997.470, -1115.580, -47.917, -2178.690, -971.913, 576.083},
    {"Mount Chiliad", -2178.690, -1771.660, -47.917, -1936.120, -1250.970, 576.083},
    {"Easter Bay Airport", -1794.920, -730.118, -3.0, -1213.910, -50.096, 200.000},
    {"The Panopticon", -947.980, -304.320, -1.1, -319.676, 327.071, 200.000},
    {"Shady Creeks", -1820.640, -2643.680, -8.0, -1226.780, -1771.660, 200.000},
    {"Back o Beyond", -1166.970, -2641.190, 0.000, -321.744, -1856.030, 200.000},
    {"Mount Chiliad", -2994.490, -2189.910, -47.917, -2178.690, -1115.580, 576.083},
    {"Tierra Robada", -1213.910, 596.349, -242.990, -480.539, 1659.680, 900.000},
    {"Flint County", -1213.910, -2892.970, -242.990, 44.615, -768.027, 900.000},
    {"Whetstone", -2997.470, -2892.970, -242.990, -1213.910, -1115.580, 900.000},
    {"Bone County", -480.539, 596.349, -242.990, 869.461, 2993.870, 900.000},
    {"Tierra Robada", -2997.470, 1659.680, -242.990, -480.539, 2993.870, 900.000},
    {"San Fierro", -2997.470, -1115.580, -242.990, -1213.910, 1659.680, 900.000},
    {"Las Venturas", 869.461, 596.349, -242.990, 2997.060, 2993.870, 900.000},
    {"Red County", -1213.910, -768.027, -242.990, 2997.060, 596.349, 900.000},
    {"Los Santos", 44.615, -2892.970, -242.990, 2997.060, -768.027, 900.000}}
    for i, v in ipairs(streets) do
        if (x >= v[2]) and (y >= v[3]) and (z >= v[4]) and (x <= v[5]) and (y <= v[6]) and (z <= v[7]) then
            return v[1]
        end
    end
    return "Unknown"
end

function strunsplit(str, delim)
   local str = string.split(str, " ")
   local estr = {[1] = ""}
   local A_Index = 1
   for k, i in ipairs(str) do
        if #estr[A_Index] + #i > delim then A_Index = A_Index + 1 estr[A_Index] = "" end    
        estr[A_Index] = estr[A_Index] == "" and i or "" .. estr[A_Index] .. " " .. i .. "" 
   end
    
   return estr
end

