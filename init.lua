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
        _doc_items__doc_items_longdesc  = def._doc_items_longdesc,
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
        spawn_by = { "" } or def.spawn_by,
        num_spawn_by = 0 or def.num_spawn_by,
        noise_params = def.noise_params,
        place_on = def.place_on or { xcompat.materials.dirt_with_grass },
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
            _botanical_name = "C. coccinea",
            description     = S("Indian Paintbrush"),
            _doc_items_longdesc        =
            "Commonly found in temperate praries",
            tiles           = { "indian_paintbrush.png" },
            wield_image     = "indian_paintbrush.png",
            inventory_image = "indian_paintbrush.png",
            mcl_dye         = "mcl_dyes:red",
            dye             = "red",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.006227,
                scale = 0.0002343,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 1,
                persist = 0.3,
            },
            place_on        = { xcompat.materials.dirt_with_grass, "default:dry_dirt_with_dry_grass", "default:dry_dirt",
                "ethereal:dry_dirt",
                "everness:dry_dirt_with_dry_grass", "everness:mineral_sand"
            },
            biomes          = { "savanna", "Savanna", "everness:baobab_savanna", "everness:mineral_springs", "MesaPlateauFM_grasstop", "Mesa_sandlevel", "MesaPlateauFM", "mesa_redwood" },
            spawn_by        = { "mcl_flowers:tallgrass", "default:dry_grass" },
            num_spawn_by    = 2,
            potted          = true
        },
        {
            name            = "elysflowers:forget_me_not",
            _botanical_name = "M. scorpiodies",
            description     = S("forget-me-not"),
            tiles           = { "forget_me_not.png" },
            dye             = "blue",
            mcl_dye         = "mcl_dyes:light_blue",
            wield_image     = "forget_me_not.png",
            inventory_image = "forget_me_not.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00022,
                scale = 0.0029,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 2,
                persist = 0.4
            },
            spawn_by = {xcompat.materials.water_source}, 
            num_spawn_by =1,
            place_on        = { xcompat.materials.dirt_with_grass, },
            biomes          = { "RoofedForest", "Forest", "BirchForest", "BirchForestM", "grassland",
                "deciduous_forest", "coniferous_forest", "grassytwo" },
            potted          = true
        },
        {
            name             = "elysflowers:foxglove",
            _botanical_name  = "D. purpurea",
            description      = S("Foxglove"),
            _doc_items_longdesc = "This highly toxic biennial herb is native to British Columbia and was later naturalized in the northern US.\n It produces showy purple and pink bells that dangle in clusters from the sides of the stem. \n Despite it's ornamental nature, foxglove is highly fatal if consumed in excess. It contains chemicals which inhibit neurotransmission. The heart medication, *digitalis* is actually derived from a relative of foxglove",
            tiles            = { "foxglove2.png" },
            wield_image      = "foxglove2.png",
            dye              = "pink",
            mcl_dye          = "mcl_dyes:pink",
            inventory_image  = "foxglove2.png",
            selection_box    = { -0.25, -0.49, -0.25, 0.25, 0.50, 0.25 },
            noise_params     = {
                offset = -0.003123,
                scale = 0.00414,
                spread = { x = 32, y = 32, z = 64 },
                seed = 881933,
                octaves = 3,
                persist = 0.4,
            },
            place_on         = { xcompat.materials.dirt_with_grass, "default:dirt_with_leaves",
                "woodsoils:grass_with_leaves_1"
            },
            biomes           = { "Forest", "RoofedForest", "BirchForest", "BirchForestM", "deciduous_forest" },
            sidelen          = 8,
            potted           = true
        },
        {
            name            = "elysflowers:hibiscus",
            _botanical_name = "H. Aponeurus",
            description     = S("Hibiscus"),
            tiles           = { "hibiscus_flower.png" },
            wield_image     = "hibiscus_flower.png",
            inventory_image = "hibiscus_flower.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = -0.00629,
                scale = 0.01412,
                spread = { x = 32, y = 32, z = 32 },
                seed = 2983671,
                octaves = 2,
                persist = 0.5,
            },
            place_on        = { xcompat.materials.dirt_with_grass, "default:dirt_with_rainforest_litter", "everness:dirt_with_grass" },
            biomes          = { "rainforest_ocean", "Forest_beach", "everness:bamboo_forest", "Swampland_ocean", "Swampland_deep_ocean", "Swampland_shore", "JungleEdge", "JungleEdge_ocean", "Savanna_beach", "Plains_beach", "MangroveSwamp_shore", "JungleM_shore", "Jungle_shore", "JungleEdge_ocean", "JungleEdge_deep_ocean", "JungleM_ocean", "Jungle_ocean", "savanna_shore", "savanna_ocean", "sandstone_desert_ocean", "desert_ocean", "rainforest" },
            sidelen         = 16,
            potted          = true
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
            noise_params    = {
                offset = -0.09029,
                scale = 0.0212,
                spread = { x = 32, y = 32, z = 32 },
                seed = 22269,
                octaves = 1,
                persist = 0.5,
            },
            place_on        = { xcompat.materials.dirt_with_grass },
            sidelen         = 16,
            biomes          = { "Forest", "BirchForest", "grassland", "grassytwo", "deciduous_forest", "RoofedForest", "coniferous_forest" },
            potted          = true
        },
        {
            name            = "elysflowers:black_eyed_susan",
            _botanical_name = "R. Hertia",
            description     = S("Black-eyed-susan"),
            tiles           = { "black_eyed_susan.png" },
            wield_image     = "black_eyed_susan.png",
            dye             = "yellow",
            mcl_dye         = "mcl_dyes:yellow",
            inventory_image = "black_eyed_susan.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00052,
                scale = 0.0019,
                spread = { x = 32, y = 32, z = 32 },
                seed = 91138,
                octaves = 3,
                persist = 0.4
            },
            place_on        = { xcompat.materials.dirt_with_grass },
            biomes          = { "SunflowerPlains", "Plains", "grassland", "plains", "savanna" },
            potted          = true
        },
        {
            name            = "elysflowers:phlox",
            _botanical_name = "P. drummondii",
            description     = S("Phlox"),
            _doc_items_longdesc = "",
            tiles           = { "phlox.png" },
            dye             = "violet",
            mcl_dye         = "mcl_dyes:purple",
            wield_image     = "phlox.png",
            inventory_image = "phlox.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00593,
                scale = 0.000015,
                spread = { x = 8, y = 8, z = 8 },
                seed = math.random(),
                octaves = 1,
                persist = 0.0,

            },
            place_on        = { xcompat.materials.dirt_with_grass, "default:dirt_with_leaves",
                "woodsoils:grass_with_leaves_1"
            },
            biomes          = { "Forest", "coniferous_forest", "RoofedForest" },
            spawn_by        = { "default:tree", "mcl_trees:tree", "mcl_core:tree", "mcl_core:birchtree", "mcl_core:darktree", "mcl_trees:tree_dark_oak" },
            num_spawn_by    = 1,
            potted          = true
        },
        {
            name                      = "elysflowers:purple_coneflower_1",
            _botanical_name           = "E. purpurea",
            description               = S("Purple Coneflower"),
            _doc_items_longdesc       = "",
            tiles                     = { "purple_coneflower_1.png" },
            dye                       = "violet",
            mcl_dye                   = "mcl_dyes:purple",
            wield_image               = "purple_coneflower_0.png",
            not_in_creative_inventory = true,
            inventory_image           = "purple_coneflower_0.png",
            selection_box             = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params              = {
                offset = -0.0274,
                scale = 0.0212,
                spread = { x = 32, y = 32, z = 32 },
                seed = 92731,
                octaves = 1,
                persist = 0.5,
            },
            place_on                  = { xcompat.materials.dirt_with_grass },
            biomes                    = { "ExtremeHills", "grassland", "grassytwo", "deciduous_forest", "Plains", "ExtremeHillsM", "ExtremeHills++" },
            spawn_by                  = "elysflowers:purple_coneflower",
            num_spawn_by              = 1,
            sidelen                   = 16,
            drop                      = "elysflowers:purple_coneflower"
        },
        {
            name = "elysflowers:purple_coneflower",
            _botanical_name = "E. purpurea",
            description = S("Purple Coneflower"),
            _doc_items_longdesc = "",
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
            potted = false
        },
        {
            name            = "elysflowers:california_poppy",
            _botanical_name = "E. californica",
            description     = S("California Poppy"),
            drawtype        = "plantlike",
            _doc_items_longdesc        = "The state flower of California, the California poppy is native to the western seaboard of the United States. Before western settlers arrived in California, \n it's rumoured that entire hillsides would turn bright orange due to the immense number of poppies.\n The California Poppy is very drought tolerant, and incredibly responsive to intense sunlight & heat. It can be found growing in any distributed area of grass, desert scrub, or even dry gravel. ",
            tiles           = { "california_poppy.png" },
            wield_image     = "california_poppy.png",
            inventory_image = "california_poppy.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
           noise_params = {
			offset = -0.7,
			scale = 1.5,
			spread = {x = 32, y = 64, z = 32},
			seed = math.random(),
			octaves = 1,
			persist = 0.0,
			flags = "absvalue, eased"
		},
	    y_min = 25,
	    y_max = 100,
            biomes          = { "savanna", "mesa", "Savanna", "MesaPlateauF", "MesaPlateauFM_grasstop", "MesaPlateauFM", "everness:baobab_savanna" },
            place_on        = { xcompat.materials.dirt_with_grass, "default:dry_dirt", "default:dry_dirt_with_dry_grass", "ethereal:dry_dirt", "everness:dry_dirt_with_dry_grass" },
            sidelen         = 16,
            potted          = true
        },
        {
            name            = "elysflowers:hyacinth",
            _botanical_name = "Hyacinthus Orientalis",
            description     = S("Hyacinth"),
            _doc_items_longdesc        = "Herbacious & fragrant perennial with alluring purple blooms",
            tiles           = { "hyacinth.png" },
            wield_image     = "hyacinth.png",
            dye             = "blue",
            mcl_dye         = "mcl_dyes:blue",
            inventory_image = "hyacinth.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00423,
                scale = 0.00012,
                spread = { x = 16, y = 16, z = 16 },
                seed = math.random(),
                octaves = 1,
                persist = 0,
            },
            place_on        = { xcompat.materials.dirt_with_grass },
            biomes          = { "Taiga", "MegaTaiga", "ExtremeHills", "grassland", "grassytwo", "RoofedForest", "taiga", "coniferous_forest" },
            sidelen         = 16,
            potted          = true
        },
        {
            name            = "elysflowers:lavender",
            _botanical_name = "L. officinalis",
            description     = S("Lavender"),
            _doc_items_longdesc        = "Lavender is a staple herb with a tranquilizing aromatic scent. Native lavender needs very cold temperatures in order to reproduce properly.",
            tiles           = { "lavender.png" },
            wield_image     = "lavender.png",
            dye             = "violet",
            mcl_dye         = "mcl_dyes:purple",
            inventory_image = "lavender.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = -0.0135193,
                scale = 0.0222,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 1,
                persist = 0.4,
            },
            place_on        = { xcompat.materials.dirt_with_grass, "ethereal:bamboo_dirt", "ethereal:grove_dirt" },
            biomes          = { "Plains", "ExtremeHills", "grassytwo", "CherryGrove", "bamboo", "meditteranean" },
            potted          = true,
            potted_image    = "lavender_potted.png"
        },
        {
            name            = "elysflowers:marshmallow",
            _botanical_name = "A. officinalis",
            _doc_items_longdesc = "Often mistaken for the gooey sugar treat of the same namesake, 'marshmellows' actually get their name from this flower. \n The roots of the marshmallow contain a tetriary metabolite that may act as a mild numbing agent. \n It was often used by Native Americans as a remedy for sore throat, cooked and sweetened with a mixture of gluten, honey, and sugar.",
            description     = S("Marshmallow"),
            tiles           = { "marshmallow.png" },
            wield_image     = "marshmallow.png",
            inventory_image = "marshmallow.png",
            dye             = "pink",
            mcl_dye         = "mcl_dyes:pink",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = -0.0496,
                scale = 0.029,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 2,
            },
            place_on        = { xcompat.materials.dirt_with_grass, "default:dirt_with_rainforest_litter" },
            biomes          = { "swamp", "Swampland", "Swampland_ocean", "swamp", "JungleEdgeM" },
            spawn_by        = { "default:water_source", "mcl_core:water_source" },
            potted          = true
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
            noise_params    = {
                offset = -0.021,
                scale = 0.0019,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 1,
                persist = 0.4,
            },
            place_on        = { xcompat.materials.dirt_with_grass },
            spawn_by        = { "default:water_source", "mcl_core:water_source" },
            biomes          = { "grassland_dunes", "Swampland_shore", "Taiga_beach", "SunflowerPlains_ocean", "Savanna_beach", "coniferous_forest_dunes", "deciduous_forest_shore" },
            potted          = true
        },
        {
            name            = "elysflowers:african_marigold",
            _botanical_name = "Tagetes. Erecta",
            description     = S("African Marigold"),
            _doc_items_longdesc        = "Despite it's name, this flower is actually native to the hot and humid steppes of Latin America, inhabiting a wide variety of tropical and subtropical climates",
            tiles           = { "marigold.png" },
            wield_image     = "marigold.png",
            inventory_image = "marigold.png",
            dye             = "orange",
            mcl_dye         = "mcl_dyes:orange",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = -0.00545,
                scale = 0.00029,
                spread = { x = 16, y = 16, z = 16 },
                seed = math.random(),
                octaves = 1,
                persist = 0.2,
            },
            place_on        = { xcompat.materials.dirt_with_grass, "default:dry_dirt", "default:dirt_with_dry_grass", "ethereal:dry_dirt", "everness:dry_dirt_with_dry_grass" },
            biomes          = { "savanna", "Savanna", "mesa", "MesaPlateauF_grasstop", "jumble", "mesa_redwood", "everness:baobab_savanna" },
            potted          = true
        },
        {
            name = "elysflowers:arctic_poppy",
            _botanical_name = "P. radicatum",
            description = S("Arctic Poppy"),
             _doc_items_longdesc        = "The artic poppy (unsurprisingly) is a tundra flower found throughout large stretches of the North America arctic and sub-arctic.\n It prefers to grow in well-drained dry gravels and loose soils, and has an impressive reputation for being nearly impossible to kill. \n The roots of these flowers have been found alive, extracting nutrients through solid ice!",
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
            place_on = { xcompat.materials.dirt_with_grass, "default:permafrost_with_stones",
                "default:permafrost_with_moss",
                "etheral:cold_dirt", "default:snowblock",
                "default:dirt_with_snow", "default:dirt_with_coniferous_litter"
            },
            biomes = { "tundra", "taiga", "frost", "Taiga", "ColdTaiga", "IcePlains", "IcePlainsSpikes", "coniferous_forest", "cold_desert" },
            potted = false
        },
        {
            name = "elysflowers:dames_rocket",
            _botanical_name = "H. matronalis",
            description = S("Dame's Rocket"),
            _doc_items_longdesc = "This biennial herb is a short-lived, and shade tolerant forest-dweller that can often grow as tall as a standing person! \n The dames rocket produces blooms in early to late spring, which vary in color from off white to bright pink or purple. ",
            tiles = { "dames_rocket.png" },
            wield_image = "dames_rocket.png",
            inventory_image = "dames_rocket.png",
            dye = "light_grey",
            mcl_dye = "mcl_dyes:light_grey",
            selection_box = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 },
            noise_params = {
                offset = -0.0127,
                scale = 0.020,
                spread = { x = 64, y = 64, z = 64 },
                seed = math.random(),
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
            _doc_items_longdesc = "Often the first sign of life in the early days of spring, ",
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
            name                      = "elysflowers:fireweed_4",
            _botanical_name           = "C. angustifolium",
            description               = S("Fireweed"),
            _doc_items_longdesc                  = "Fireweed",
            tiles                     = { "fireweed_3.png" },
            wield_image               = "fireweed_0.png",
            inventory_image           = "fireweed_0.png",
            dye                       = "magenta",
            mcl_dye                   = "mcl_dyes:magenta",
            not_in_creative_inventory = true,
            selection_box             = { -0.35, -0.5, -0.35, 0.35, 0.10, 0.35, },
            noise_params              = {
                offset = -0.1211,
                scale = 0.940,
                spread = { x = 64, y = 64, z = 64 },
                seed = 97822,
                octaves = 1,
                persist = 0.6
            },
            place_on                  = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
            },
            biomes                    = { "taiga_valley", "Taiga_valley" },
            drop                      = "elysflowers:fireweed"
        },
        {
            name                      = "elysflowers:fireweed_3",
            _botanical_name           = "C. angustifolium",
            description               = S("Fireweed"),
            _doc_items_longdesc                  = "Fireweed",
            tiles                     = { "fireweed_2.png" },
            wield_image               = "fireweed_0.png",
            inventory_image           = "fireweed_0.png",
            not_in_creative_inventory = true,
            dye                       = "magenta",
            mcl_dye                   = "mcl_dyes:magenta",
            selection_box             = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params              = {
                offset = -0.09109,
                scale = 0.940,
                spread = { x = 64, y = 64, z = 64 },
                seed = 28912,
                octaves = 1,
                persist = 0.6
            },
            place_on                  = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
            },
            biomes                    = { "taiga_valley", "Taiga_valley" },
            drop                      = "elysflowers:fireweed"
        },
        {
            name                      = "elysflowers:fireweed_2",
            _botanical_name           = "C. angustifolium",
            description               = S("Fireweed"),
            _doc_items_longdesc                  = "Fireweed",
            tiles                     = { "fireweed_1.png" },
            wield_image               = "fireweed_0.png",
            inventory_image           = "fireweed_0.png",
            not_in_creative_inventory = true,
            visual_scale              = 1.5,
            selection_box             = { -0.25, -0.5, -0.25, 0.30, 1.0, 0.30, },
            noise_params              = {
                offset = -0.04,
                scale = 0.940,
                spread = { x = 64, y = 64, z = 64 },
                seed = 374142,
                octaves = 2,
                persist = 0.6
            },
            place_on                  = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
            },
            biomes                    = { "taiga_valley", "Taiga_valley" },
            drop                      = "elysflowers:fireweed"
        },
        {
            name            = "elysflowers:fireweed",
            _botanical_name = "C. angustifolium",
            description     = S("Fireweed"),
            _doc_items_longdesc        = "Fireweed",
            tiles           = { "fireweed_0.png" },
            dye             = "magenta",
            mcl_dye         = "mcl_dyes:magenta",
            wield_image     = "fireweed_0.png",
            inventory_image = "fireweed_0.png",
            selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = -0.031,
                scale = 0.240,
                spread = { x = 64, y = 64, z = 64 },
                seed = 17822,
                octaves = 2,
                persist = 0.6
            },
            place_on        = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
            },
            biomes          = { "taiga_valley", "Taiga_valley" },
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
            potted          = true
        },
        {
            name            = "elysflowers:chamomile",
            _botanical_name = "M. chamomilla",
            description     = S("chamomile"),
            _doc_items_longdesc        = "Chamomile is a common herbal additive. Emitting an alluring fresh apple like scent, the flowerheads of chamomile are used commonly in teas and skincare products. \n Chamomile is widely naturalized through North America, and can be found in the wild in distributed open areas, on roadsides, fields, irrigation ditches, and shallow riverbanks.",
            tiles           = { "chamomile.png" },
            dye             = "white",
            mcl_dye         = "mcl_dyes:light_grey",
            wield_image     = "chamomile.png",
            inventory_image = "chamomile.png",
            selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00014239,
                scale = 0.000059872,
                spread = { x = 8, y = 8, z = 8 },
                seed = math.random(),
                octaves = 2,
                persist = 0.1,
            },
            sidelen         = 16,
            biomes          = { "Forest", "deciduous_forest", "Plains", "grassland", "BirchForest", "BirchForestM", "SunflowerPlains", "ExtremeHills" },
            place_on = {xcompat.materials.dirt_with_grass},
            potted          = true
        },
        {
            name            = "elysflowers:rose_pogonia",
            _botanical_name = "P. ophioglossoides",
            description     = S("rose pogonia"),
            _doc_items_longdesc        = "Native to the cooler damp forests of the great lakes basin \n this showy orchid is often refered to as the 'snake-mouth plant' because of the peculiar geometry of it's bloom. \n The American romantic era poet Henry David Thoreau once allegedly remaked that the rose pogonia '...smells exactly like a snake.' ",
            tiles           = { "rose_pogonia.png" },
            dye             = "white",
            mcl_dye         = "mcl_dyes:light_grey",
            wield_image     = "rose_pogonia.png",
            inventory_image = "rose_pogonia.png",
            selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00041998,
                scale = 0.00024332,
                spread = { x = 16, y = 16, z = 16 },
                seed = math.random(),
                octaves = 1,
                persist = 0.1,
            },
            sidelen         = 16,
            place_on        = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter" },
            biomes          = { "coniferous_forest","deciduos_forest", "BirchForest", "BirchForestM", "Taiga","taiga_valley", "Taiga_valley",
                "Taiga_beach" },
            potted          = true
        },
        {
            name            = "elysflowers:yellow_bell",
            _botanical_name = "T. stans",
            description     = S("yellow bell"),
            _doc_items_longdesc        = "yellow bell",
            tiles           = { "yellow_bell.png" },
            dye             = "yellow",
            mcl_dye         = "mcl_dyes:yellow",
            wield_image     = "yellow_bell.png",
            inventory_image = "yellow_bell.png",
            selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00182020,
                scale = 0.00114512,
                spread = { x = 16, y = 16, z = 16 },
                seed = math.random(),
                octaves = 2,
                persist = 0.39,
            },
            sidelen         = 16,
            place_on        = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter" },
            biomes          = { "coniferous_forest", "BirchForest", "BirchForestM", "Taiga",
                "taiga_valley", "Taiga_valley",
                "Taiga_beach" },
            potted          = true
        }, {
        name            = "elysflowers:bergamot",
        _botanical_name = "P. ophioglossoides",
        description     = S("bergamot"),
        _doc_items_longdesc        = "bergamot",
        tiles           = { "bergamot.png" },
        dye             = "violet",
        mcl_dye         = "mcl_dyes:purple",
        wield_image     = "bergamot.png",
        inventory_image = "bergamot.png",
        selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        noise_params    = {
            offset = -0.0277660,
            scale = 0.0021572,
            spread = { x = 32, y = 32, z = 32 },
            seed = math.random(),
            octaves = 3,
            persist = 0.29,
        },
        sidelen         = 16,
        place_on        = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter" },
        biomes          = { "Forest", "BirchForest", "BirchForestM", "grassland", "Plains", "ExtremeHills" },
        potted          = false
    },
    {
        name            = "elysflowers:cold_desert_phlox",
        _botanical_name = "P. stansburyi",
        description     = S("Cold Desert Phlox"),
        _doc_items_longdesc        = "This perennial herb is native to dry arid regions of the American southwest, as it's name suggests \n cold desert phlox can often be found among the desert scrub",
        tiles           = { "cold_desert_phlox.png" },
        dye             = "violet",
        mcl_dye         = "mcl_dyes:purple",
        wield_image     = "cold_desert_phlox.png",
        inventory_image = "cold_desert_phlox.png",
        selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        noise_params    = {
            offset = 0.00277660,
            scale = 0.00021572,
            spread = { x = 8, y = 8, z = 8 },
            seed = math.random(),
            octaves = 2,
            persist = 0.0,
        },
        sidelen         = 16,
        place_on        = { xcompat.materials.dirt_with_grass,"default:silver_sand", "default:sand"},
        biomes          = { "cold_desert", "Taiga" },
        potted          = true
    },
    {
        name            = "elysflowers:western_bleeding_heart",
        _botanical_name = "D. formosa",
        description     = S("Western Bleeding-Heart"),
        _doc_items_longdesc        = "This orchid was introduced to North America from Japan. \n It has since colonized much of the western seaboard from British Columbia all the way to southern California. \n Prefers to grow in damp, heavily shaded areas.",
        tiles           = { "western_bleeding_heart.png" },
        dye             = "pink",
        mcl_dye         = "mcl_dyes:pink",
        wield_image     = "western_bleeding_heart.png",
        inventory_image = "western_bleeding_heart.png",
        selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        noise_params    = {
            offset = 0.0009469,
            scale = 0.0001,
            spread = { x = 8, y = 8, z = 8 },
            seed = math.random(),
            octaves = 1,
            persist = 0.2,
        },
        place_on        = { xcompat.materials.dirt_with_grass},
        biomes          = { "Swampland","MangroveSwamp","JungleEdge", "JungleEdgeM","RoofedForest","rainforest_swamp","rainforest"},
        potted          = true
    }, 
    {
        name            = "elysflowers:siberian_chive",
        _botanical_name = "A. schoenoprasum",
        description     = S("Siberian Chive"),
        _doc_items_longdesc        = "This grassy herb is native to the upper stretches of the Yukon\n, althought it can be found as far south as Ontario.\n The siberian chive is found most commonly in the wild near mountain streams, and cool damp meadows.\n The siberan chive was registered by the Vermont State office of Fish & Wildlife as an endangered species in 2024. \n See, https://www.vtfishandwildlife.com",
        tiles           = { "siberian_chive.png" },
        dye             = "violet",
        mcl_dye         = "mcl_dyes:purple",
        wield_image     = "siberian_chive.png",
        inventory_image = "siberian_chive.png",
        selection_box   = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        noise_params    = {
            offset = 0.000469,
            scale = 0.00049,
            spread = { x = 16, y = 16, z = 16 },
            seed = math.random(),
            octaves = 2,
            persist = 0.1,
        },
        place_on        = { xcompat.materials.dirt_with_grass, "default:dirt_with_snow" , "default:permafrost_with_moss", "default:dirt_with_coniferous_litter"},
        biomes          = { "Taiga","MegaSpruceTaiga","taiga", "tundra"},
        potted          = true
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
            if dat.potted_image then
                mcl_flowerpots.register_potted_flower(dat.name,
                    { name = dat.name, desc = dat.description, image = dat.potted_image })
            else
                mcl_flowerpots.register_potted_flower(dat.name,
                    { name = dat.name, desc = dat.description, image = dat.tiles[1] })
            end
        elseif core.global_exists("flowerpot") then
            flowerpot.register_node(dat.name)
        else
        end
    end
end


