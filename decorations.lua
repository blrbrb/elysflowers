core.register_decoration({
    name         = "elysflowers:fireweed_0",
    deco_type    = "simple",
    noise_params = {
        offset = -0.031,
        scale = 0.240,
        spread = { x = 64, y = 64, z = 64 },
        seed = 17822,
        octaves = 2,
        persist = 0.6
    },
    _sound_def   = {
        key = "node_sound_leaves_defaults",
        input = {},
    },
    place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "taiga_valley", "Taiga_valley" },
    y_min        = 1,
    y_max        = 50,
    decoration   = "elysflowers:fireweed",
})
core.register_decoration({
    name         = "elysflowers:fireweed_1",
    deco_type    = "simple",
    noise_params = {
        offset = -0.04,
        scale = 0.940,
        spread = { x = 64, y = 64, z = 64 },
        seed = 374142,
        octaves = 2,
        persist = 0.6
    },
    _sound_def   = {
        key = "node_sound_leaves_defaults",
        input = {},
    },
    place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "taiga_valley", "Taiga_valley" },
    y_min        = 1,
    y_max        = 50,
    decoration   = "elysflowers:fireweed_1",
})
core.register_decoration({
    name         = "elysflowers:fireweed_2",
    deco_type    = "simple",
    noise_params = {
        offset = -0.09109,
        scale = 0.940,
        spread = { x = 64, y = 64, z = 64 },
        seed = 28912,
        octaves = 1,
        persist = 0.6
    },
    _sound_def   = {
        key = "node_sound_leaves_defaults",
        input = {},
    },
    place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "taiga_valley", "Taiga_valley" },
    y_min        = 1,
    y_max        = 50,
    decoration   = "elysflowers:fireweed_2",
})

core.register_decoration({
    name         = "elysflowers:fireweed_3",
    deco_type    = "simple",
    noise_params = {
        offset = -0.1211,
        scale = 0.940,
        spread = { x = 64, y = 64, z = 64 },
        seed = 97822,
        octaves = 1,
        persist = 0.6
    },
    _sound_def   = {
        key = "node_sound_leaves_defaults",
        input = {},
    },
    place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "taiga_valley", "Taiga_valley" },
    y_min        = 1,
    y_max        = 50,
    decoration   = "elysflowers:fireweed_3",
})

core.register_decoration({
    name         = "elysflowers:babys_breath",
    deco_type    = "simple",
    noise_params = {
        offset = -0.0021,
        scale = 0.00947,
        spread = { x = 32, y = 32, z = 32 },
        seed = 453392,
        octaves = 2,
        persist = 0.6
    },
    _sound_def   = {
        key = "node_sound_leaves_defaults",
        input = {},
    },
    place_on     = { xcompat.dirt_with_grass, xcompat.materials.dirt, "ethereal:grove_dirt"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "deciduous_forest", "BirchForest", "BirchForestM", "grove" },
    y_min        = 1,
    y_max        = 31000,
    decoration   = "elysflowers:babys_breath",
})

core.register_decoration({
    name         = "elysflowers:babys_breath_0",
    deco_type    = "simple",
    noise_params = {
        offset = -0.001732,
        scale = 0.0052912,
        spread = { x = 16, y = 16, z = 16 },
        seed = 567182,
        octaves = 1,
        persist = 0.5
    },
    _sound_def   = {
        key = "node_sound_leaves_defaults",
        input = {},
    },
    place_on     = { xcompat.dirt_with_grass, xcompat.materials.dirt, "ethereal:grove_dirt"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "deciduous_forest", "BirchForest", "BirchForestM", "grove" },
    spawn_by     = { "elysflowers:babys_breath" },
    y_min        = 1,
    y_max        = 31000,
    decoration   = "elysflowers:babys_breath_0",
})

