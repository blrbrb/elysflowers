local S = core.get_translator("elysflowers")

local gameid = core.get_game_info().id
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

local function register_plant(def)
    local groups = { attached_node = 1, unsticky = 1, non_mycelium_plant = 1, dig_by_water = 1, destroy_by_lava_flow = 1, fire_encouragement = 60, enderman_takable = 1, fire_flammability = 100, place_flowerlike = 1, dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_white = 1, deco_block = 1, compostability = 35 }

    if def.not_in_creative_inventory then
        groups["not_in_creative_inventory"] = 1
    else
        groups["not_in_creative_inventory"] = 0
    end

    if def.dye then
        groups["color_" .. def.dye] = 1
    end

    core.register_node(def.name, {
        name                 = def.name,
        _botanical_name      = def._botanical_name,
        description          = def.description,
        drawtype             = "plantlike",
        _doc_items_longdesc  = def.longdesc,
        tiles                = def.tiles,
        wield_image          = def.wield_image,
        inventory_image      = def.inventory_image,
        visual_scale         = def.visual_scale,
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = groups,
        _mcl_crafting_output = { single = { output = def.mcl_dye } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = def.selection_box,
        },
        drop                 = def.drop,
        on_place             = def.on_place
    })

    core.register_decoration({
        name = def.name,
        deco_type = "simple",
        spawn_by = {""} or def.spawn_by,
        num_spawn_by = 0 or def.num_spawn_by,
        noise_params = def.noise_params,
        place_on = def.place_on or {xcompat.materials.dirt_with_grass},
        sidelen = 16 or def.sidelen,
        rotation = "random",
        waving = true,
        biomes = def.biomes,
        y_min = 1,
        y_max = 31000,
        decoration = def.name,
    })

end


--register biomes, handle mineclonia specific parameters
if gameid == "mineclonia" or gameid == "mineclone2" then
    core.register_biome({
        name = "Taiga_valley",
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
        _mcl_fogcolor = "#C0D8FF",
        weight = 1.0
    })
    _on_bone_meal = mcl_flowers.on_bone_meal_simple
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



