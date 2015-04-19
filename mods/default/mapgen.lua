--
-- Aliases for map generator outputs
--

minetest.register_alias("mapgen_stone", "default:stone")
minetest.register_alias("mapgen_dirt", "default:dirt")
minetest.register_alias("mapgen_dirt_with_grass", "default:dirt_with_grass")
minetest.register_alias("mapgen_sand", "default:sand")
minetest.register_alias("mapgen_water_source", "default:water_source")
minetest.register_alias("mapgen_river_water_source", "default:river_water_source")
minetest.register_alias("mapgen_lava_source", "default:lava_source")
minetest.register_alias("mapgen_gravel", "default:gravel")
minetest.register_alias("mapgen_desert_stone", "default:desert_stone")
minetest.register_alias("mapgen_desert_sand", "default:desert_sand")
minetest.register_alias("mapgen_dirt_with_snow", "default:dirt_with_snow")
minetest.register_alias("mapgen_snow", "default:snow")
minetest.register_alias("mapgen_snowblock", "default:snowblock")
minetest.register_alias("mapgen_ice", "default:ice")

minetest.register_alias("mapgen_tree", "default:tree")
minetest.register_alias("mapgen_leaves", "default:leaves")
minetest.register_alias("mapgen_apple", "default:apple")
minetest.register_alias("mapgen_jungletree", "default:jungletree")
minetest.register_alias("mapgen_jungleleaves", "default:jungleleaves")
minetest.register_alias("mapgen_junglegrass", "default:junglegrass")
minetest.register_alias("mapgen_pinetree", "default:pinetree")
minetest.register_alias("mapgen_pine_needles", "default:pine_needles")

minetest.register_alias("mapgen_cobble", "default:cobble")
minetest.register_alias("mapgen_stair_cobble", "stairs:stair_cobble")
minetest.register_alias("mapgen_mossycobble", "default:mossycobble")


--freeminer:
minetest.register_alias("mapgen_ice", "default:ice")
minetest.register_alias("mapgen_dirt_with_snow", "default:dirt_with_snow")


-- freeminer layers
local mg_params = {
	layer_default_thickness = 1,
	layer_thickness_multiplier = 1,
	layers= {
		{ name = "default:stone",              thickness  = 25, },
		{ name = "default:stone_with_coal",    y_max = -1000, },
		{ name = "default:water_source",       y_min = -3000, y_max = -70, thickness  = 3},
		{ name = "default:stone",              y_min = -3000, y_max = -70, }, -- stone after water
		{ name = "default:dirt",               y_min = -500,  y_max = 50, },
		{ name = "default:desert_stone",       thickness  = 3, },
		{ name = "default:stone_with_iron",    y_max = -2000, },
		{ name = "default:gravel",             y_max = -1, },
		{ name = "default:stone_with_copper",  y_max = -3000, },
		{ name = "default:clay",               thickness  = 4, },
		{ name = "default:stone_with_gold",    y_max = -5000, },
		{ name = "default:lava_source",        y_max = -3000, },
		{ name = "default:stone_with_diamond", y_max = -7000, },
		{ name = "default:obsidian",           y_max = -5000, thickness  = 5 },
		{ name = "default:stone",              thickness  = 20, },
		{ name = "default:stone_with_mese",    y_max = -10000, },
		{ name = "air",                        thickness  = 20, y_max = -500, y_min = -20000, }, --caves
		{ name = "default:lava_source",        y_max = -20000, thickness  = 15,},
		{ name = "default:mese",               y_max = -15000, },
		{ name = "air",                        thickness  = 2 },
	}
}

if core.setting_get("mg_params") == "" then
	core.setting_set("mg_params", core.write_json(mg_params))
end


--
-- Register ores
--

local coal_params = {offset = 0, scale = 1, spread = {x = 100, y = 100, z = 100}, seed = 42, octaves = 3, persist = 0.7}
local coal_threshhold = 0.2

local iron_params = {offset = 0, scale = 1, spread = {x = 100, y = 100, z = 100}, seed = 43, octaves = 3, persist = 0.7}
local iron_threshhold = 0.4