core.register_decoration({
    name = "elysflowers:crocus",
    deco_type = "simple",
    noise_params = {
        offset = -0.0287,
        scale = 0.0013,
        spread = { x = 32, y = 32, z = 32 },
        seed = 2323142,
        octaves = 3,
        persist = 0.2,
        flags = { "absvalue" }

    },
    place_on = { xcompat.materials.snow, "default:dirt_with_snow", xcompat.materials.dirt_with_grass,
        "default:permafrost_with_stones",
        "default:permafrost_with_moss", "etheral:cold_dirt"
    },
    sidelen = 16,
    waving = true,
    biomes = { "snowy_grassland", "tundra", "taiga", "confierous_forest", "Tundra", "Taiga", "MegaTaiga", "IcePlains" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:crocus",
})
core.register_decoration({
    name = "elysflowers:indian_paintbrush",
    deco_type = "simple",
    noise_params = {
        offset = 0.006227,
        scale = 0.0002343,
        spread = { x = 32, y = 32, z = 32 },
        seed = 4209842,
        octaves = 1,
        persist = 0.3,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:dry_dirt_with_dry_grass", "default:dry_dirt",
        "ethereal:dry_dirt",
        "everness:dry_dirt_with_dry_grass", "everness:mineral_sand"
    },
    spawn_by = { "mcl_flowers:tallgrass", "default:dry_grass" },
    num_spawn_by = 2,
    sidelen = 16,
    waving = true,
    biomes = { "savanna", "Savanna", "everness:baobab_savanna", "everness:mineral_springs", "MesaPlateauFM_grasstop", "Mesa_sandlevel", "MesaPlateauFM", "mesa_redwood" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:indian_paintbrush",
})
core.register_decoration({
    name = "elysflowers:dames_rocket",
    deco_type = "simple",
    noise_params = {
        offset = -0.0127,
        scale = 0.055,
        spread = { x = 64, y = 64, z = 64 },
        seed = 12193,
        octaves = 1,
        persist = 0.5,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:dirt_with_leaves", "woodsoils:grass_with_leaves_1",
        "ethereal:grove_dirt"
    },
    sidelen = 16,
    waving = true,
    biomes = { "Forest", "deciduous_forest", "RoofedForest", "BirchForest", "deciduous_forest", "grove" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    spawn_by = { "default:tree", "default:aspen_tree", "default:tree", "mcl_trees:tree", "mcl_core:tree", "mcl_core:birchtree", "mcl_trees:tree_dark_oak", "mcl_core:darktree", "mcl_trees:birch_tree" },
    num_spawn_by = 1,
    decoration = "elysflowers:dames_rocket",
})

core.register_decoration({
    name = "elysflowers:arctic_poppy",
    deco_type = "simple",
    noise_params = {
        offset = -0.01945,
        scale = 0.04,
        spread = { x = 32, y = 32, z = 32 },
        seed = 22123,
        octaves = 2,
        persist = 0.6,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:permafrost_with_stones", "default:permafrost_with_moss",
        "etheral:cold_dirt", "default:snowblock", "default:silver_sand",
        "default:dirt_with_snow", "default:dirt_with_coniferous_litter"
    },
    sidelen = 16,
    waving = true,
    biomes = { "tundra", "taiga", "frost", "Taiga", "ColdTaiga", "IcePlains", "IcePlainsSpikes", "coniferous_forest", "cold_desert" }, --mcl core uses the same biome names but capitalized
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:arctic_poppy",
})

core.register_decoration({
    name = "elysflowers:african_marigold",
    deco_type = "simple",
    noise_params = {
        offset = 0.00545,
        scale = 0.000029,
        spread = { x = 16, y = 16, z = 16 },
        seed = 29132,
        octaves = 1,
        persist = 0.4,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:dry_dirt", "default:dirt_with_dry_grass", "ethereal:dry_dirt", "everness:dry_dirt_with_dry_grass" },
    sidelen = 32,
    waving = true,
    biomes = { "savanna", "Savanna", "mesa", "MesaPlateauF_grasstop", "jumble", "mesa_redwood", "everness:baobab_savanna" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:african_marigold",
})

core.register_decoration({
    name = "elysflowers:california_poppy",
    deco_type = "simple",
    noise_params = {
        offset = 0.0049,
        scale = 0.0042,
        spread = { x = 16, y = 16, z = 16 },
        seed = 732642,
        octaves = 2,
        persist = 0.3,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:dry_dirt", "default:dry_dirt_with_dry_grass", "ethereal:dry_dirt", "everness:dry_dirt_with_dry_grass" },
    sidelen = 16,
    waving = true,
    biomes = { "savanna", "mesa", "Savanna", "MesaPlateauF", "MesaPlateauFM_grasstop", "MesaPlateauFM", "everness:baobab_savanna" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:california_poppy",
})

core.register_decoration({
    name = "elysflowers:golden_groundsel",
    deco_type = "simple",
    spawn_by = { "default:birch_trunk", "default:aspen_tree", "mcl_trees:tree", "mcl_core:tree", "mcl_trees:tree_birch", "mcl_core:birchtree" },
    num_spawn_by = 1,
    noise_params = {
        offset = -0.092,
        scale = 0.0727,
        spread = { x = 32, y = 32, z = 32 },
        seed = 218132,
        octaves = 2,
        persist = 0.4

    },
    place_on = { xcompat.materials.dirt_with_grass, "ethereal:grove_dirt", "mcl_core:dirt_with_grass", "woodsoils:grass_with_leaves_1", "woodsoils:grass_with_leaves_2", "woodsoils:grass_with_leaves_3" },
    sidelen = 16,
    rotation = "random",
    waving = true,
    biomes = { "Forest", "deciduous_forest", "BirchForest", "BirchForestM", "grove" }, --compat for mcl core "Savanna" biome
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:golden_groundsel",
})

core.register_decoration({
    name = "elysflowers:yarrow_pink",
    deco_type = "simple",
    noise_params = {
        offset = -0.021,
        scale = 0.0019,
        spread = { x = 32, y = 32, z = 32 },
        seed = 86312,
        octaves = 1,
        persist = 0.4,
    },
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    spawn_by = { "default:water_source", "mcl_core:water_source" },
    num_spawn_by = 1,
    biomes = { "grassland_dunes", "Swampland_shore", "Taiga_beach", "SunflowerPlains_ocean", "Savanna_beach", "coniferous_forest_dunes", "deciduous_forest_shore" },
    y_min = 1,
    y_max = 31000,
    --spawn_by = "default:acacia_tree",
    decoration = "elysflowers:yarrow_pink",
})


core.register_decoration({
    name         = "elysflowers:black_eyed_susan",
    deco_type    = "simple",
    noise_params = {
        offset = 0.00052,
        scale = 0.0019,
        spread = { x = 32, y = 32, z = 32 },
        seed = 91138,
        octaves = 3,
        persist = 0.4
    },
    place_on     = { xcompat.materials.dirt_with_grass },
    sidelen      = 16,
    waving       = true,
    biomes       = { "SunflowerPlains", "Plains", "grassland", "plains", "savanna" },
    y_min        = 1,
    y_max        = 31000,
    decoration   = "elysflowers:black_eyed_susan",
})
core.register_decoration({
    name         = "elysflowers:forget_me_not",
    deco_type    = "simple",
    noise_params = {
        offset = 0.00022,
        scale = 0.0029,
        spread = { x = 32, y = 32, z = 32 },
        seed = 228123,
        octaves = 2,
        persist = 0.4
    },
    place_on     = { xcompat.materials.dirt_with_grass, },
    sidelen      = 16,
    waving       = true,
    biomes       = { "RoofedForest", "Forest", "BirchForest", "BirchForestM", "grassland",
        "deciduous_forest", "coniferous_forest", "grassytwo" },
    y_min        = 1,
    y_max        = 31000,
    decoration   = "elysflowers:forget_me_not",
})
core.register_decoration({
    name = "elysflowers:phlox",
    deco_type = "simple",
    noise_params = {
        offset = 0.00593,
        scale = 0.0045,
        spread = { x = 32, y = 64, z = 32 },
        seed = 881933,
        octaves = 2,
        persist = 0.6,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:dirt_with_leaves", "woodsoils:grass_with_leaves_1"
    },
    sidelen = 16,
    waving = true,
    biomes = { "Forest", "coniferous_forest", "RoofedForest" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    spawn_by = { "default:tree", "mcl_trees:tree", "mcl_core:tree", "mcl_core:birchtree", "mcl_core:darktree", "mcl_trees:tree_dark_oak" },
    num_spawn_by = 1,
    decoration = "elysflowers:phlox",
})

core.register_decoration({
    name         = "elysflowers:marshmallow",
    deco_type    = "simple",
    noise_params = {
        offset = -0.0496,
        scale = 0.029,
        spread = { x = 32, y = 32, z = 32 },
        seed = 19173,
        octaves = 2,
        persist = 0.4
    },
    place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_rainforest_litter" },
    sidelen      = 16,
    waving       = true,
    biomes       = { "swamp", "Swampland", "Swampland_ocean", "swamp", "JungleEdgeM" },
    spawn_by     = { "default:water_source", "mcl_core:water_source" },
    y_min        = 1,
    y_max        = 31000,
    decoration   = "elysflowers:marshmallow",
})

core.register_decoration({
    name = "elysflowers:foxglove",
    deco_type = "simple",
    noise_params = {
        offset = -0.003123,
        scale = 0.00414,
        spread = { x = 32, y = 32, z = 64 },
        seed = 881933,
        octaves = 3,
        persist = 0.4,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:dirt_with_leaves", "woodsoils:grass_with_leaves_1"
    },
    sidelen = 8,
    waving = true,
    biomes = { "Forest", "RoofedForest", "BirchForest", "BirchForestM", "deciduous_forest", "" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:foxglove",
})

core.register_decoration({
    name = "elysflowers:lavender",
    deco_type = "simple",
    noise_params = {
        offset = -0.0135193,
        scale = 0.0522,
        spread = { x = 32, y = 32, z = 32 },
        seed = 747423,
        octaves = 1,
        persist = 0.4,
    },
    place_on = { xcompat.materials.dirt_with_grass, "ethereal:bamboo_dirt", "ethereal:grove_dirt" },
    sidelen = 32,
    waving = true,
    biomes = { "Plains", "ExtremeHills", "grassytwo", "CherryGrove", "bamboo", "meditteranean" },
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:lavender",
})

core.register_decoration({
    name = "elysflowers:hyacinth",
    deco_type = "simple",
    noise_params = {
        offset = -0.0423,
        scale = 0.012,
        spread = { x = 16, y = 16, z = 16 },
        seed = 36945,
        octaves = 2,
        persist = 0.4,
    },
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    biomes = { "Taiga", "MegaTaiga", "ExtremeHills", "grassland", "grassytwo", "RoofedForest", "taiga", "coniferous_forest" },
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:hyacinth",
})

core.register_decoration({
    name = "elysflowers:purple_coneflower",
    deco_type = "simple",
    noise_params = {
        offset = 0.0009451,
        scale = 0.00212,
        spread = { x = 64, y = 32, z = 64 },
        seed = 58177,
        octaves = 2,
        persist = 0.5,
    },
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    biomes = { "ExtremeHills", "grassland", "grassytwo", "deciduous_forest", "Plains", "ExtremeHillsM", "ExtremeHills++" },
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:purple_coneflower",
})

core.register_decoration({
    name = "elysflowers:purple_coneflower_1",
    deco_type = "simple",
    noise_params = {
        offset = -0.0274,
        scale = 0.0212,
        spread = { x = 32, y = 32, z = 32 },
        seed = 92731,
        octaves = 1,
        persist = 0.5,
    },
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    biomes = { "ExtremeHills", "grassland", "grassytwo", "deciduous_forest", "Plains", "ExtremeHillsM", "ExtremeHills++" },
    spawn_by = "elysflowers:purple_coneflower",
    num_spawn_by = 1,
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:purple_coneflower_1",
})
core.register_decoration({
    name = "elysflowers:larkspur",
    deco_type = "simple",
    noise_params = {
        offset = -0.09029,
        scale = 0.0212,
        spread = { x = 32, y = 32, z = 32 },
        seed = 22269,
        octaves = 1,
        persist = 0.5,
    },
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    biomes = { "Forest", "BirchForest", "grassland", "grassytwo", "deciduous_forest", "RoofedForest", "coniferous_forest" },
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:larkspur",
})

core.register_decoration({
    name = "elysflowers:hibiscus",
    deco_type = "simple",
    noise_params = {
        offset = -0.00929,
        scale = 0.01412,
        spread = { x = 32, y = 32, z = 32 },
        seed = 2983671,
        octaves = 2,
        persist = 0.5,
    },
    place_on = { xcompat.materials.dirt_with_grass, "default:dirt_with_rainforest_litter", "everness:dirt_with_grass" },
    sidelen = 16,
    waving = true,
    biomes = { "rainforest_ocean", "Forest_beach", "everness:bamboo_forest", "Swampland_ocean", "Swampland_deep_ocean", "Swampland_shore", "JungleEdge", "JungleEdge_ocean", "Savanna_beach", "Plains_beach", "MangroveSwamp_shore", "JungleM_shore", "Jungle_shore", "JungleEdge_ocean", "JungleEdge_deep_ocean", "JungleM_ocean", "Jungle_ocean", "savanna_shore", "savanna_ocean", "sandstone_desert_ocean", "desert_ocean", "rainforest" },
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:hibiscus",
})
