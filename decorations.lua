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
    deco_type    = "schematic",
    noise_params = {
        offset = 0.021,
        scale = 0.0947,
        spread = { x = 128, y = 128, z = 128 },
        seed = 453392,
        octaves = 5,
        persist = 0.6
    },
    _sound_def   = {
        key = "node_sound_leaves_defaults",
        input = {},
    },
    schematic    = core.get_modpath("elysflowers") .. "/schems/" .. "babysbreath.mts",
    place_on     = { xcompat.dirt_with_grass, xcompat.materials.dirt
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "deciduous_forest", "BirchForest", "BirchForestM" },
    y_min        = 1,
    y_max        = 31000,
    decoration   = "elysflowers:babys_breath",
})

core.register_decoration({
    name = "elysflowers:crocus",
    deco_type = "simple",
    noise_params = {
        offset = -0.02,
        scale = 0.013,
        spread = { x = 64, y = 64, z = 64 },
        seed = 2342,
        octaves = 3,
        persist = 0.2,
        flags = { "absvalue" }

    },
    place_on = { xcompat.materials.snow, xcompat.materials.dirt_with_grass, "default:snow",
        "default:permafrost_with_stones",
        "default:permafrost_with_moss", "etheral:cold_dirt",
        "default:dirt_with_snow"
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
    place_on = { xcompat.materials.dirt_with_grass, "default:dirt_with_leaves", "woodsoils:grass_with_leaves_1"
    },
    sidelen = 16,
    waving = true,
    biomes = { "Forest", "deciduous_forest", "RoofedForest", "BirchForest" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    spawn_by = { "default:tree", "mcl_trees:tree", "mcl_core:tree", "mcl_core:birchtree", "mcl_trees:tree_dark_oak", "mcl_core:darktree", "mcl_trees:birch_tree" },
    num_spawn_by = 1,
    decoration = "elysflowers:dames_rocket",
})

core.register_decoration({
    name = "elysflowers:arctic_poppy",
    deco_type = "simple",
    noise_params = {
        offset = -0.02,
        scale = 0.04,
        spread = { x = 64, y = 64, z = 64 },
        seed = 22123,
        octaves = 2,
        persist = 0.6,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:permafrost_with_stones", "default:permafrost_with_moss",
        "etheral:cold_dirt",
        "default:dirt_with_snow", "default:dirt_with_coniferous_litter"
    },
    sidelen = 16,
    waving = true,
    biomes = { "tundra", "taiga", "Taiga", "ColdTaiga", "IcePlains", "IcePlainsSpikes", "coniferous_forest" }, --mcl core uses the same biome names but capitalized
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:arctic_poppy",
})

core.register_decoration({
    name = "elysflowers:african_marigold",
    deco_type = "simple",
    noise_params = {
        offset = -0.02,
        scale = 0.029,
        spread = { x = 64, y = 64, z = 64 },
        seed = 29132,
        octaves = 2,
        persist = 0.6,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:dry_dirt", "default:dry_dirt_with_dry_grass", "ethereal:dry_dirt" },
    sidelen = 16,
    waving = true,
    biomes = { "savanna", "Savanna", "mesa", "MesaPlateauF_grasstop", "jumble" }, --compat for mcl core "Savanna" biome
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
    place_on = { xcompat.materials.dirt_with_grass, "default:dry_dirt", "default:dry_dirt_with_dry_grass", "ethereal:dry_dirt" },
    sidelen = 16,
    waving = true,
    biomes = { "savanna", "mesa", "Savanna", "MesaPlateauF", "MesaPlateauFM_grasstop", "MesaPlateauFM" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:california_poppy",
})

core.register_decoration({
    name = "elysflowers:golden_groundsel",
    deco_type = "simple",
    spawn_by = { "default:birch_trunk", "mcl_trees:tree", "mcl_core:tree", "mcl_trees:tree_birch", "mcl_core:birchtree" },
    num_spawn_by = 1,
    noise_params = {
        offset = -0.092,
        scale = 0.0727,
        spread = { x = 32, y = 32, z = 32 },
        seed = 218132,
        octaves = 2,
        persist = 0.4

    },
    place_on = { xcompat.materials.dirt_with_grass, "mcl_core:dirt_with_grass", "woodsoils:grass_with_leaves_1", "woodsoils:grass_with_leaves_2", "woodsoils:grass_with_leaves_3" },
    sidelen = 16,
    rotation = "random",
    waving = true,
    biomes = { "Forest", "deciduous_forest", "BirchForest", "BirchForestM" }, --compat for mcl core "Savanna" biome
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:golden_groundsel",
})

core.register_decoration({
    name = "elysflowers:yarrow_pink",
    deco_type = "simple",
    noise_params = {
        offset = -0.021,
        scale = 0.09,
        spread = { x = 32, y = 32, z = 32 },
        seed = 86312,
        octaves = 1,
        persist = 0.7,


    },
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    spawn_by = { "default:water_source", "mcl_core:water_source" },
    biomes = { "grassland_dunes", "Swampland_shore", "Taiga_beach", "SunflowerPlains_ocean", "Savanna_beach" },
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
    biomes       = { "SunflowerPlains", "Plains", "grassland", "savanna" },
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
    biomes = { "Forest", "deciduous_forest", "RoofedForest", "Taiga_valley", "taiga_valley", "taiga" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    spawn_by = { "default:tree", "mcl_trees:tree", "mcl_core:tree", "mcl_core:birchtree", "mcl_core:darktree", "mcl_trees:tree_dark_oak" },
    num_spawn_by = 1,
    decoration = "elysflowers:phlox",
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
    biomes = { "Forest", "RoofedForest", "BirchForest", "BirchForestM" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:foxglove",
})

core.register_decoration({
    name = "elysflowers:lavender",
    deco_type = "simple",
    noise_params = {
        offset = -0.013,
        scale = 0.00222,
        spread = { x = 64, y = 64, z = 64 },
        seed = 19132,
        octaves = 2,
        persist = 0.5,
    },
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    biomes = { "Plains", "ExtremeHills", "grassland", "grassytwo", "CherryGrove" },
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:lavender",
})

core.register_decoration({
    name = "elysflowers:hyacinth",
    deco_type = "simple",
    noise_params = {
        offset = -0.0723,
        scale = 0.012,
        spread = { x = 64, y = 64, z = 64 },
        seed = 19132,
        octaves = 2,
        persist = 0.4,
    },
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    biomes = { "Taiga", "MegaTaiga", "ExtremeHills", "grassland", "grassytwo", "deciduous_forest", "RoofedForest", "taiga" },
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