local mese_params = {offset = 0, scale = 1, spread = {x = 100, y = 100, z = 100}, seed = 44, octaves = 3, persist = 0.7}
local mese_threshhold = 0.7
local mese_block_threshhold = 1.0

local gold_params = {offset = 0, scale = 1, spread = {x = 100, y = 100, z = 100}, seed = 45, octaves = 3, persist = 0.7}
local gold_threshhold = 0.6

local diamond_params = {offset = 0, scale = 1, spread = {x = 100, y = 100, z = 100}, seed = 46, octaves = 3, persist = 0.7}
local diamond_threshhold = 0.8

local copper_params = {offset = 0, scale = 1, spread = {x = 100, y = 100, z = 100}, seed = 47, octaves = 3, persist = 0.7}
local copper_threshhold = 0.5


-- Blob ore first to avoid other ores inside blobs

function default.register_ores()
	minetest.register_ore({ 
		ore_type         = "blob",
		ore              = "default:clay",
		wherein          = {"default:sand"},
		clust_scarcity   = 24*24*24,
		clust_size       = 7,
		y_min            = -15,
		y_max            = 0,
		noise_threshhold = 0,
		noise_params     = {
			offset=0.35,
			scale=0.2,
			spread={x=5, y=5, z=5},
			seed=-316,
			octaves=1,
			persist=0.5
		},
	})

	minetest.register_ore({ 
		ore_type         = "blob",
		ore              = "default:sand",
		wherein          = {"default:stone"},
		clust_scarcity   = 24*24*24,
		clust_size       = 7,
		y_min            = -63,
		y_max            = 4,
		noise_threshhold = 0,
		noise_params     = {
			offset=0.35,
			scale=0.2,
			spread={x=5, y=5, z=5},
			seed=2316,
			octaves=1,
			persist=0.5
		},
	})

	minetest.register_ore({
		ore_type         = "blob",
		ore              = "default:dirt",
		wherein          = {"default:stone"},
		clust_scarcity   = 24*24*24,
		clust_size       = 7,
		y_min            = -63,
		y_max            = 31000,
		noise_threshhold = 0,
		noise_params     = {
			offset=0.35,
			scale=0.2,
			spread={x=5, y=5, z=5},
			seed=17676,
			octaves=1,
			persist=0.5
		},
	})

	minetest.register_ore({
		ore_type         = "blob",
		ore              = "default:gravel",
		wherein          = {"default:stone"},
		clust_scarcity   = 24*24*24,
		clust_size       = 7,
		y_min            = -31000,
		y_max            = 31000,
		noise_threshhold = 0,
		noise_params     = {
			offset=0.35,
			scale=0.2,
			spread={x=5, y=5, z=5},
			seed=766,
			octaves=1,
			persist=0.5
		},
	})


	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_coal",
		wherein        = "default:stone",
		clust_scarcity = 6*6*6,
		clust_num_ores = 8,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = 64,
		noise_params     = coal_params,
		noise_threshhold = coal_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_iron",
		wherein          = "default:stone",
		clust_scarcity   = 8*8*8,
		clust_num_ores   = 3,
		clust_size       = 2,
		y_min          = -15,
		y_max          = 2,
		noise_params     = iron_params,
		noise_threshhold = iron_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_iron",
		wherein        = "default:stone",
		clust_scarcity = 7*7*7,
		clust_num_ores = 5,
		clust_size     = 3,
		flags          = "absheight",
		y_min          = -63,
		y_max          = -16,
		noise_params     = iron_params,
		noise_threshhold = iron_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_iron",
		wherein        = "default:stone",
		clust_scarcity   = 6*6*6,
		clust_num_ores   = 5,
		clust_size       = 3,
		y_min          = -31000,
		y_max          = -64,
		flags          = "absheight",
		noise_params     = iron_params,
		noise_threshhold = iron_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_mese",
		wherein        = "default:stone",
		clust_scarcity   = 9*9*9,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -255,
		y_max          = -64,
		flags          = "absheight",
		noise_params     = mese_params,
		noise_threshhold = mese_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_mese",
		wherein        = "default:stone",
		clust_scarcity = 7*7*7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -256,
		flags          = "absheight",
		noise_params     = mese_params,
		noise_threshhold = mese_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:mese",
		wherein        = "default:stone",
		clust_scarcity   = 9*9*9,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = -1024,
		flags          = "absheight",
		noise_params     = mese_params,
		noise_threshhold = mese_block_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_gold",
		wherein        = "default:stone",
		clust_scarcity   = 9*9*9,
		clust_num_ores = 3,
		clust_size     = 2,
		y_min          = -255,
		y_max          = -64,
		flags          = "absheight",
		noise_params     = gold_params,
		noise_threshhold = gold_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_gold",
		wherein        = "default:stone",
		clust_scarcity   = 7*7*7,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -256,
		flags          = "absheight",
		noise_params     = gold_params,
		noise_threshhold = gold_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_diamond",
		wherein        = "default:stone",
		clust_scarcity   = 10*10*10,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -255,
		y_max          = -128,
		flags          = "absheight",
		noise_params     = diamond_params,
		noise_threshhold = diamond_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_diamond",
		wherein        = "default:stone",
		clust_scarcity = 8*8*8,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -256,
		flags          = "absheight",
		noise_params     = diamond_params,
		noise_threshhold = diamond_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_copper",
		wherein        = "default:stone",
		clust_scarcity   = 8*8*8,
		clust_num_ores = 4,
		clust_size     = 3,
		y_min          = -63,
		y_max          = -16,
		noise_params     = copper_params,
		noise_threshhold = copper_threshhold,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:stone_with_copper",
		wherein        = "default:stone",
		clust_scarcity   = 6*6*6,
		clust_num_ores = 5,
		clust_size     = 3,
		y_min          = -31000,
		y_max          = -64,
		flags          = "absheight",
		noise_params     = copper_params,
		noise_threshhold = copper_threshhold,
	})

