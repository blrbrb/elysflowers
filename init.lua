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

local function register_water_plant(def)
    local groups = { dig_by_boat = 1, destroy_by_lava_flow = 1, dig_by_water = 1, dig_immediate = 3, snappy = 3, plant = 1, deco_block = 1, compostability = 35, floating_node = 3 }
    local waving_def = {}
    if def.not_in_creative_inventory then
        groups["not_in_creative_inventory"] = 1
    else
        groups["not_in_creative_inventory"] = 0
    end
    if def.dye then
        groups["color_" .. def.dye] = 1
    end

    core.register_node(def.name, {
        name                      = def.name,
        _botanical_name           = def._botanical_name,
        description               = def.description,
        drawtype                  = "nodebox",
        _doc_items_longdesc       = def._doc_items_longdesc,
        tiles                     = def.tiles,
        wield_image               = def.wield_image,
        waving                    = 3,
        inventory_image           = def.inventory_image,
        visual_scale              = def.visual_scale,
        paramtype                 = "light",
        paramtype2                = "facedir",
        use_texture_alpha         = "clip",
        buildable_to              = true,
        sunlight_propagates       = true,
        walkable                  = false,
        liquids_pointable         = true,
        groups                    = groups,
        node_placement_prediction = "",
        _mcl_crafting_output      = { single = { output = def.mcl_dye } },
        _sound_def                = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        _pathfinding_class        = "TRAPDOOR",
        on_rotate                 = screwdriver.rotate_simple,
        floodable                 = true,
        selection_box             = {
            type = "fixed",
            fixed = { -7 / 16, -0.5, -7 / 16, 7 / 16, -15 / 32, 7 / 16 }
        },
        node_box                  = {
            type = "fixed",
            fixed = { -0.5, -32 / 64, -0.5, 0.5, -15 / 32, 0.5 }
        },
        drop                      = def.drop,
        on_place                  = function(itemstack, placer, pointed_thing)
            local pos = pointed_thing.above
            local node = core.get_node(pointed_thing.under)
            local bl = core.registered_nodes[node.name]

            if bl and bl.on_rightclick then
                return bl.on_rightclick(pointed_thing.under, node, placer, itemstack,
                    pointed_thing)
            end

            if bl and bl.liquidtype == "source" and
                core.get_item_group(node.name, "water") > 0 then
                local player_name = placer and placer:get_player_name() or ""
                if not core.is_protected(pos, player_name) then
                    core.set_node(pos, {
                        name = def.name ..
                            "",
                        param2 = math.random(0, 3)
                    })
                    if not core.is_creative_enabled(player_name) then
                        itemstack:take_item()
                    end
                else
                    core.chat_send_player(player_name, "Node is protected")
                    core.record_protection_violation(pos, player_name)
                end
            end

            return itemstack
        end,
    })

    core.register_decoration({
        name = def.name,
        deco_type = "simple",
        spawn_by = def.spawn_by or nil,
        waving = 3,
        num_spawn_by = def.num_spawn_by or -1,
        noise_params = def.noise_params,
        place_on = def.place_on or { xcompat.materials.dirt_with_grass },
        sidelen = def.sidelen or 16,
        rotation = "random",
        biomes = def.biomes,
        param2 = 0,
        param2_max = 3,
        flags = "place_center_x, place_center_z, liquid_surface",
        decoration = def.name,
    })
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

    -- in mineclonia based games, items tagged with "flower" are prevented from spawning on anything that isn't in the dirt group by an abm.
    -- Flowers and plants that need to grow in sand, or on snow can't have the tag "flower" because they'll be popped.
    if def._do_not_pop then
        groups["flower"] = 0
    end

    core.register_node(def.name, {
        name                 = def.name,
        _botanical_name      = def._botanical_name,
        description          = def.description,
        drawtype             = "plantlike",
        _doc_items_longdesc  = def._doc_items_longdesc,
        tiles                = def.tiles,
        wield_image          = def.wield_image,
        inventory_image      = def.inventory_image,
        visual_scale         = def.visual_scale,
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        liquids_pointable    = def.liquids_pointable or false,
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

    -- this node is part of a schematic decoration, and should not be registered as a decoration node seperately
    if def.shematic_node then
        return
    end

    core.register_decoration({
        name = def.name,
        deco_type = def.deco_type or "simple",
        spawn_by = def.spawn_by or nil,
        num_spawn_by = def.num_spawn_by or -1,
        noise_params = def.noise_params,
        place_on = def.place_on or { xcompat.materials.dirt_with_grass },
        sidelen = def.sidelen or 16,
        rotation = "random",
        waving = true,
        biomes = def.biomes,
        schematic = def.schematic or nil,
        y_min = def.y_min or 1,
        y_max = def.y_max or 31000,
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
        heat_point = 7,
        weight = 0.29
    })
end



elysflowers = {

    nodes =
    {
        {
            name                = "elysflowers:indian_paintbrush",
            _botanical_name     = "C. coccinea",
            description         = S("Indian Paintbrush"),
            _doc_items_longdesc =
            "Commonly found in temperate prairies",
            tiles               = { "elysflowers_indian_paintbrush.png" },
            wield_image         = "elysflowers_indian_paintbrush.png",
            inventory_image     = "elysflowers_indian_paintbrush.png",
            mcl_dye             = "mcl_dyes:red",
            dye                 = "red",
            selection_box       = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.006227,
                scale = 0.0002343,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 1,
                persist = 0.3,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "default:dry_dirt_with_dry_grass",
                "default:dry_dirt",
                "ethereal:dry_dirt"
                , "ebiomes:dry_dirt_with_dry_grass_arid", "ethereal:prairie_dirt"
            },
            biomes              = { "savanna", "Savanna", "ebiomes:grassland_arid", "MesaPlateauFM_grasstop", "Mesa_sandlevel", "MesaPlateauFM", "mesa_redwood", "prairie", "warm_steppe" },
            spawn_by            = { "mcl_flowers:tallgrass", "default:dry_grass" },
            num_spawn_by        = 2,
            potted              = true
        },
        {
            name            = "elysflowers:forget_me_not",
            _botanical_name = "M. scorpiodies",
            description     = S("forget-me-not"),
            tiles           = { "elysflowers_forget_me_not.png" },
            dye             = "blue",
            mcl_dye         = "mcl_dyes:light_blue",
            wield_image     = "elysflowers_forget_me_not.png",
            inventory_image = "elysflowers_forget_me_not.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00022,
                scale = 0.0029,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 2,
                persist = 0.4
            },
            spawn_by        = { xcompat.materials.water_source },
            num_spawn_by    = 1,
            place_on        = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_cold" },
            biomes          = { "RoofedForest", "Forest", "BirchForest", "BirchForestM", "grassland",
                "deciduous_forest", "coniferous_forest", "grassytwo", "deciduous_forest_cold" },
            potted          = true
        },
        {
            name                = "elysflowers:foxglove",
            _botanical_name     = "D. purpurea",
            description         = S("Foxglove"),
            _doc_items_longdesc =
            "This highly toxic biennial herb is native to British Columbia and was later naturalized in the northern US.\n It produces showy purple and pink bells that dangle in clusters from the sides of the stem. \n Despite it's ornamental nature, foxglove is highly fatal if consumed in excess. It contains chemicals which inhibit neurotransmission. The heart medication, *digitalis* is actually derived from a relative of foxglove",
            tiles               = { "elysflowers_foxglove.png" },
            wield_image         = "elysflowers_foxglove.png",
            dye                 = "grey",
            mcl_dye             = "mcl_dyes:grey",
            inventory_image     = "elysflowers_foxglove.png",
            selection_box       = { -0.25, -0.49, -0.25, 0.25, 0.50, 0.25 },
            noise_params        = {
                offset = -0.003123,
                scale = 0.00414,
                spread = { x = 32, y = 32, z = 64 },
                seed = 881933,
                octaves = 3,
                persist = 0.4,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "default:dirt_with_leaves",
                "woodsoils:grass_with_leaves_1", "ebiomes:dirt_with_grass_cold"
            },
            biomes              = { "Forest", "RoofedForest", "BirchForest", "BirchForestM", "deciduous_forest", "ebiomes:deciduous_forest_cold" },
            sidelen             = 8,
            potted              = true
        },
        {
            name            = "elysflowers:hibiscus",
            _botanical_name = "H. Aponeurus",
            description     = S("Hibiscus"),
            tiles           = { "elysflowers_hibiscus.png" },
            wield_image     = "elysflowers_hibiscus.png",
            inventory_image = "elysflowers_hibiscus.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = -0.00629,
                scale = 0.01412,
                spread = { x = 32, y = 32, z = 32 },
                seed = 2983671,
                octaves = 2,
                persist = 0.5,
            },
            place_on        = { xcompat.materials.dirt_with_grass, "default:dirt_with_rainforest_litter", "everness:dirt_with_grass", "ebiomes:dirt_with_jungle_savanna_grass" },
            biomes          = { "rainforest_ocean",
                "JungleEdge", "JungleEdge_ocean",
                "MangroveSwamp_shore", "JungleM_shore",
                "Jungle_shore", "JungleEdge_ocean", "JungleEdge_deep_ocean", "JungleM_ocean", "Jungle_ocean",
                "rainforest", "japanese_rainforest", "jungle_savanna"
            },
            sidelen         = 16,
            potted          = true
        },
        {
            name            = "elysflowers:larkspur",
            _botanical_name = "D. nuttallianum",
            description     = S("Larkspur"),
            tiles           = { "elysflowers_larkspur.png" },
            dye             = "violet",
            mcl_dye         = "mcl_dyes:purple",
            wield_image     = "elysflowers_larkspur.png",
            inventory_image = "elysflowers_larkspur.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.0009029,
                scale = 0.000212,
                spread = { x = 12, y = 4, z = 12 },
                seed = math.random(),
                octaves = 1,
                persist = 0.5,
            },
            place_on        = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_cold", "ebiomes:dirt_with_grass_steppe_cold" },
            sidelen         = 16,
            biomes          = { "Forest", "BirchForest", "grassland", "deciduous_forest_woody", "deciduous_forest_cold", "grassytwo", "deciduous_forest", "RoofedForest", "coniferous_forest" },
            potted          = true
        },
        {
            name            = "elysflowers:black_eyed_susan",
            _botanical_name = "R. Hertia",
            description     = S("Black-eyed-susan"),
            tiles           = { "elysflowers_black_eyed_susan.png" },
            wield_image     = "elysflowers_black_eyed_susan.png",
            dye             = "yellow",
            mcl_dye         = "mcl_dyes:yellow",
            inventory_image = "elysflowers_black_eyed_susan.png",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00052,
                scale = 0.0019,
                spread = { x = 32, y = 32, z = 32 },
                seed = 91138,
                octaves = 3,
                persist = 0.4
            },
            place_on        = { xcompat.materials.dirt_with_grass, "ethereal:prairie_dirt", "ebiomes:dirt_with_grass_steppe" },
            biomes          = { "SunflowerPlains", "Plains", "grassland", "plains", "savanna", "prairie", "steppe" },
            potted          = true
        },
        {
            name                = "elysflowers:phlox",
            _botanical_name     = "P. drummondii",
            description         = S("Phlox"),
            _doc_items_longdesc = "",
            tiles               = { "elysflowers_phlox.png" },
            dye                 = "violet",
            mcl_dye             = "mcl_dyes:purple",
            wield_image         = "elysflowers_phlox.png",
            inventory_image     = "elysflowers_phlox.png",
            selection_box       = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.00593,
                scale = 0.000015,
                spread = { x = 8, y = 8, z = 8 },
                seed = math.random(),
                octaves = 1,
                persist = 0.0,

            },
            place_on            = { xcompat.materials.dirt_with_grass, "default:dirt_with_leaves",
                "woodsoils:grass_with_leaves_1", "ebiomes:dirt_with_grass_warm"
            },
            biomes              = { "Forest", "deciduous_forest", "RoofedForest", "deciduous_forest_woody", "deciduous_forest_warm" },
            spawn_by            = { "default:tree", "mcl_trees:tree", "mcl_core:tree", "mcl_core:birchtree",
                "mcl_core:darktree", "mcl_trees:tree_dark_oak", "ebiomes:chestnut_tree", "ebiomes:hornbeam_tree",
                "ebiomes:maple_tree"
            },
            num_spawn_by        = 1,
            potted              = true
        },
        {
            name                      = "elysflowers:purple_coneflower_1",
            _botanical_name           = "E. purpurea",
            description               = S("Purple Coneflower"),
            _doc_items_longdesc       = "",
            tiles                     = { "elysflowers_purple_coneflower_1.png" },
            dye                       = "violet",
            mcl_dye                   = "mcl_dyes:purple",
            wield_image               = "elysflowers_purple_coneflower_0.png",
            not_in_creative_inventory = true,
            inventory_image           = "elysflowers_purple_coneflower_0.png",
            selection_box             = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params              = {
                offset = -0.0274,
                scale = 0.0212,
                spread = { x = 32, y = 32, z = 32 },
                seed = 92731,
                octaves = 1,
                persist = 0.5,
            },
            place_on                  = { xcompat.materials.dirt_with_grass, "ethereal:prairie_dirt", "ebiomes:dirt_with_grass_steppe" },
            biomes                    = { "ExtremeHills", "grassland", "grassytwo", "deciduous_forest", "Plains", "ExtremeHillsM", "ExtremeHills++", "prairie", "steppe" },
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
            tiles = { "elysflowers_purple_coneflower_0.png" },
            wield_image = "elysflowers_purple_coneflower_0.png",
            inventory_image = "elysflowers_purple_coneflower_0.png",
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
            place_on = { xcompat.materials.dirt_with_grass, "ethereal:prairie_dirt", "ebiomes:dirt_with_grass_steppe" },
            biomes = { "ExtremeHills", "grassland", "grassytwo", "deciduous_forest", "Plains", "ExtremeHillsM", "ExtremeHills++", "prairie", "steppe" },
            sidelen = 16,
            potted = false
        },
        {
            name                = "elysflowers:california_poppy",
            _botanical_name     = "E. californica",
            description         = S("California Poppy"),
            drawtype            = "plantlike",
            _doc_items_longdesc =
            "The state flower of California, the California poppy is native to the western seaboard of the United States. Before western settlers arrived in California, \n it's rumoured that entire hillsides would turn bright orange due to the immense number of poppies.\n The California Poppy is very drought tolerant, and incredibly responsive to intense sunlight & heat. It can be found growing in any distributed area of grass, desert scrub, or even dry gravel. ",
            tiles               = { "elysflowers_california_poppy.png" },
            wield_image         = "elysflowers_california_poppy.png",
            inventory_image     = "elysflowers_california_poppy.png",
            selection_box       = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = -0.7,
                scale = 0.9,
                spread = { x = 32, y = 64, z = 32 },
                seed = math.random(),
                octaves = 1,
                persist = 0.0,
                flags = { "absvalue, eased" }
            },
            y_min               = 25,
            y_max               = 100,
            biomes              = { "savanna", "mesa", "Savanna", "MesaPlateauF", "MesaPlateauFM_grasstop", "MesaPlateauFM", "everness:baobab_savanna", "warm_steppe", "grassland_arid" },
            place_on            = { xcompat.materials.dirt_with_grass, "default:dry_dirt",
                "default:dry_dirt_with_dry_grass", "ethereal:dry_dirt", "everness:dry_dirt_with_dry_grass",
                "ebiomes:dry_dirt_with_grass_arid_cool", "ebiomes:dirt_with_grass_steppe_warm" },
            sidelen             = 16,
            potted              = true
        },
        {
            name                = "elysflowers:hyacinth",
            _botanical_name     = "Hyacinthus Orientalis",
            description         = S("Hyacinth"),
            _doc_items_longdesc = "Herbacious & fragrant perennial with alluring purple blooms",
            tiles               = { "elysflowers_hyacinth.png" },
            wield_image         = "elysflowers_hyacinth.png",
            dye                 = "blue",
            mcl_dye             = "mcl_dyes:blue",
            inventory_image     = "elysflowers_hyacinth.png",
            selection_box       = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.00423,
                scale = 0.00012,
                spread = { x = 16, y = 16, z = 16 },
                seed = math.random(),
                octaves = 1,
                persist = 0,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_steppe_cold", "ethereal:cold_dirt" },
            biomes              = { "Taiga", "MegaTaiga", "ExtremeHills", "grassland", "RoofedForest", "taiga", "coniferous_forest", "cold_steppe", "grassland_coldish" },
            sidelen             = 16,
            potted              = true
        },
        {
            name                = "elysflowers:lavender",
            _botanical_name     = "L. officinalis",
            description         = S("Lavender"),
            _doc_items_longdesc =
            "Lavender is a staple herb with a tranquilizing aromatic scent. Native lavender needs very cold temperatures in order to reproduce properly.",
            tiles               = { "elysflowers_lavender.png" },
            wield_image         = "elysflowers_lavender.png",
            dye                 = "violet",
            mcl_dye             = "mcl_dyes:purple",
            inventory_image     = "elysflowers_lavender.png",
            selection_box       = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = -0.0135193,
                scale = 0.0222,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 1,
                persist = 0.4,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "ethereal:bamboo_dirt", "ethereal:grove_dirt", "ebiomes:dirt_with_grass_med" },
            biomes              = { "Plains", "ExtremeHills", "grassytwo", "CherryGrove", "bamboo", "mediteranean" },
            potted              = true,
            potted_image        = "elysflowers_lavender_potted.png"
        },
        {
            name                = "elysflowers:marshmallow",
            _botanical_name     = "A. officinalis",
            _doc_items_longdesc =
            "Often mistaken for the gooey sugar treat of the same namesake, 'marshmellows' actually get their name from this flower. \n The roots of the marshmallow contain a tetriary metabolite that may act as a mild numbing agent. \n It was often used by Native Americans as a remedy for sore throat, cooked and sweetened with a mixture of gluten, honey, and sugar.",
            description         = S("Marshmallow"),
            tiles               = { "elysflowers_marshmallow.png" },
            wield_image         = "elysflowers_marshmallow.png",
            inventory_image     = "elysflowers_marshmallow.png",
            dye                 = "pink",
            mcl_dye             = "mcl_dyes:pink",
            selection_box       = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.000496,
                scale = 0.00029,
                spread = { x = 16, y = 16, z = 16 },
                seed = math.random(),
                octaves = 3,
                lacunarity = 1.9,
                persist = 0.7
            },
            place_on            = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_swamp", "default:dirt_with_rainforest_litter", "ebiomes:peat_with_swamp_moss_yellow" },
            biomes              = { "swamp", "Swampland", "Swampland_ocean", "JungleEdgeM", "rainforest", "bog" },
            potted              = true,

        },
        {
            name            = "elysflowers:yarrow_pink",
            _botanical_name = "A. millefolium",
            description     = S("Yarrow"),
            tiles           = { "elysflowers_yarrow.png" },
            wield_image     = "elysflowers_yarrow.png",
            inventory_image = "elysflowers_yarrow.png",
            dye             = "pink",
            mcl_dye         = "mcl_dyes:pink",
            selection_box   = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params    = {
                offset = 0.00021,
                scale = 0.000019,
                spread = { x = 8, y = 8, z = 8 },
                seed = math.random(),
                octaves = 1,
                persist = 0.4,
            },
            place_on        = { xcompat.materials.dirt_with_grass },
            biomes          = { "grassland", "Plains", "Forest", "BirchForest", "BirchForestM", "deciduous_forest", "coniferous_forest", "deciduous_forest_woody" },
            potted          = true
        },
        {
            name                = "elysflowers:african_marigold",
            _botanical_name     = "Tagetes. Erecta",
            description         = S("African Marigold"),
            _doc_items_longdesc =
            "Despite it's name, this flower is actually native to the hot and humid steppes of Latin America, inhabiting a wide variety of tropical and subtropical climates",
            tiles               = { "elysflowers_marigold.png" },
            wield_image         = "elysflowers_marigold.png",
            inventory_image     = "elysflowers_marigold.png",
            dye                 = "orange",
            mcl_dye             = "mcl_dyes:orange",
            selection_box       = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.000545,
                scale = 0.00029,
                spread = { x = 16, y = 8, z = 16 },
                seed = math.random(),
                octaves = 3,
                persist = 0.3,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_warm", "default:dirt_with_dry_grass" },
            biomes              = { "savanna", "Savanna", "mesa", "MesaPlateauF_grasstop", "jumble", "mesa_redwood", "baobab_savanna", "humid_savanna" },
            potted              = true,
            _do_not_pop         = true
        },
        {
            name                = "elysflowers:arctic_poppy",
            _botanical_name     = "P. radicatum",
            description         = S("Arctic Poppy"),
            _doc_items_longdesc =
            "The artic poppy (unsurprisingly) is a tundra flower found throughout large stretches of the North America arctic and sub-arctic.\n It prefers to grow in well-drained dry gravels and loose soils, and has an impressive reputation for being nearly impossible to kill. \n The roots of these flowers have been found alive, extracting nutrients through solid ice!",
            tiles               = { "elysflowers_arctic_poppy.png" },
            wield_image         = "elysflowers_arctic_poppy.png",
            inventory_image     = "elysflowers_arctic_poppy.png",
            dye                 = "yellow",
            mcl_dye             = "mcl_dyes:yellow",
            selection_box       = { -0.45, -0.5, -0.35, 0.35, 0.45, 0.35, },
            noise_params        = {
                offset = 0.00021945,
                scale = 0.0000798134,
                spread = { x = 14, y = 32, z = 14 },
                seed = math.random(),
                octaves = 2,
                persist = 0.6,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "default:permafrost_with_stones",
                "default:permafrost_with_moss",
                "etheral:cold_dirt", "default:snowblock", "mcl_core:snow", "mcl_core:dirt_with_grass_snow",
                "default:dirt_with_snow", "default:dirt_with_coniferous_litter", "ebiomes:dirt_with_grass_steppe_cold",
                "ebiomes:dirt_with_grass_cold"
            },
            biomes              = { "tundra", "taiga", "frost", "Taiga", "ColdTaiga", "IcePlains", "IcePlainsSpikes", "coniferous_forest", "cold_desert", "cold_steppe", "deciduous_forest_cold", "snowy_grassland" },
            potted              = false
        },
        {
            name = "elysflowers:dames_rocket",
            _botanical_name = "H. matronalis",
            description = S("Dame's Rocket"),
            _doc_items_longdesc =
            "This biennial herb is a short-lived, and shade tolerant forest-dweller that can often grow as tall as a standing person! \n The dames rocket produces blooms in early to late spring, which vary in color from off white to bright pink or purple. ",
            tiles = { "elysflowers_dames_rocket.png" },
            wield_image = "elysflowers_dames_rocket.png",
            inventory_image = "elysflowers_dames_rocket.png",
            dye = "grey",
            mcl_dye = "mcl_dyes:grey",
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
                "ethereal:grove_dirt", "ebiomes:dirt_with_grass_warm", "ebiomes:dirt_with_grass_cold"
            },
            biomes = { "Forest", "deciduous_forest", "RoofedForest", "BirchForest", "deciduous_forest", "grove", "deciduous_forest_woody", "deciduous_forest_cold" },
            spawn_by = { "default:tree", "default:aspen_tree", "default:tree", "mcl_trees:tree", "mcl_core:tree",
                "mcl_core:birchtree", "mcl_trees:tree_dark_oak", "mcl_core:darktree", "mcl_trees:birch_tree",
                "ebiomes:oak_tree", "ebiomes:pear_tree", "ebiomes:maple_tree" },
            potted = true
        },
        {
            name = "elysflowers:crocus",
            _botanical_name = "C. sativus",
            description = S("Crocus"),
            _doc_items_longdesc = "Often the first sign of life in the early days of spring, ",
            tiles = { "elysflowers_crocus.png" },
            wield_image = "elysflowers_crocus.png",
            inventory_image = "elysflowers_crocus.png",
            dye = "violet",
            mcl_dye = "mcl_dyes:purple",
            selection_box = { -0.25, -0.5, -0.25, 0.25, 0.3, 0.25 },
            noise_params = {
                offset = 0.000287,
                scale = 0.000013,
                spread = { x = 32, y = 32, z = 32 },
                seed = math.random(),
                octaves = 3,
                persist = 0.2,
                flags = { "absvalue" }
            },
            biomes = { "snowy_grassland", "tundra", "taiga", "confierous_forest", "Tundra", "Taiga", "MegaTaiga",
                "IcePlains", "deciduous_forest_cold", "snowy_grassland",
            },
            place_on = { xcompat.materials.snow, "default:dirt_with_snow", xcompat.materials.dirt_with_grass,
                "default:permafrost_with_stones",
                "default:permafrost_with_moss", "etheral:cold_dirt", "ebiomes:dirt_with_grass_cold",
                "ebiomes:dirt_with_grass_steppe_cold"
            },
            potted = true
        },
        {
            name                      = "elysflowers:fireweed_4",
            _botanical_name           = "C. angustifolium",
            description               = S("Fireweed"),
            _doc_items_longdesc       = "Fireweed",
            tiles                     = { "elysflowers_fireweed_3.png" },
            wield_image               = "elysflowers_fireweed_0.png",
            inventory_image           = "elysflowers_fireweed_0.png",
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
            _doc_items_longdesc       = "Fireweed",
            tiles                     = { "elysflowers_fireweed_2.png" },
            wield_image               = "elysflowers_fireweed_0.png",
            inventory_image           = "elysflowers_fireweed_0.png",
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
            _doc_items_longdesc       = "Fireweed",
            tiles                     = { "elysflowers_fireweed_1.png" },
            wield_image               = "elysflowers_fireweed_0.png",
            inventory_image           = "elysflowers_fireweed_0.png",
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
            name                = "elysflowers:fireweed",
            _botanical_name     = "C. angustifolium",
            description         = S("Fireweed"),
            _doc_items_longdesc = "Fireweed",
            tiles               = { "elysflowers_fireweed_0.png" },
            dye                 = "magenta",
            mcl_dye             = "mcl_dyes:magenta",
            wield_image         = "elysflowers_fireweed_0.png",
            inventory_image     = "elysflowers_fireweed_0.png",
            selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = -0.031,
                scale = 0.240,
                spread = { x = 64, y = 64, z = 64 },
                seed = 17822,
                octaves = 2,
                persist = 0.6
            },
            place_on            = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter"
            },
            biomes              = { "taiga_valley", "Taiga_valley" },
            on_place            = function(itemstack, placer, pointed_thing)
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
            potted              = true
        },
        {
            name                    = "elysflowers:chamomile",
            _botanical_name         = "M. chamomilla",
            description             = S("Chamomile"),
            _doc_items_longdesc     =
            "Chamomile is a common herbal additive. Emitting an alluring fresh apple like scent, the flowerheads of chamomile are used commonly in teas and skincare products.Chamomile is widely naturalized through North America, and can be found in the wild in distributed open areas, on roadsides, fields, irrigation ditches, and shallow riverbanks.",
            _doc_items_create_entry = true,
            tiles                   = { "elysflowers_chamomile.png" },
            dye                     = "grey",
            mcl_dye                 = "mcl_dyes:grey",
            wield_image             = "elysflowers_chamomile.png",
            inventory_image         = "elysflowers_chamomile.png",
            selection_box           = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params            = {
                offset = 0.00014239,
                scale = 0.000059872,
                spread = { x = 8, y = 8, z = 8 },
                seed = math.random(),
                octaves = 2,
                persist = 0.1,
            },
            sidelen                 = 16,
            biomes                  = { "Forest", "deciduous_forest", "deciduous_forest_cold", "grassland", "grassland_coldish", "Plains", "grassland", "BirchForest", "BirchForestM", "SunflowerPlains", "ExtremeHills" },
            place_on                = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_cold" },
            potted                  = true
        },
        {
            name                = "elysflowers:rose_pogonia",
            _botanical_name     = "P. ophioglossoides",
            description         = S("Rose Pogonia"),
            _doc_items_longdesc =
            "Native to the cooler damp forests of the great lakes basin \n this showy orchid is often refered to as the 'snake-mouth plant' because of the peculiar geometry of it's bloom. \n The American romantic era poet Henry David Thoreau once allegedly remaked that the rose pogonia '...smells exactly like a snake.' ",
            tiles               = { "elysflowers_rose_pogonia.png" },
            dye                 = "grey",
            mcl_dye             = "mcl_dyes:grey",
            wield_image         = "elysflowers_rose_pogonia.png",
            inventory_image     = "elysflowers_rose_pogonia.png",
            selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.00041998,
                scale = 0.00024332,
                spread = { x = 16, y = 16, z = 16 },
                seed = math.random(),
                octaves = 1,
                persist = 0.1,
            },
            sidelen             = 16,
            place_on            = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter", "ebiomes:dirt_with_grass_cold" },
            biomes              = { "coniferous_forest", "deciduous_forest_cold", "BirchForest",
                "BirchForestM", "Taiga",
                "taiga_valley", "Taiga_valley",
                "Taiga_beach", "deciduous_forest_cold" },
            potted              = true
        },
        {
            name                = "elysflowers:yellow_bell",
            _botanical_name     = "T. stans",
            description         = S("Yellow Bell"),
            _doc_items_longdesc = "",
            tiles               = { "elysflowers_yellow_bell.png" },
            dye                 = "yellow",
            mcl_dye             = "mcl_dyes:yellow",
            wield_image         = "elysflowers_yellow_bell.png",
            inventory_image     = "elysflowers_yellow_bell.png",
            selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.000182020,
                scale = 0.000114512,
                spread = { x = 16, y = 16, z = 16 },
                seed = math.random(),
                octaves = 2,
                persist = 0.39,
            },
            sidelen             = 16,
            place_on            = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter" },
            biomes              = { "coniferous_forest", "BirchForest", "BirchForestM", "Taiga",
                "taiga_valley", "Taiga_valley",
                "Taiga_beach" },
            potted              = true
        }, {
        name                = "elysflowers:bergamot",
        _botanical_name     = "P. ophioglossoides",
        description         = S("bergamot"),
        _doc_items_longdesc = "bergamot",
        tiles               = { "elysflowers_bergamot.png" },
        dye                 = "violet",
        mcl_dye             = "mcl_dyes:purple",
        wield_image         = "elysflowers_bergamot.png",
        inventory_image     = "elysflowers_bergamot.png",
        selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        noise_params        = {
            offset = 0.000277660,
            scale = 0.00021572,
            spread = { x = 32, y = 32, z = 32 },
            seed = math.random(),
            octaves = 1,
            persist = 0.29,
        },
        place_on            = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter", "ebiomes:dirt_with_grass_cold", "ebiomes:dirt_with_grass_steppe" },
        biomes              = { "Forest", "BirchForest", "BirchForestM", "grassland", "Plains", "ExtremeHills", "ExtremeHills++", "Taiga", "grassland_coldish", "steppe" },
        potted              = false
    },
        {
            name                = "elysflowers:cold_desert_phlox",
            _botanical_name     = "P. stansburyi",
            description         = S("Cold Desert Phlox"),
            _doc_items_longdesc =
            "This perennial herb is native to dry arid regions of the American southwest, as it's name suggests \n cold desert phlox can often be found among the desert scrub",
            tiles               = { "elysflowers_cold_desert_phlox.png" },
            dye                 = "violet",
            mcl_dye             = "mcl_dyes:purple",
            wield_image         = "elysflowers_cold_desert_phlox.png",
            inventory_image     = "elysflowers_cold_desert_phlox.png",
            selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.0000277660,
                scale = 0.000091572,
                spread = { x = 16, y = 8, z = 16 },
                seed = math.random(),
                octaves = 2,
                persist = 0.7,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "default:silver_sand", "default:sand" },
            biomes              = { "cold_desert", "Taiga", "ebiomes:cold_desert_buffer" },
            potted              = true
        },
        {
            name                = "elysflowers:western_bleeding_heart",
            _botanical_name     = "D. formosa",
            description         = S("Western Bleeding-Heart"),
            _doc_items_longdesc =
            "This orchid was introduced to North America from Japan. \n It has since colonized much of the western seaboard from British Columbia all the way to southern California. \n Prefers to grow in damp, heavily shaded areas.",
            tiles               = { "elysflowers_western_bleeding_heart.png" },
            dye                 = "pink",
            mcl_dye             = "mcl_dyes:pink",
            wield_image         = "elysflowers_western_bleeding_heart.png",
            inventory_image     = "elysflowers_western_bleeding_heart.png",
            selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.0009469,
                scale = 0.0001,
                spread = { x = 8, y = 8, z = 8 },
                seed = math.random(),
                octaves = 1,
                persist = 0.2,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_swamp", "ebiomes:dirt_with_jungle_savanna_grass", "ebiomes:dirt_with_forest_litter", "ebiomes:peat_with_swamp_moss_yellow" },
            biomes              = { "Swampland", "swamp", "MangroveSwamp", "JungleEdge", "JungleEdgeM", "RoofedForest", "rainforest_swamp", "rainforest", "jungle_savanna", "temperate_rainforest", "bog" },
            potted              = true
        },
        {
            name                = "elysflowers:siberian_chive",
            _botanical_name     = "A. schoenoprasum",
            description         = S("Siberian Chive"),
            _doc_items_longdesc =
            "This grassy herb is native to the upper stretches of the Yukon\n, althought it can be found as far south as Ontario.\n The siberian chive is found most commonly in the wild near mountain streams, and cool damp meadows.\n The siberan chive was registered by the Vermont State office of Fish & Wildlife as an endangered species in 2024. \n See, https://www.vtfishandwildlife.com",
            tiles               = { "elysflowers_siberian_chive.png" },
            dye                 = "violet",
            mcl_dye             = "mcl_dyes:purple",
            wield_image         = "elysflowers_siberian_chive.png",
            inventory_image     = "elysflowers_siberian_chive.png",
            selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.00469,
                scale = 0.00049,
                spread = { x = 16, y = 16, z = 16 },
                seed = math.random(),
                octaves = 2,
                persist = 0.5,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "default:permafrost_with_moss", "default:dirt_with_coniferous_litter", "ebiomes:dirt_with_grass_cold" },
            biomes              = { "Taiga", "coniferous_forest", "deciduous_forest_cold", "MegaSpruceTaiga", "taiga", "tundra", "snowy_grassland", "ColdTaiga", "grassland_coldish" },
            potted              = true
        }, {
        name                = "elysflowers:evening_primrose",
        _botanical_name     = "",
        description         = S("Evening Primrose"),
        _doc_items_longdesc =
        "The common evening primrose is native to eastern and central North America. The flowers open in the evening, and close by noon.\n It can be found scattered in fields, alongside roads, in irrigation ditches, and just about anywhere that gets enough light and water across North America.",
        tiles               = { "elysflowers_evening_primrose.png" },
        dye                 = "yellow",
        mcl_dye             = "mcl_dyes:yellow",
        wield_image         = "elysflowers_evening_primrose.png",
        inventory_image     = "elysflowers_evening_primrose.png",
        selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        noise_params        = {
            offset = -0.0008121,
            scale = 0.0000212314,
            spread = { x = 16, y = 16, z = 16 },
            seed = math.random(),
            octaves = 1,
            persist = 0.4,
            flags = { "eased" }
        },
        place_on            = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter" },
        biomes              = { "Plains", "Forest", "RoofedForest", "JungleEdgeM", "JungleEdge", "ExtremeHills", "ExtremeHills++", "MegaSpruceTaiga", "Taiga", "taiga", "tundra", "grassland", "grassland_coldish" },
        potted              = true
    },
        {
            name                = "elysflowers:yellow_flag",
            _botanical_name     = "L. pseudoacorus",
            description         = S("Yellow Flag"),
            _doc_items_longdesc =
            "The yellow flag is recognized as an invasive species of iris in North America. \n The yellow flag iris is highly tolerant of low oxygen, and high salinity enviornments. It prefers to grow in salt or freshwater marshes or along river and stream banks.",
            tiles               = { "elysflowers_yellow_flag.png" },
            dye                 = "yellow",
            mcl_dye             = "mcl_dyes:yellow",
            wield_image         = "elysflowers_yellow_flag.png",
            inventory_image     = "elysflowers_yellow_flag.png",
            selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.0004794,
                scale = 0.000059197,
                spread = { x = 24, y = 16, z = 24 },
                seed = math.random(),
                octaves = 2,
                persist = 0.1,
            },
            place_on            = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_swamp", "ebiomes:dirt_with_forest_litter" },
            biomes              = { "Swampland", "JungleEdge", "JungleEdgeM", "rainforest", "MangroveSwamp", "rainforest", "swamp", "temperate_rainforest", "bog", "jumble" },
            potted              = true
        }, {
        name                = "elysflowers:beach_heath",
        _botanical_name     = "",
        description         = S("Beach Heath"),
        _doc_items_longdesc = "",
        tiles               = { "elysflowers_beach_heath.png" },
        dye                 = "yellow",
        mcl_dye             = "mcl_dyes:yellow",
        wield_image         = "elysflowers_beach_heath.png",
        inventory_image     = "elysflowers_beach_heath.png",
        selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        noise_params        = {
            offset = 0.0004794,
            scale = 0.029197,
            spread = { x = 16, y = 32, z = 16 },
            seed = math.random(),
            octaves = 2,
            persist = 0.2,
            flags = { "absvalue", "eased" }
        },
        place_on            = { xcompat.materials.sand, "mcl_core:redsand", "default:red_sand" },
        _do_not_pop         = true,
        biomes              = { "Savanna", "grassland_ocean", "Forest_beach", "Forest_shore", "Jungle_shore",
            "Plains_beach", "FlowerForest_beach",
            "ExtremeHills_beach", "grassland_dunes", "mediteranean_ocean", "deciduous_forest_shore",
            "deciduous_forest_ocean",
            "deciduous_forest_warm_shore", "mediteranean_dunes", "grove_ocean" },
        potted              = false
    }, {
        name                = "elysflowers:glacier_lilly",
        _botanical_name     = "",
        description         = S("Glacier Lilly"),
        _doc_items_longdesc = "",
        tiles               = { "elysflowers_glacier_lilly.png" },
        dye                 = "yellow",
        mcl_dye             = "mcl_dyes:yellow",
        wield_image         = "elysflowers_glacier_lilly.png",
        inventory_image     = "elysflowers_glacier_lilly.png",
        selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        noise_params        = {
            offset = 0.0081,
            scale = 0.062041,
            spread = { x = 8, y = 8, z = 8 },
            seed = math.random(),
            octaves = 4,
            persist = 0.9,
            lacunarity = 1.0,
            flags = { "absvalue", "eased" }
        },
        spawn_by            = { "mcl_core:snow", "mcl_core:dirt_with_grass_snow", "default:snow", "default:dirt_with_snow" },
        num_spawn_by        = 1,
        place_on            = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter", "ebiomes:dirt_with_grass_steppe_cold", "ebiomes:dirt_with_grass_steppe", "ebiomes:dirt_with_grass_cold" },
        --We want this to be placed NEAR snow, on the borders of biomes which are dominated by snow. IcePlains and ColdTaiga are often
        -- surrounded by Plains, ExtremeHills etc. And these biomes have suitable grass nodes directly adjacent to snow.
        biomes              = { "ColdTaiga", "taiga", "coniferous_forest", "tundra",
            "Taiga", "IcePlains", "ExtremeHills+",
            "ExtremeHills++", "Plains", "snowy_grassland", "grassland", "cold_steppe", "deciduous_forest_cold" },
        potted              = true
    }, {
        name                = "elysflowers:western_trilium",
        _botanical_name     = "T. ovatum",
        description         = S("Trilium"),
        _doc_items_longdesc = "",
        tiles               = { "elysflowers_western_trilium.png" },
        dye                 = "grey",
        mcl_dye             = "mcl_dyes:grey",
        wield_image         = "elysflowers_western_trilium.png",
        inventory_image     = "elysflowers_western_trilium.png",
        selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        noise_params        = {
            offset = 0.00052091,
            scale = 0.00091310,
            spread = { x = 16, y = 16, z = 16 },
            seed = math.random(),
            octaves = 2,
            persist = 0.9,
            lacunarity = 1.4,
            --flags = { "absvalue", "eased" }
        },
        place_on            = { xcompat.materials.dirt_with_grass, "default:dirt_with_coniferous_litter", },
        biomes              = { "taiga", "coniferous_forest", "tundra", "Taiga", "ExtremeHills+", "MegaSpruceTaiga", "MegaSpruceTaigaM" },
        potted              = true
    },
        {
            name                = "elysflowers:virginia_spiderwort",
            _botanical_name     = "T. virginiana",
            description         = S("Spiderwort"),
            _doc_items_longdesc = "",
            tiles               = { "elysflowers_virginia_spiderwort.png" },
            dye                 = "white",
            mcl_dye             = "mcl_dyes:purple",
            wield_image         = "elysflowers_virginia_spiderwort.png",
            inventory_image     = "elysflowers_virginia_spiderwort.png",
            selection_box       = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params        = {
                offset = 0.00022091,
                scale = 0.0000721483,
                spread = { x = 8, y = 16, z = 8 },
                seed = math.random(),
                octaves = 3,
                persist = 0.94,
                lacunarity = 1.4,
                flags = { "eased" }
            },
            place_on            = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_warm", "ebiomes:dirt_with_rainforest_litter", "ebiomes:dirt_with_grass_swamp", "ebiomes:dirt_with_grass_warm" },
            biomes              = { "deciduous_forest", "deciduous_forest_warm", "RoofedForest", "temperate_rainforest", "swamp" },
            potted              = true
        },
        {
            name               = "elysflowers:hedgehog_cactus",
            _botanical_name    = "E. englemannii",
            description        = S("Hedgehog Cactus"),
            _doc_item_longdesc = "",
            tiles              = { "elysflowers_hedgehog_cactus.png" },
            dye                = "violet",
            mcl_dye            = "mcl_dyes:purple",
            wield_image        = "elysflowers_hedgehog_cactus.png",
            inventory_image    = "elysflowers_hedgehog_cactus.png",
            selection_box      = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params       = {
                offset = 0.0008024291,
                scale = 0.00002210311,
                spread = { x = 16, y = 8, z = 16 },
                seed = math.random(),
                octaves = 4,
                persist = 0.209,
                lacunarity = 1.33,
            },
            place_on           = { xcompat.materials.sand, "default:desert_sand", "mcl_core:redsand", "default:red_sand", "ebiomes:dry_dirt_with_dry_grass_arid" },
            biomes             = { "desert", "mesa", "Desert", "", "Mesa", "sandstone_desert", "MesaPlateauFM", "MesaPlateauF" },
            potted             = true,
            _do_not_pop        = true,
        },
        {
            name               = "elysflowers:western_springbeauty",
            _botanical_name    = "C. lanceolata",
            description        = S("Western Springbeauty"),
            _doc_item_longdesc = "",
            tiles              = { "elysflowers_western_springbeauty.png" },
            dye                = "grey",
            mcl_dye            = "mcl_dyes:grey",
            wield_image        = "elysflowers_western_springbeauty.png",
            inventory_image    = "elysflowers_western_springbeauty.png",
            selection_box      = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
            noise_params       = {
                offset = 0.0497108,
                scale = 0.000904821,
                spread = { x = 16, y = 4, z = 16 },
                seed = math.random(),
                octaves = 2,
                persist = 0.12,
                lacunarity = 0.2,
            },
            -- Claytonia are commonly found on alpine slopes, and arid steppes with very gravely soils.
            spawn_by           = { xcompat.materials.dirt_with_grass },
            num_spawn_by       = 1,
            place_on           = { xcompat.materials.gravel, "ebiomes:dirt_with_grass_arid", "ebiomes:dirt_with_grass_arid_cool" },
            biomes             = { "StoneBeach", "ExtremeHillsM", "ExtremeHills++", "ExtremeHills", "StoneBeach", "grassland_arid" },
            potted             = true,
            _do_not_pop        = true,
        }, {
        name               = "elysflowers:tree_cholla",
        _botanical_name    = "C. Imbricata",
        description        = S("Tree Cholla"),
        _doc_item_longdesc = "",
        tiles              = { "elysflowers_tree_cholla.png" },
        dye                = "",
        mcl_dye            = "",
        wield_image        = "elysflowers_tree_cholla.png",
        inventory_image    = "elysflowers_tree_cholla.png",
        potted_image       = "elysflowers_tree_cholla_potted.png",
        selection_box      = { -0.25, -0.4, -0.25, 0.25, 0.90, 0.25 },
        visual_scale       = 1.5,
        noise_params       = {
            offset = 0.00064200,
            scale = 0.000214606,
            spread = { x = 16, y = 4, z = 16 },
            seed = math.random(),
            octaves = 6,
            persist = 0.871,
            lacunarity = 0.756,
        },
        place_on           = { xcompat.materials.sand, "mcl_core:redsand", "default:desert_sand", "default:red_sand" },
        biomes             = { "Desert", "desert", "MesaPlateauF", "Mesa" },
        potted             = true,
        _do_not_pop        = true,
    },
        {
            name               = "elysflowers:desert_plume",
            _botanical_name    = "S. Pinnata",
            description        = S("Desert Plume"),
            _doc_item_longdesc = "",
            tiles              = { "elysflowers_desert_plume.png" },
            dye                = "yellow",
            mcl_dye            = "mcl_dyes:yellow",
            wield_image        = "elysflowers_desert_plume.png",
            inventory_image    = "elysflowers_desert_plume.png",
            selection_box      = { -0.35, -0.4, -0.35, 0.25, 0.40, 0.35 },
            noise_params       = {
                offset = 0.000097812,
                scale = 0.000244716,
                spread = { x = 32, y = 4, z = 32 },
                seed = math.random(),
                octaves = 8,
                persist = 0.92,
                lacunarity = 0.056,
            },
            place_on           = { xcompat.materials.sand, "mcl_core:redsand", "default:desert_sand", "default:red_sand", "ebiomes:dirt_with_grass_arid", "everness:mineral_sands" },
            biomes             = { "Desert", "desert", "MesaPlateauF", "Mesa", "grassland_arid", "mesa", "everness:mineral_waters", "MesaPlateauF_sandlevel" },
            potted             = true,
            _do_not_pop        = true,
        },
        {
            name               = "elysflowers:canada_violet",
            _botanical_name    = "O. Digyna",
            description        = S("Canada Violet"),
            _doc_item_longdesc = "",
            tiles              = { "elysflowers_canada_violet.png" },
            dye                = "white",
            mcl_dye            = "mcl_dyes:white",
            wield_image        = "elysflowers_canada_violet.png",
            inventory_image    = "elysflowers_canada_violet.png",
            selection_box      = { -0.35, -0.4, -0.35, 0.25, 0.40, 0.35 },
            noise_params       = {
                offset = 0.000190944,
                scale = 0.000717701,
                spread = { x = 24, y = 6, z = 24 },
                seed = math.random(),
                octaves = 4,
                persist = 0.69,
                lacunarity = 0.21,
            },
            place_on           = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_cold", "default:dirt_with_coniferous_litter" },
            biomes             = { "deciduous_forest", "Taiga", "Taiga_valley", "deciduous_forest_cold" },
            potted             = true,
        },
        {
            name               = "elysflowers:prairie_clover",
            _botanical_name    = "D. purpurea",
            description        = S("Prairie Clover"),
            _doc_item_longdesc = "",
            tiles              = { "elysflowers_prairie_clover.png" },
            dye                = "",
            mcl_dye            = "",
            wield_image        = "elysflowers_prairie_clover.png",
            inventory_image    = "elysflowers_prairie_clover.png",
            selection_box      = { -0.35, -0.4, -0.35, 0.25, 0.40, 0.35 },
            noise_params       = {
                offset = 0.000178129,
                scale = 0.00084902,
                spread = { x = 24, y = 12, z = 24 },
                seed = math.random(),
                octaves = 4,
                persist = 0.7,
                lacunarity = 0.062,
            },
            place_on           = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_cold", "ebiomes:dirt_with_grass_steppe", "default:dirt_with_coniferous_litter", "ethereal:prairie_dirt" },
            biomes             = { "prairie", "steppe", "grassland", "Plains", "steppe" },
            potted             = true,
        }, {
        name               = "elysflowers:calla_lily",
        _botanical_name    = "C. palustris",
        description        = S("Calla Lily"),
        _doc_item_longdesc = "",
        tiles              = { "elysflowers_calla_lily.png" },
        dye                = "",
        mcl_dye            = "",
        wield_image        = "elysflowers_calla_lily.png",
        inventory_image    = "elysflowers_calla_lily.png",
        selection_box      = { -0.35, -0.4, -0.35, 0.25, 0.40, 0.35 },
        noise_params       = {
            offset = 0.00042071,
            scale = 0.00059122,
            spread = { x = 7, y = 12, z = 7 },
            seed = math.random(),
            octaves = 6,
            persist = 0.491,
            lacunarity = 0.081,
        },
        spawn_by           = { xcompat.materials.water_source },
        num_spawn_by       = 1,
        place_on           = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_swamp", "ebiomes:peat_with_swamp_moss_yellow", "ebiomes:dirt_with_grass_cold" },
        biomes             = { "deciduous_forest", "deciduous_forest_cold", "deciduous_forest_woody", "bog", "swamp", "BirchForest", "BirchForestM", "woodytwo", "CherryGrove" },
        potted             = false,
    },
        {
            name               = "elysflowers:yellow_star_thistle",
            _botanical_name    = "C. solstitialis",
            description        = S("Yellow Star Thistle"),
            _doc_item_longdesc = "",
            tiles              = { "elysflowers_yellow_star_thistle.png" },
            dye                = "yellow",
            mcl_dye            = "mcl_dyes:yellow",
            wield_image        = "elysflowers_yellow_star_thistle.png",
            inventory_image    = "elysflowers_yellow_star_thistle.png",
            selection_box      = { -0.35, -0.4, -0.35, 0.25, 0.40, 0.35 },
            noise_params       = {
                offset = 0.0002909,
                scale = 0.00014341,
                spread = { x = 12, y = 8, z = 12 },
                seed = math.random(),
                octaves = 3,
                persist = 0.203,
                lacunarity = 0.040,
            },
            place_on           = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_warm", "default:dirt_with_dry_grass", "default:dry_dirt_with_dry_grass", "ethereal:prairie_dirt", "ebiomes:dry_dirt_with_grass_arid" },
            biomes             = { "savanna", "Savanna", "steppe", "prairie", "grassland_arid_cool", "cold_steppe" },
            potted             = true,
        },
        {
            name               = "elysflowers:goldenrod",
            _botanical_name    = "S. nemoralis",
            description        = S("Goldenrod"),
            _doc_item_longdesc = "",
            tiles              = { "elysflowers_goldenrod_0.png" },
            dye                = "yellow",
            mcl_dye            = "mcl_dyes:yellow",
            wield_image        = "elysflowers_goldenrod_0.png",
            inventory_image    = "elysflowers_goldenrod_0.png",
            selection_box      = { -0.25, -0.5, -0.25, 0.30, 0.5, 0.30, },
            noise_params       = {
                offset = -0.0471,
                scale = 0.054340,
                spread = { x = 1, y = 1, z = 1 },
                seed = 9458745,
                octaves = 2,
                persist = 0.0,
                flags = { "absvalue", "eased" }
            },
            place_on           = { xcompat.materials.dirt_with_grass, "ebiomes:dirt_with_grass_warm", "default:dirt_with_dry_grass", "default:dry_dirt_with_dry_grass", "ethereal:prairie_dirt", "ebiomes:dry_dirt_with_grass_arid" },
            biomes             = { "steppe", "prairie", "grassland", "Plains", "" },
            on_place           = function(itemstack, placer, pointed_thing)
                if not pointed_thing or pointed_thing.type ~= "node" then
                    return itemstack
                end

                local variant = math.random(0, 2)
                local pos = pointed_thing.above
                local node_name = "elysflowers" .. ":goldenrod_" .. variant

                if variant == 0 then
                    core.set_node(pos, { name = "elysflowers:goldenrod" })
                else
                    core.set_node(pos, { name = node_name })
                end
                itemstack:take_item()
                return itemstack
            end,
            potted             = false,
            schematic_node     = true
        },
    },
    water_plants = { {
        name               = "elysflowers:water_buttercup",
        _botanical_name    = "",
        description        = S("Water Buttercup"),
        _doc_item_longdesc = "",
        tiles              = { "elysflowers_water_buttercup.png", "elysflowers_water_buttercup_back.png" },
        wield_image        = "elysflowers_water_buttercup.png",
        inventory_image    = "elysflowers_water_buttercup.png",
        noise_params       = {
            offset = 0.0241291,
            scale = 0.000417701,
            spread = { x = 32, y = 12, z = 32 },
            seed = math.random(),
            octaves = 3,
            persist = 0.29,
            lacunarity = 0.406,
        },
        place_on           = { "default:water_source", "mcl_core:water_source" },
        biomes             = { "Forest", "Swampland", "Forest_beach", "BirchForestM", "BirchForest", "Plains_beach",
            "MangroveSwamp_shore", "Jungle_shore", "ExtremeHills_beach", "mediteranean_dunes", "deciduous_forest",
            "deciduous_forest_woody", "japanese_rainforest_shore", "japanese_rainforest", "bamboo",
            "grassytwo" },
    } }
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

for a, dat in pairs(elysflowers.water_plants) do
    if not core.settings:get("elysflowers_botanical_descriptions") then
        format_description(dat)
    end

    register_water_plant(dat)
end
