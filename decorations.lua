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
    place_on     = { "mcl_core:podzol", "default:dirt_with_coniferous_litter"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "taiga_valley", "TaigaValley" },
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
    place_on     = { xcompat.materials.dirt_with_grass, "mcl_core:dirt_with_grass", "default:dirt_with_coniferous_litter"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "taiga_valley", "TaigaValley" },
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
    biomes       = { "taiga_valley", "TaigaValley" },
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
    biomes       = { "taiga_valley", "TaigaValley" },
    y_min        = 1,
    y_max        = 50,
    decoration   = "elysflowers:fireweed_3",
})

core.register_decoration({
    name         = "elysflowers:babys_breath",
    deco_type    = "schematic",
    noise_params = {
        offset = -0.031,
        scale = 0.0147,
        spread = { x = 16, y = 16, z = 16 },
        seed = 453322,
        octaves = 1,
        persist = 0.2
    },
    _sound_def   = {
        key = "node_sound_leaves_defaults",
        input = {},
    },
    schematic    = core.get_modpath("elysflowers") .. "/schems/" .. "babysbreath.mts",
    place_on     = { xcompat.dirt_with_grass, "ethereal:grove_dirt", "mcl_core:podzol", "mcl_core:dirt"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "FlowerForest", "CherryGrove", "bamboo", "grassytwo", "deciduous_forest", "Plains", "grassland", "jumble" },
    y_min        = 1,
    y_max        = 31000,
    decoration   = "elysflowers:babys_breath",
})

core.register_decoration({
    name = "elysflowers:crocus",
    deco_type = "simple",
    noise_params = {
        offset = -0.02,
        scale = 0.03,
        spread = { x = 64, y = 64, z = 64 },
        seed = 2342,
        octaves = 3,
        persist = 0.5,
        flags = { "absvalue" }

    },
    place_on = { "default:snow", "mcl_core:snow", "default:permafrost_with_stones",
        "default:permafrost_with_moss", "etheral:cold_dirt", "mcl_core:podzol",
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
        offset = -0.62,
        scale = 0.25,
        spread = { x = 64, y = 64, z = 64 },
        seed = 123193,
        octaves = 1,
        persist = 0.5,

    },
    place_on = { xcompat.materials.dirt_with_grass, "default:dirt_with_leaves", "woodsoils:grass_with_leaves_1"
    },
    sidelen = 16,
    waving = true,
    biomes = { "Forest", "deciduous_forest" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    spawn_by = { "default:tree", "mcl_trees:tree" },
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
        persist = 0.7,

    },
    place_on = { "default:permafrost_with_stones", "default:permafrost_with_moss",
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
        offset = -0.09,
        scale = 0.042,
        spread = { x = 64, y = 64, z = 64 },
        seed = 732642,
        octaves = 2,
        persist = 0.9,

    },
    place_on = { "default:dirt_with_grass", "default:dry_dirt", "default:dry_dirt_with_dry_grass", "ethereal:dry_dirt" },
    sidelen = 16,
    waving = true,
    biomes = { "savanna", "mesa" },
    y_min = 1,
    y_max = 31000,
    rotation = "random",
    decoration = "elysflowers:california_poppy",
})

core.register_decoration({
    name = "elysflowers:golden_groundsel",
    deco_type = "simple",
    spawn_by = { "default:apple_tree", "mcl_trees:tree_oak", "mcl_trees:tree_birch", "mcl_leaves:tree_oak" },

    noise_params = {
        offset = -0.2,
        scale = 0.1,
        spread = { x = 8, y = 8, z = 8 },
        seed = 29132,
        octaves = 1,
        persist = 1.01,
        flags = { "eased", "absvalue" }

    },
    place_on = { "default:dirt_with_grass", "woodsoils:grass_with_leaves_1", "woodsoils:grass_with_leaves_2", "woodsoils:grass_with_leaves_3" },
    sidelen = 8,
    rotation = "random",
    waving = true,
    biomes = { "coniferous_forest", "Forest", "deciduous_forest", "Forest", "BirchForest", "BirchForestM" }, --compat for mcl core "Savanna" biome
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:golden_groundsel",
})

core.register_decoration({
    name = "elysflowers:yarrow_pink",
    deco_type = "simple",
    noise_params = {
        offset = -0.02,
        scale = 0.09,
        spread = { x = 32, y = 32, z = 32 },
        seed = 86312,
        octaves = 1,
        persist = 0.7,
        flags = { "eased" }

    },
    place_on = { "default:sand" },
    sidelen = 16,
    waving = true,
    biomes = { "grassland_dunes" },
    y_min = 1,
    y_max = 31000,
    --spawn_by = "default:acacia_tree",
    decoration = "elysflowers:yarrow_pink",
})

core.register_decoration({
    name         = "elysflowers:marshmallow",
    deco_type    = "simple",
    noise_params = {
        offset = -0.12,
        scale = 0.19,
        spread = { x = 32, y = 32, z = 32 },
        seed = 14398,
        octaves = 1,
        persist = 0.7
    },
    place_on     = { "default:dirt_with_grass", "default:dirt", "woodsoils:dirt_with_leaves" },
    sidelen      = 16,
    waving       = true,
    biomes       = { "grassland_ocean", "swamp", "rainforest_ocean", "deciduous_forest_ocean" },
    spawn_by     = { "default:water_source", "mcl_core:water_source" },
    num_spawn_by = 1,
    y_min        = 1,
    y_max        = 31000,
    decoration   = "elysflowers:marshmallow",
})

core.register_decoration({
    name = "elysflowers:lavender",
    deco_type = "simple",
    noise_params = {
        offset = -0.013,
        scale = 0.012,
        spread = { x = 16, y = 16, z = 16 },
        seed = 19132,
        octaves = 2,
        persist = 0.4,
    },
    place_on = { "default:dirt_with_grass" },
    sidelen = 16,
    waving = true,
    biomes = { "grassland", "grassytwo", "deciduous_forest" },
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:lavender",
})

core.register_decoration({
    name = "elysflowers:hyacinth",
    deco_type = "simple",
    noise_params = {
        offset = -0.013,
        scale = 0.012,
        spread = { x = 16, y = 16, z = 16 },
        seed = 19132,
        octaves = 2,
        persist = 0.4,
    },
    place_on = { "default:dirt_with_grass" },
    sidelen = 16,
    waving = true,
    biomes = { "grassland", "grassytwo", "deciduous_forest" },
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:hyacinth",
})