--if minetest.setting_get("mg_name") == "indev" then
	-- Floatlands and high mountains springs
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:water_source",
		ore_param2     = 128,
		wherein        = "default:stone",
		clust_scarcity = 40*40*40,
		clust_num_ores = 8,
		clust_size     = 3,
		y_min          = 0,
		y_max          = 31000,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:lava_source",
		ore_param2     = 128,
		wherein        = "default:stone",
		clust_scarcity = 50*50*50,
		clust_num_ores = 5,
		clust_size     = 2,
		y_min          = 10000,
		y_max          = 31000,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:lava_source",
		ore_param2     = 128,
		wherein        = "default:stone",
		clust_scarcity = 80*80*80,
		clust_num_ores = 35,
		clust_size     = 4,
		y_min          = -31000,
		y_max          = 10000,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:sand",
		wherein        = "default:stone",
		clust_scarcity = 20*20*20,
		clust_num_ores = 5*5*4,
		clust_size     = 6,
		y_min          = -31000,
		y_max          = 31000,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:gravel",
		wherein        = "default:stone",
		clust_scarcity = 25*25*25,
		clust_num_ores = 5*5*4,
		clust_size     = 5,
		y_min          = -31000,
		y_max          = 31000,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:dirt",
		wherein        = "default:stone",
		clust_scarcity = 30*30*30,
		clust_num_ores = 5*5*5,
		clust_size     = 5,
		y_min          = -31000,
		y_max          = 31000,
	})

	-- Underground springs
	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:water_source",
		ore_param2     = 128,
		wherein        = "default:stone",
		clust_scarcity = 25*25*25,
		clust_num_ores = 12,
		clust_size     = 3,
		y_min          = -10000,
		y_max          = 7,
	})

	minetest.register_ore({
		ore_type       = "scatter",
		ore            = "default:lava_source",
		ore_param2     = 128,
		wherein        = "default:stone",
		clust_scarcity = 35*35*35,
		clust_num_ores = 5,
		clust_size     = 2,
		y_min          = -31000,
		y_max          = -100,
	})
