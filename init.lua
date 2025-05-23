local S = core.get_translator("elysflowers")

elysflowers = {
    nodes = { {
        name                = "elysflowers:babys_breath",
        _botanical_name     = "G. Repens",
        description         = S("baby's breath"),
        drawtype            = "plantlike",
        _doc_items_longdesc = "Baby's Breath",
        tiles               = { "babys_breath.png" },
        wield_image         = "babys_breath.png",
        inventory_image     = "babys_breath.png",
        waving              = 1,
        visual_scale        = 0.9,
        paramtype           = "light",
        sunlight_propagates = false,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_white = 1, compostability = 35 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name                = "elysflowers:babys_breath_2",
        _botanical_name     = "G. Repens",
        description         = S("Baby's Breath"),
        drawtype            = "plantlike",
        _doc_items_longdesc = "Baby's Breath",
        tiles               = { "babys_breath_2.png" },
        wield_image         = "babys_breath.png",
        inventory_image     = "babys_breath.png",
        waving              = 1,
        paramtype           = "light",
        sunlight_propagates = false,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_white = 1, deco_block = 1, compostability = 35, not_in_creative_inventory = 0 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.4, -0.35, 0.35, 0.10, 0.35 },
        },
        drop                = "elysflowers:babys_breath"
    }, {
        name                = "elysflowers:fireweed",
        _botanical_name     = "C. angustifolium",
        description         = S("Fireweed"),
        drawtype            = "plantlike",
        _doc_items_longdesc = "Fireweed",
        tiles               = { "fireweed_0.png" },
        wield_image         = "fireweed_0.png",
        inventory_image     = "fireweed_0.png",
        waving              = 1,
        paramtype           = "light",
        sunlight_propagates = false,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, deco_block = 1, color_violet = 1, compostability = 45 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name                = "elysflowers:fireweed_2",
        _botanical_name     = "C. angustifolium",
        description         = S("Fireweed"),
        drawtype            = "plantlike",
        _doc_items_longdesc = "Fireweed",
        tiles               = { "fireweed_1.png" },
        wield_image         = "fireweed_0.png",
        inventory_image     = "fireweed_0.png",
        waving              = 1,
        visual_scale        = 1.5,
        paramtype           = "light",
        sunlight_propagates = false,
        light_source        = 2,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, place_flowerlike = 1, deco_block = 1, color_violet = 1, compostability = 45 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.25, -0.5, -0.25, 0.30, 1.0, 0.30 },
        },
        drop                = "elysflowers:fireweed"
    }, {
        name                = "elysflowers:fireweed_3",
        _botanical_name     = "C. angustifolium",
        description         = S("Fireweed"),
        drawtype            = "plantlike",
        _doc_items_longdesc = "Fireweed",
        tiles               = { "fireweed_2.png" },
        wield_image         = "fireweed_0.png",
        inventory_image     = "fireweed_0.png",
        waving              = 1,
        paramtype           = "light",
        sunlight_propagates = false,
        light_source        = 2,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_violet = 1, place_flowerlike = 1, compostability = 45 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        },
        drop                = "elysflowers:fireweed"
    }, {
        name                = "elysflowers:fireweed_4",
        _botanical_name     = "C. angustifolium",
        description         = S("Fireweed"),
        drawtype            = "plantlike",
        _doc_items_longdesc = "Fireweed",
        tiles               = { "fireweed_3.png" },
        wield_image         = "fireweed_0.png",
        inventory_image     = "fireweed_0.png",
        waving              = 1,
        paramtype           = "light",
        sunlight_propagates = true,
        light_source        = 2,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, place_flowerlike = 1, color_violet = 1, compostability = 45 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.10, 0.35 },
        },
        drop                = "elysflowers:fireweed"
    }, {
        name = "elysflowers:crocus",
        _botanical_name = "C. sativus",
        description = S("Crocus"),
        drawtype = "plantlike",
        tiles = { "crocus.png" },
        wield_image = "crocus.png",
        inventory_image = "crocus.png",
        waving = 1,
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        groups = { snappy = 3, flammable = 2, flower = 1, flora = 1, color_violet = 1 },
        _sound_def = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable = true,
        selection_box = {
            type = "fixed",
            fixed = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 },
        },
    }, {
        name = "elysflowers:dames_rocket",
        _botanical_name = "H. matronalis",
        description = S("Dame's Rocket"),
        drawtype = "plantlike",
        tiles = { "dames_rocket.png" },
        wield_image = "dames_rocket.png",
        inventory_image = "dames_rocket.png",
        waving = 1,
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        groups = { snappy = 3, flammable = 2, flower = 1, flora = 1, color_white = 1 },
        _sound_def = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable = true,
        selection_box = {
            type = "fixed",
            fixed = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 },
        },
    }, {
        name = "elysflowers:arctic_poppy",
        _botanical_name = "P. radicatum",
        description = S("Arctic Poppy"),
        drawtype = "plantlike",
        tiles = { "arctic_poppy.png" },
        wield_image = "arctic_poppy.png",
        inventory_image = "arctic_poppy.png",
        waving = 1,
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        groups = { snappy = 3, flammable = 2, flower = 1, flora = 1, color_yellow = 1 },
        _sound_def = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable = true,
        selection_box = {
            type = "fixed",
            fixed = { -0.45, -0.5, -0.35, 0.35, 0.45, 0.35 },
        },
    }, {
        name                = "elysflowers:african_marigold",
        _botanical_name     = "T. Erecta",
        description         = S("African Marigold"),
        drawtype            = "plantlike",
        long_description    =
        "Mounding Annual. Despite it's name, this flower is actually native to the hot and humid steppes of Latin America, inhabiting a wide variety of tropical and subtropical climates",
        tiles               = { "marigold.png" },
        wield_image         = "marigold.png",
        inventory_image     = "marigold.png",
        waving              = 1,
        paramtype           = "light",
        sunlight_propagates = true,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, color_yellow = 1 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        -- drop = def.drop or nil,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name                = "elysflowers:golden_groundsel",
        _botanical_name     = "P. aurea",
        description         = S("Golden Groundsel"),
        drawtype            = "plantlike",
        long_description    =
        "Herbacious mounding perennial, with many tiny yellow blooms. It can be found dotting the floors of decidious forests with sunflower like foliage",
        tiles               = { "groundsel.png" },
        wield_image         = "groundsel.png",
        inventory_image     = "groundsel.png",
        waving              = 1,
        visual_scale        = 1.4,
        paramtype           = "light",
        sunlight_propagates = true,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, color_yellow = 1 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        -- drop = def.drop or nil,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        },
    }, {
        name                = "elysflowers:yarrow_pink",
        _botanical_name     = "A. millefolium",
        description         = S("Yarrow"),
        drawtype            = "plantlike",
        tiles               = { "yarrow.png" },
        wield_image         = "yarrow.png",
        inventory_image     = "yarrow.png",
        waving              = 1,
        paramtype           = "light",
        sunlight_propagates = true,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, color_yellow = 1 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        },
    }, {
        name                = "elysflowers:marshmallow",
        _botanical_name     = "A. officinalis",
        description         = S("Marshmallow"),
        drawtype            = "plantlike",
        tiles               = { "marshmallow.png" },
        wield_image         = "marshmallow.png",
        inventory_image     = "marshmallow.png",
        waving              = 1,
        paramtype           = "light",
        sunlight_propagates = true,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, color_yellow = 1 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        },
    }, {
        name                = "elysflowers:lavender",
        _botanical_name     = "L. officinalis",
        description         = S("Lavender"),
        drawtype            = "plantlike",
        _doc_items_longdesc = "Herbacious & fragrant perennial with alluring purple blooms",
        long_description    =
        "Herbacious & fragrant perennial with alluring purple blooms. Can be found growing in cooler biomes, in open fields.",
        tiles               = { "lavender2.png" },
        wield_image         = "lavender2.png",
        inventory_image     = "lavender2.png",
        waving              = 1,
        paramtype           = "light",
        sunlight_propagates = true,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_blue = 1, compostability = 75 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name                = "elysflowers:hyacinth",
        _botanical_name     = "",
        description         = S("Hyacinth"),
        drawtype            = "plantlike",
        _doc_items_longdesc = "Herbacious & fragrant perennial with alluring purple blooms",
        long_description    =
        "Herbacious & fragrant perennial with alluring purple blooms. Can be found growing in cooler biomes, in open fields.",
        tiles               = { "hyacinth.png" },
        wield_image         = "hyacinth.png",
        inventory_image     = "hyacinth.png",
        waving              = 1,
        paramtype           = "light",
        sunlight_propagates = true,
        walkable            = false,
        groups              = { snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_blue = 1, compostability = 75 },
        _sound_def          = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable           = true,
        selection_box       = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    } }
}