elysflowers = {

    nodes =
    {
        {
            name            = "elysflowers:indian_paintbrush",
            _botanical_name = "Castilleja coccinea",
            description     = S("Indian Paintbrush"),
            longdesc        =
            "Commonly found in temperate praries",
            tiles           = { "indian_paintbrush.png" },
            wield_image     = "indian_paintbrush.png",
            inventory_image = "indian_paintbrush.png",
            mcl_dye         = "mcl_dyes:red",
            dye             = "red",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
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
            biomes = { "savanna", "Savanna", "everness:baobab_savanna", "everness:mineral_springs", "MesaPlateauFM_grasstop", "Mesa_sandlevel", "MesaPlateauFM", "mesa_redwood" },
            spawn_by = { "mcl_flowers:tallgrass", "default:dry_grass" },
            num_spawn_by = 2,
            potted = true
        },
        {
            name            = "elysflowers:forget_me_not",
            _botanical_name = "C. Amabile",
            description     = S("Chinese Forget-me-not"),
            longdesc        = "",
            tiles           = { "forget_me_not.png" },
            dye             = "blue",
            mcl_dye         = "mcl_dyes:light_blue",
            wield_image     = "forget_me_not.png",
            inventory_image = "forget_me_not.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = 0.00022,
                scale = 0.0029,
                spread = { x = 32, y = 32, z = 32 },
                seed = 228123,
                octaves = 2,
                persist = 0.4
            },
            place_on     = { xcompat.materials.dirt_with_grass, },
            biomes       = { "RoofedForest", "Forest", "BirchForest", "BirchForestM", "grassland",
                "deciduous_forest", "coniferous_forest", "grassytwo" },
            potted = true
        },
        {
            name             = "elysflowers:foxglove",
            _botanical_name  = "Digitalis purpurea",
            description      = S("Foxglove"),
            long_description = "",
            tiles            = { "foxglove2.png" },
            wield_image      = "foxglove2.png",
            dye              = "pink",
            mcl_dye          = "mcl_dyes:pink",
            inventory_image  = "foxglove2.png",
            selection_box    = { -0.25, -0.49, -0.25, 0.25, 0.50, 0.25 },
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
            biomes = { "Forest", "RoofedForest", "BirchForest", "BirchForestM", "deciduous_forest"},
            sidelen = 8,
            potted = true
        },
        {
            name            = "elysflowers:hibiscus",
            _botanical_name = "H. Aponeurus",
            description     = S("Hibiscus"),
            tiles           = { "hibiscus_flower.png" },
            wield_image     = "hibiscus_flower.png",
            inventory_image = "hibiscus_flower.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = -0.00929,
                scale = 0.01412,
                spread = { x = 32, y = 32, z = 32 },
                seed = 2983671,
                octaves = 2,
                persist = 0.5,
            },
            place_on = { xcompat.materials.dirt_with_grass, "default:dirt_with_rainforest_litter", "everness:dirt_with_grass" },
            biomes = { "rainforest_ocean", "Forest_beach", "everness:bamboo_forest", "Swampland_ocean", "Swampland_deep_ocean", "Swampland_shore", "JungleEdge", "JungleEdge_ocean", "Savanna_beach", "Plains_beach", "MangroveSwamp_shore", "JungleM_shore", "Jungle_shore", "JungleEdge_ocean", "JungleEdge_deep_ocean", "JungleM_ocean", "Jungle_ocean", "savanna_shore", "savanna_ocean", "sandstone_desert_ocean", "desert_ocean", "rainforest" },
            sidelen = 16,
            potted = true
        },
        {
            name            = "elysflowers:larkspur",
            _botanical_name = "D. nuttallianum",
            description     = S("Larkspur"),
            tiles           = { "larkspur.png" },
            dye             = "white",
            mcl_dye         = "mcl_dyes:white",
            wield_image     = "larkspur.png",
            inventory_image = "larkspur.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
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
            biomes = { "Forest", "BirchForest", "grassland", "grassytwo", "deciduous_forest", "RoofedForest", "coniferous_forest" },
            potted = true
        },
        {
            name            = "elysflowers:black_eyed_susan",
            _botanical_name = "Rudbeka. Hertia",
            description     = S("Black-eyed-susan"),
            tiles           = { "black_eyed_susan.png" },
            wield_image     = "black_eyed_susan.png",
            dye             = "yellow",
            mcl_dye         = "mcl_dyes:yellow",
            inventory_image = "black_eyed_susan.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = 0.00052,
                scale = 0.0019,
                spread = { x = 32, y = 32, z = 32 },
                seed = 91138,
                octaves = 3,
                persist = 0.4
            },
            place_on     = { xcompat.materials.dirt_with_grass },
            biomes       = { "SunflowerPlains", "Plains", "grassland", "plains", "savanna" },
            potted = true
        },
        {
            name            = "elysflowers:phlox",
            _botanical_name = "P. drummondii",
            description     = S("Phlox"),
            longdesc        = "Charming, abundant blooms on tall stems.",
            tiles           = { "phlox.png" },
            dye             = "violet",
            mcl_dye         = "mcl_dyes:purple",
            wield_image     = "phlox.png",
            inventory_image = "phlox.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
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
            biomes = { "Forest", "coniferous_forest", "RoofedForest" },
            spawn_by = { "default:tree", "mcl_trees:tree", "mcl_core:tree", "mcl_core:birchtree", "mcl_core:darktree", "mcl_trees:tree_dark_oak" },
            num_spawn_by = 1,
            potted = true
        },
        {
            name                      = "elysflowers:purple_coneflower_1",
            _botanical_name           = "E. purpurea",
            description               = S("Purple Coneflower"),
            longdesc                  = "",
            tiles                     = { "purple_coneflower_1.png" },
            dye                       = "violet",
            mcl_dye                   = "mcl_dyes:purple",
            wield_image               = "purple_coneflower_0.png",
            not_in_creative_inventory = true,
            inventory_image           = "purple_coneflower_0.png",
            selection_box             = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = -0.0274,
                scale = 0.0212,
                spread = { x = 32, y = 32, z = 32 },
                seed = 92731,
                octaves = 1,
                persist = 0.5,
            },
            place_on = { xcompat.materials.dirt_with_grass },
            biomes = { "ExtremeHills", "grassland", "grassytwo", "deciduous_forest", "Plains", "ExtremeHillsM", "ExtremeHills++" },
            spawn_by = "elysflowers:purple_coneflower",
            num_spawn_by = 1,
            sidelen = 16,
            drop                      = "elysflowers:purple_coneflower"
        },
        {
            name = "elysflowers:purple_coneflower",
            _botanical_name = "E. purpurea",
            description = S("Purple Coneflower"),
            longdesc = "",
            tiles = { "purple_coneflower_0.png" },
            wield_image = "purple_coneflower_0.png",
            inventory_image = "purple_coneflower_0.png",
            dye = "violet",
            mcl_dye = "mcl_dyes:purple",
            on_place = function(itemstack, placer, pointed_thing)
                if not pointed_thing or pointed_thing.type ~= "node" then
                    return itemstack
                end

                local variant = math.random(0, 1)
                local pos = pointed_thing.above
                local node_name = "elysflowers" .. ":purple_coneflower_" .. variant

                if variant == 0 then
                    core.set_node(pos, { name = "elysflowers:purple_coneflower" })
                else
                    core.set_node(pos, { name = node_name })
                end
                itemstack:take_item()
                return itemstack
            end,
            selection_box = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = 0.0009451,
                scale = 0.00212,
                spread = { x = 64, y = 32, z = 64 },
                seed = 58177,
                octaves = 2,
                persist = 0.5,
            },
            place_on = { xcompat.materials.dirt_with_grass },
            biomes = { "ExtremeHills", "grassland", "grassytwo", "deciduous_forest", "Plains", "ExtremeHillsM", "ExtremeHills++" },
            sidelen = 16,
            potted = true
        },
        {
            name            = "elysflowers:california_poppy",
            _botanical_name = "E. californica",
            description     = S("California Poppy"),
            drawtype        = "plantlike",
            longdesc        =
            "Perennial with golden domelike blooms, found in arid climates that receive plenty of sunlight and warmth.",
            tiles           = { "california_poppy.png" },
            wield_image     = "california_poppy.png",
            inventory_image = "california_poppy.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = 0.0049,
                scale = 0.0042,
                spread = { x = 16, y = 16, z = 16 },
                seed = 732642,
                octaves = 2,
                persist = 0.3,
            },
            biomes = { "savanna", "mesa", "Savanna", "MesaPlateauF", "MesaPlateauFM_grasstop", "MesaPlateauFM", "everness:baobab_savanna" },
            place_on = { xcompat.materials.dirt_with_grass, "default:dry_dirt", "default:dry_dirt_with_dry_grass", "ethereal:dry_dirt", "everness:dry_dirt_with_dry_grass" },
            sidelen = 16,
            potted = true
        },
        {
            name            = "elysflowers:hyacinth",
            _botanical_name = "Hyacinthus Orientalis",
            description     = S("Hyacinth"),
            longdesc        = "Herbacious & fragrant perennial with alluring purple blooms",
            tiles           = { "hyacinth.png" },
            wield_image     = "hyacinth.png",
            dye             = "blue",
            mcl_dye         = "mcl_dyes:blue",
            inventory_image = "hyacinth.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = -0.0423,
                scale = 0.012,
                spread = { x = 16, y = 16, z = 16 },
                seed = 36945,
                octaves = 2,
                persist = 0.4,
            },
            place_on = { xcompat.materials.dirt_with_grass },
            biomes = { "Taiga", "MegaTaiga", "ExtremeHills", "grassland", "grassytwo", "RoofedForest", "taiga", "coniferous_forest" },
            sidelen = 16,
            potted = true
        },
        {
            name            = "elysflowers:lavender",
            _botanical_name = "Lavandula officinalis",
            description     = S("Lavender"),
            longdesc        = "Herbacious & fragrant perennial with alluring purple blooms",
            tiles           = { "lavender.png" },
            wield_image     = "lavender.png",
            dye             = "violet",
            mcl_dye         = "mcl_dyes:purple",
            inventory_image = "lavender.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = -0.0135193,
                scale = 0.0222,
                spread = { x = 32, y = 32, z = 32 },
                seed = 747423,
                octaves = 1,
                persist = 0.4,
            },
            place_on = { xcompat.materials.dirt_with_grass, "ethereal:bamboo_dirt", "ethereal:grove_dirt" },
            biomes = { "Plains", "ExtremeHills", "grassytwo", "CherryGrove", "bamboo", "meditteranean" },
            potted = true,
            potted_image = "lavender_potted.png"
        },
        {
            name            = "elysflowers:marshmallow",
            _botanical_name = "A. officinalis",
            description     = S("Marshmallow"),
            tiles           = { "marshmallow_1.png" },
            wield_image     = "marshmallow_1.png",
            inventory_image = "marshmallow_1.png",
            dye             = "pink",
            mcl_dye         = "mcl_dyes:pink",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = -0.0496,
                scale = 0.029,
                spread = { x = 32, y = 32, z = 32 },
                seed = 19173,
                octaves = 2,
            },
            place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_rainforest_litter" },
            biomes       = { "swamp", "Swampland", "Swampland_ocean", "swamp", "JungleEdgeM" },
            spawn_by     = { "default:water_source", "mcl_core:water_source" },
            potted = true
        },
        {
            name            = "elysflowers:yarrow_pink",
            _botanical_name = "A. millefolium",
            description     = S("Yarrow"),
            tiles           = { "yarrow.png" },
            wield_image     = "yarrow.png",
            inventory_image = "yarrow.png",
            dye             = "pink",
            mcl_dye         = "mcl_dyes:pink",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = -0.021,
                scale = 0.0019,
                spread = { x = 32, y = 32, z = 32 },
                seed = 86312,
                octaves = 1,
                persist = 0.4,
            },
            place_on = { xcompat.materials.dirt_with_grass },
            spawn_by = { "default:water_source", "mcl_core:water_source" },
            biomes = { "grassland_dunes", "Swampland_shore", "Taiga_beach", "SunflowerPlains_ocean", "Savanna_beach", "coniferous_forest_dunes", "deciduous_forest_shore" },
            potted = true
        },
        {
            name            = "elysflowers:african_marigold",
            _botanical_name = "Tagetes. Erecta",
            description     = S("African Marigold"),
            longdesc        =
            "Mounding Annual. Despite it's name, this flower is actually native to the hot and humid steppes of Latin America, inhabiting a wide variety of tropical and subtropical climates",
            tiles           = { "marigold_1.png" },
            wield_image     = "marigold_1.png",
            inventory_image = "marigold_1.png",
            dye             = "orange",
            mcl_dye         = "mcl_dyes:orange",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
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
            biomes = { "savanna", "Savanna", "mesa", "MesaPlateauF_grasstop", "jumble", "mesa_redwood", "everness:baobab_savanna" },
            potted = true
        },
        {
            name = "elysflowers:arctic_poppy",
            _botanical_name = "P. radicatum",
            description = S("Arctic Poppy"),
            tiles = { "arctic_poppy.png" },
            wield_image = "arctic_poppy.png",
            inventory_image = "arctic_poppy.png",
            dye = "yellow",
            mcl_dye = "mcl_dyes:yellow",
            selection_box = { -0.45, -0.5, -0.35, 0.35, 0.45, 0.35, },
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
            biomes = { "tundra", "taiga", "frost", "Taiga", "ColdTaiga", "IcePlains", "IcePlainsSpikes", "coniferous_forest", "cold_desert" },
            potted = true
        },
        {
            name = "elysflowers:dames_rocket",
            _botanical_name = "H. matronalis",
            description = S("Dame's Rocket"),
            tiles = { "dames_rocket.png" },
            wield_image = "dames_rocket.png",
            inventory_image = "dames_rocket.png",
            dye = "light_grey",
            mcl_dye = "mcl_dyes:light_grey",
            selection_box = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 },
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
            biomes = { "Forest", "deciduous_forest", "RoofedForest", "BirchForest", "deciduous_forest", "grove" },
            spawn_by = { "default:tree", "default:aspen_tree", "default:tree", "mcl_trees:tree", "mcl_core:tree", "mcl_core:birchtree", "mcl_trees:tree_dark_oak", "mcl_core:darktree", "mcl_trees:birch_tree" },
            potted = true
        },
        {
            name = "elysflowers:crocus",
            _botanical_name = "C. sativus",
            description = S("Crocus"),
            tiles = { "crocus.png" },
            wield_image = "crocus.png",
            inventory_image = "crocus.png",
            dye = "violet",
            mcl_dye = "mcl_dyes:purple",
            selection_box = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 },
            noise_params = {
                offset = -0.0287,
                scale = 0.0013,
                spread = { x = 32, y = 32, z = 32 },
                seed = 2323142,
                octaves = 3,
                persist = 0.2,
                flags = { "absvalue" }
            },
            biomes = { "snowy_grassland", "tundra", "taiga", "confierous_forest", "Tundra", "Taiga", "MegaTaiga", "IcePlains" },
            place_on = { xcompat.materials.snow, "default:dirt_with_snow", xcompat.materials.dirt_with_grass,
                "default:permafrost_with_stones",
                "default:permafrost_with_moss", "etheral:cold_dirt"
            },
            potted = true
        },
        {
            name            = "elysflowers:fireweed_4",
            _botanical_name = "C. angustifolium",
            description     = S("Fireweed"),
            longdesc        = "Fireweed",
            tiles           = { "fireweed_3.png" },
            wield_image     = "fireweed_0.png",
            inventory_image = "fireweed_0.png",
            dye             = "magenta",
            mcl_dye         = "mcl_dyes:magenta",
            not_in_creative_inventory = true,
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.10, 0.35, },
            noise_params = {
                offset = -0.1211,
                scale = 0.940,
                spread = { x = 64, y = 64, z = 64 },
                seed = 97822,
                octaves = 1,
                persist = 0.6
            },
            place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
            },
            biomes       = { "taiga_valley", "Taiga_valley" },
            drop            = "elysflowers:fireweed"
        },
        {
            name            = "elysflowers:fireweed_3",
            _botanical_name = "C. angustifolium",
            description     = S("Fireweed"),
            longdesc        = "Fireweed",
            tiles           = { "fireweed_2.png" },
            wield_image     = "fireweed_0.png",
            inventory_image = "fireweed_0.png",
            not_in_creative_inventory = true,
            dye             = "magenta",
            mcl_dye         = "mcl_dyes:magenta",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = -0.09109,
                scale = 0.940,
                spread = { x = 64, y = 64, z = 64 },
                seed = 28912,
                octaves = 1,
                persist = 0.6
            },
            place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
            },
            biomes       = { "taiga_valley", "Taiga_valley" },
            drop            = "elysflowers:fireweed"
        },
        {
            name            = "elysflowers:fireweed_2",
            _botanical_name = "C. angustifolium",
            description     = S("Fireweed"),
            longdesc        = "Fireweed",
            tiles           = { "fireweed_1.png" },
            wield_image     = "fireweed_0.png",
            inventory_image = "fireweed_0.png",
            not_in_creative_inventory = true,
            visual_scale    = 1.5,
            selection_box   = { -0.25, -0.5, -0.25, 0.30, 1.0, 0.30, },
            noise_params = {
                offset = -0.04,
                scale = 0.940,
                spread = { x = 64, y = 64, z = 64 },
                seed = 374142,
                octaves = 2,
                persist = 0.6
            },
            place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
            },
            biomes       = { "taiga_valley", "Taiga_valley" },
            drop            = "elysflowers:fireweed"
        },
        {
            name            = "elysflowers:fireweed",
            _botanical_name = "C. angustifolium",
            description     = S("Fireweed"),
            longdesc        = "Fireweed",
            tiles           = { "fireweed_0.png" },
            dye             = "magenta",
            mcl_dye         = "mcl_dyes:magenta",
            wield_image     = "fireweed_0.png",
            inventory_image = "fireweed_0.png",
            selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = -0.031,
                scale = 0.240,
                spread = { x = 64, y = 64, z = 64 },
                seed = 17822,
                octaves = 2,
                persist = 0.6
            },
            place_on     = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
            },
            biomes       = { "taiga_valley", "Taiga_valley" },
            on_place        = function(itemstack, placer, pointed_thing)
                if not pointed_thing or pointed_thing.type ~= "node" then
                    return itemstack
                end

                local variant = math.random(1, 4)
                local pos = pointed_thing.above
                local node_name = "elysflowers" .. ":fireweed_" .. variant

                if variant == 1 then
                    core.set_node(pos, { name = "elysflowers:fireweed" })
                else
                    core.set_node(pos, { name = node_name })
                end
                itemstack:take_item()
                return itemstack
            end,
            potted = true
        },
        {
            name = "elysflowers:chamomile",
            _botanical_name = "M. chamomilla",
            description = S("chamomile"),
            longdesc = "chamomile",
            tiles = {"chamomile.png"},
            dye = "white",
            mcl_dye = "mcl_dyes:light_grey",
            wield_image = "chamomile.png",
            inventory_image = "chamomile.png",
            selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params = {
                offset = -0.0064239,
                scale = 0.0059872,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 2,
                persist = 0.5,
            },
            sidelen = 16,
            biomes = { "Forest", "deciduous_forest","Plains", "grassland", "BirchForest", "BirchForestM"},
            potted = true
        }
    }
}


-- add botanical names to item descriptions if global setting == yes
local function format_description(dat)
    if dat._botanical_name then
        dat.description = dat.description ..
            "\n" .. core.colorize("#d0ffd0", dat._botanical_name)
    end
end


for a, dat in pairs(elysflowers.nodes) do

    if not core.settings:get("elysflowers_botanical_descriptions") then
        format_description(dat)
    end

    register_plant(dat)

    if dat.potted then
        if gameid == "mineclonia" or gameid == "mineclone2" then
            mcl_flowerpots.register_potted_flower(dat.name,{name = dat.name, desc = dat.description, image = dat.tiles[1] })
        elseif core.global_exists("flowerpot") then
            flowerpot.register_node(dat.name)
        else
    end
    end
end


--dofile(core.get_modpath("elysflowers") .. "/decorations.lua")