--end

end

--
-- Register biomes
--


function default.register_biomes()
	minetest.clear_registered_biomes()

	minetest.register_biome({
		name = "default:grassland",
		--node_dust = "",
		node_top = "default:dirt_with_grass",
		depth_top = 1,
		node_filler = "default:dirt",
		depth_filler = 1,
		--node_stone = "",
		--node_water_top = "",
		--depth_water_top = ,
		--node_water = "",
		y_min = 5,
		y_max = 31000,
		heat_point = 50,
		humidity_point = 50,
	})

	minetest.register_biome({
		name = "default:grassland_ocean",
		--node_dust = "",
		node_top = "default:sand",
		depth_top = 1,
		node_filler = "default:sand",
		depth_filler = 2,
		--node_stone = "",
		--node_water_top = "",
		--depth_water_top = ,
		--node_water = "",
		y_min = -31000,
		y_max = 4,
		heat_point = 50,
		humidity_point = 50,
	})
end


--
-- Register mgv6 decorations
--


function default.register_mgv6_decorations()

	-- Papyrus

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 8,
		noise_params = {
			offset = -0.3,
			scale = 0.7,
			spread = {x=100, y=100, z=100},
			seed = 354,
			octaves = 3,
			persist = 0.7
		},
		y_min = 1,
		y_max = 1,
		decoration = "default:papyrus",
		height = 2,
	        height_max = 4,
		spawn_by = "default:water_source",
		num_spawn_by = 1,
	})

	-- Cacti

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = -0.012,
			scale = 0.024,
			spread = {x=100, y=100, z=100},
			seed = 230,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "default:cactus",
		height = 3,
	        height_max = 4,
	})

	-- Grasses

	for length = 1, 5 do
		minetest.register_decoration({
			deco_type = "simple",
			place_on = {"default:dirt_with_grass"},
			sidelen = 16,
			noise_params = {
				offset = 0,
				scale = 0.007,
				spread = {x=100, y=100, z=100},
				seed = 329,
				octaves = 3,
				persist = 0.6
			},
			y_min = 1,
			y_max = 30,
			decoration = "default:grass_"..length,
		})
	end

	-- Dry shrubs

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:desert_sand"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.035,
			spread = {x=100, y=100, z=100},
			seed = 329,
			octaves = 3,
			persist = 0.6
		},
		y_min = 1,
		y_max = 30,
		decoration = "default:dry_shrub",
	})
end


--
-- Register decorations
--


function default.register_decorations()

	-- Flowers

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=200, y=200, z=200},
			seed = 436,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:rose",
	})
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=200, y=200, z=200},
			seed = 19822,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = 33,
		y_max = 31000,
		decoration = "flowers:tulip",
	})
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=200, y=200, z=200},
			seed = 1220999,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:dandelion_yellow",
	})
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=200, y=200, z=200},
			seed = 36662,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:geranium",
	})
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=200, y=200, z=200},
			seed = 1133,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:viola",
	})
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.03,
			spread = {x=200, y=200, z=200},
			seed = 73133,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "flowers:dandelion_white",
	})

	-- Grasses

	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.04,
			scale = 0.04,
			spread = {x=200, y=200, z=200},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_1",
	})
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0.02,
			scale = 0.06,
			spread = {x=200, y=200, z=200},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_2",
	})
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = 0,
			scale = 0.08,
			spread = {x=200, y=200, z=200},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_3",
	})
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.02,
			scale = 0.10,
			spread = {x=200, y=200, z=200},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_4",
	})
	
	minetest.register_decoration({
		deco_type = "simple",
		place_on = {"default:dirt_with_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.04,
			scale = 0.12,
			spread = {x=200, y=200, z=200},
			seed = 66440,
			octaves = 3,
			persist = 0.6
		},
		biomes = {"default:grassland"},
		y_min = -31000,
		y_max = 31000,
		decoration = "default:grass_5",
	})
end


--
-- Detect mapgen to select functions
--