-- debug, func to print table properties to the console
local function tprint(tbl, indent)
    if not indent then indent = 0 end
    local toprint = string.rep(" ", indent) .. "{\r\n"
    indent = indent + 2
    for k, v in pairs(tbl) do
        toprint = toprint .. string.rep(" ", indent)
        if (type(k) == "number") then
            toprint = toprint .. "[" .. k .. "] = "
        elseif (type(k) == "string") then
            toprint = toprint .. k .. "= "
        end
        if (type(v) == "number") then
            toprint = toprint .. v .. ",\r\n"
        elseif (type(v) == "string") then
            toprint = toprint .. "\"" .. v .. "\",\r\n"
        elseif (type(v) == "table") then
            toprint = toprint .. tprint(v, indent + 2) .. ",\r\n"
        else
            toprint = toprint .. "\"" .. tostring(v) .. "\",\r\n"
        end
    end
    toprint = toprint .. string.rep(" ", indent - 2) .. "}"
    return toprint
end

-- add botanical names to item descriptions if global setting == yes
local function format_description(dat)
    if dat._botanical_name then
        dat.description = dat.description ..
            "\n" .. core.colorize("#d0ffd0", dat._botanical_name)
    end
end

if core.get_game_info().id == "mineclonia" then
    core.register_biome({
        name = "TaigaValley",
        node_top = "mcl_core:dirt_with_grass",
        depth_top = 1,
        node_filler = "mcl_core:coarse_dirt",
        depth_filler = 3,
        node_riverbed = "mcl_core:sand",
        depth_riverbed = 1,
        y_min = 1,
        y_max = 100,
        humidity_point = 80,
        heat_point = 7,
        _mcl_biome_type = "cold",
        _mcl_palette_index = 5,
        _mcl_skycolor = "#7DA3FF",
        _mcl_fogcolor = overworld_fogcolor,
        weight = 1.0

    })
else
    core.register_biome({
        name = "taiga_valley",
        node_top = "default:dirt_with_coniferous_litter",
        depth_top = 1,
        node_filler = "default:dirt",
        depth_filler = 3,
        node_riverbed = "default:sand",
        depth_riverbed = 1,
        y_min = 1,
        y_max = 100,
        humidity_point = 85,
        heat_point = 29,
        weight = 0.59
    })
end

-- register nodes
for a, dat in pairs(elysflowers.nodes) do
    if not core.settings:get("elysflowers_botanical_descriptions") then
        format_description(dat)
    end
    core.register_node(dat.name, dat)
end

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
    place_on     = { "mcl_core:dirt_with_grass", "default:dirt_with_coniferous_litter"
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
    place_on     = { "mcl_core:dirt_with_grass", "default:dirt_with_coniferous_litter"
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
    place_on     = { "mcl_core:dirt_with_grass", "default:dirt_with_coniferous_litter"
    },
    sidelen      = 16,
    waving       = true,
    biomes       = { "taiga_valley", "TaigaValley" },
    y_min        = 1,
    y_max        = 50,
    decoration   = "elysflowers:fireweed_3",
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
        scale = 0.15,
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
    place_on = { "mcl_core:snow", "default:permafrost_with_stones", "default:permafrost_with_moss",
        "etheral:cold_dirt", "mcl_core:podzol",
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
    place_on = { xcompat.materials.dirt_with_grass, "woodsoils:grass_with_leaves_1" },
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
    place_on = { xcompat.materials.sand },
    sidelen = 16,
    waving = true,
    biomes = { "grassland_dunes", "FlowerForest" },
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
    place_on     = { xcompat.materials.dirt_with_grass, "default:dirt", "woodsoils:dirt_with_leaves" },
    sidelen      = 16,
    waving       = true,
    biomes       = { "grassland_ocean", "swamp", "rainforest_ocean", "deciduous_forest_ocean", "Swampland", "JungleEdge", "FlowerForest", "RoofedForest" },
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
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    biomes = { "grassland", "grassytwo", "deciduous_forest", "Plains", "Forest" },
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
    place_on = { xcompat.materials.dirt_with_grass },
    sidelen = 16,
    waving = true,
    biomes = { "grassland", "grassytwo", "deciduous_forest", "Plains", "Forest" },
    y_min = 1,
    y_max = 31000,
    decoration = "elysflowers:hyacinth",
})

-- handle mineclonia
if core.get_game_info().id == "mineclonia" then
    --  core.debug(tprint(mcl_flowers))
    mcl_flowerpots.register_potted_flower("elysflowers:crocus", {
        name = "elysflowers_crocus",
        desc = "Crocus",
        image = "crocus.png"
    })
    mcl_flowerpots.register_potted_flower("elysflowers:yarrow_pink",
        { name = "elysflowers:yarrow_pink", desc = "Pink Yarrow", image = "yarrow.png" })
    mcl_flowerpots.register_potted_flower("elysflowers:lavender",
        { name = "elysflowers:lavender", desc = "Lavender", image = "lavender_potted.png" })

    mcl_flowers.register_ground_flower("trillium",
        {
            image = "trillium.png",
            tiles = { "trillium_ground.png", "mcl_flowers_wildflower_stem.png" },
            description = S("Trillium"),
            longdesc =
                S("small annual found scattered across the floors of forests"),
            _mcl_crafting_output = { single = { output = "mcl_dyes:white" } }
        })

    -- Trillium Spread
    for i = 1, 4 do
        core.register_decoration({
            deco_type = "simple",
            place_on = { "mcl_core:dirt_with_grass" },
            fill_ratio = 0.0003,
            biomes = { "CherryGrove" },
            y_min = mcl_vars.mg_overworld_min,
            y_max = mcl_vars.mg_overworld_max,
            decoration = "mcl_flowers:trillium_" .. i,
        })

        -- Wildflowers
        core.register_decoration({
            deco_type = "simple",
            place_on = { "mcl_core:dirt_with_grass" },
            fill_ratio = 0.0002,
            biomes = { "BirchForest", "BirchForestM", "Forest" },
            y_min = mcl_vars.mg_overworld_min,
            y_max = mcl_vars.mg_overworld_max,
            decoration = "mcl_flowers:trillium_" .. i,
        })
    end
end


if core.global_exists("flowerpot") then
    flowerpot.register_node("elysflowers:african_marigold")
    flowerpot.register_node("elysflowers:crocus")
    flowerpot.register_node("elysflowers:yarrow_pink")
    flowerpot.register_node("elysflowers:arctic_poppy")
    flowerpot.register_node("elysflowers:marshmallow")
    flowerpot.register_node("elysflowers:lavender")
    flowerpot.register_node("elysflowers:fireweed")
    flowerpot.register_node("elysflowers:babys_breath")
end

dofile(core.get_modpath("elysflowers") .. "/crafting.lua")