-- Mods using singlenode mapgen can call these functions to enable
-- the use of minetest.generate_ores or minetest.generate_decorations

local mg_params = minetest.get_mapgen_params()
if mg_params.mgname == "v5" then
	default.register_ores()
	default.register_biomes()
	default.register_decorations()
elseif mg_params.mgname == "v6"  or mg_params.mgname == "indev" then
	default.register_ores()
	default.register_mgv6_decorations()
elseif mg_params.mgname == "v7" or mg_params.mgname == "math"  then
	default.register_ores()
	default.register_biomes()
	default.register_decorations()
end


--
-- Generate nyan cats in all mapgens
--


-- facedir: 0/1/2/3 (head node facedir value)
-- length: length of rainbow tail
function default.make_nyancat(pos, facedir, length)
	local tailvec = {x=0, y=0, z=0}
	if facedir == 0 then
		tailvec.z = 1
	elseif facedir == 1 then
		tailvec.x = 1
	elseif facedir == 2 then
		tailvec.z = -1
	elseif facedir == 3 then
		tailvec.x = -1
	else
		--print("default.make_nyancat(): Invalid facedir: "+dump(facedir))
		facedir = 0
		tailvec.z = 1
	end
	local p = {x=pos.x, y=pos.y, z=pos.z}
	minetest.set_node(p, {name="default:nyancat", param2=facedir})
	for i=1,length do
		p.x = p.x + tailvec.x
		p.z = p.z + tailvec.z
		minetest.set_node(p, {name="default:nyancat_rainbow", param2=facedir})
	end
end


function default.generate_nyancats(minp, maxp, seed)
	local height_min = -31000
	local height_max = -32
	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed + 9324342)
	local max_num_nyancats = math.floor(volume / (16*16*16))
	for i=1,max_num_nyancats do
		if pr:next(0, 1000) == 0 then
			local x0 = pr:next(minp.x, maxp.x)
			local y0 = pr:next(minp.y, maxp.y)
			local z0 = pr:next(minp.z, maxp.z)
			local p0 = {x=x0, y=y0, z=z0}
			default.make_nyancat(p0, pr:next(0,3), pr:next(3,15))
		end
	end
end


minetest.register_on_generated(default.generate_nyancats)


--
-- Deprecated ore generation code
--


function default.generate_ore(name, wherein, minp, maxp, seed,
		chunks_per_volume, chunk_size, ore_per_chunk, height_min, height_max)
	minetest.log('action', "WARNING: default.generate_ore is deprecated")

	if maxp.y < height_min or minp.y > height_max then
		return
	end
	local y_min = math.max(minp.y, height_min)
	local y_max = math.min(maxp.y, height_max)
	if chunk_size >= y_max - y_min + 1 then
		return
	end
	local volume = (maxp.x-minp.x+1)*(y_max-y_min+1)*(maxp.z-minp.z+1)
	local pr = PseudoRandom(seed)
	local num_chunks = math.floor(chunks_per_volume * volume)
	local inverse_chance = math.floor(chunk_size*chunk_size*chunk_size / ore_per_chunk)
	--print("generate_ore num_chunks: "..dump(num_chunks))
	for i=1,num_chunks do
		local y0 = pr:next(y_min, y_max-chunk_size+1)
		if y0 >= height_min and y0 <= height_max then
			local x0 = pr:next(minp.x, maxp.x-chunk_size+1)
			local z0 = pr:next(minp.z, maxp.z-chunk_size+1)
			local p0 = {x=x0, y=y0, z=z0}
			for x1=0,chunk_size-1 do
			for y1=0,chunk_size-1 do
			for z1=0,chunk_size-1 do
				if pr:next(1,inverse_chance) == 1 then
					local x2 = x0+x1
					local y2 = y0+y1
					local z2 = z0+z1
					local p2 = {x=x2, y=y2, z=z2}
					if minetest.get_node(p2).name == wherein then
						minetest.set_node(p2, {name=name})
					end
				end
			end
			end
			end
		end
	end
	--print("generate_ore done")
end

