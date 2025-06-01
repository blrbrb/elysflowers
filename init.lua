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


--register biomes
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
    nodes = { {
        name                 = "elysflowers:babys_breath",
        _botanical_name      = "G. Repens",
        description          = S("baby's breath"),
        drawtype             = "plantlike",
        _doc_items_longdesc  = "Baby's Breath",
        tiles                = { "babys_breath.png" },
        wield_image          = "babys_breath.png",
        inventory_image      = "babys_breath.png",
        waving               = 1,
        visual_scale         = 0.9,
        paramtype            = "light",
        sunlight_propagates  = false,
        walkable             = false,
        groups               = { snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_white = 1, compostability = 35 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:white" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name                 = "elysflowers:babys_breath_2",
        _botanical_name      = "G. Repens",
        description          = S("Baby's Breath"),
        drawtype             = "plantlike",
        _doc_items_longdesc  = "Baby's Breath",
        tiles                = { "babys_breath_2.png" },
        wield_image          = "babys_breath.png",
        inventory_image      = "babys_breath.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = false,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_white = 1, deco_block = 1, compostability = 35, not_in_creative_inventory = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:white" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.4, -0.35, 0.35, 0.10, 0.35 },
        },
        drop                 = "elysflowers:babys_breath"
    }, {
        name                 = "elysflowers:fireweed",
        _botanical_name      = "C. angustifolium",
        description          = S("Fireweed"),
        drawtype             = "plantlike",
        _doc_items_longdesc  = "Fireweed",
        tiles                = { "fireweed_0.png" },
        wield_image          = "fireweed_0.png",
        inventory_image      = "fireweed_0.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = false,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, deco_block = 1, color_violet = 1, compostability = 45 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:magenta" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },

        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.4, -0.35, 0.35, 0.40, 0.35 },
        },
        on_place             = function(itemstack, placer, pointed_thing)
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
        end
    }, {
        name                 = "elysflowers:fireweed_2",
        _botanical_name      = "C. angustifolium",
        description          = S("Fireweed"),
        drawtype             = "plantlike",
        _doc_items_longdesc  = "Fireweed",
        tiles                = { "fireweed_1.png" },
        wield_image          = "fireweed_0.png",
        inventory_image      = "fireweed_0.png",
        waving               = 1,
        visual_scale         = 1.5,
        paramtype            = "light",
        sunlight_propagates  = false,
        light_source         = 2,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, place_flowerlike = 1, deco_block = 1, color_violet = 1, compostability = 45, not_in_creative_inventory = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:magenta" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.25, -0.5, -0.25, 0.30, 1.0, 0.30 },
        },
        drop                 = "elysflowers:fireweed"
    }, {
        name                 = "elysflowers:fireweed_3",
        _botanical_name      = "C. angustifolium",
        description          = S("Fireweed"),
        drawtype             = "plantlike",
        _doc_items_longdesc  = "Fireweed",
        tiles                = { "fireweed_2.png" },
        wield_image          = "fireweed_0.png",
        inventory_image      = "fireweed_0.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = false,
        light_source         = 2,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, deco_block = 1, color_violet = 1, place_flowerlike = 1, compostability = 45, not_in_creative_inventory = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:magenta" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        },
        drop                 = "elysflowers:fireweed"
    }, {
        name                 = "elysflowers:fireweed_4",
        _botanical_name      = "C. angustifolium",
        description          = S("Fireweed"),
        drawtype             = "plantlike",
        _doc_items_longdesc  = "Fireweed",
        tiles                = { "fireweed_3.png" },
        wield_image          = "fireweed_0.png",
        inventory_image      = "fireweed_0.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        light_source         = 2,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, deco_block = 1, place_flowerlike = 1, color_violet = 1, compostability = 45, not_in_creative_inventory = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:magenta" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.10, 0.35 },
        },
        drop                 = "elysflowers:fireweed"
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
        groups = { dig_immediate = 3, snappy = 3, flammable = 2, deco_block = 1, place_flowerlike = 1, flower = 1, flora = 1, color_violet = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:purple" } },
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
        groups = { dig_immediate = 3, snappy = 3, deco_block = 1, flammable = 2, flower = 1, flora = 1, color_white = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:light_grey" } },
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
        groups = { dig_immediate = 3, snappy = 3, flammable = 2, deco_block = 1, flower = 1, flora = 1, color_yellow = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:yellow" } },
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
        name                 = "elysflowers:african_marigold",
        _botanical_name      = "T. Erecta",
        description          = S("African Marigold"),
        drawtype             = "plantlike",
        long_description     =
        "Mounding Annual. Despite it's name, this flower is actually native to the hot and humid steppes of Latin America, inhabiting a wide variety of tropical and subtropical climates",
        tiles                = { "marigold.png" },
        wield_image          = "marigold.png",
        inventory_image      = "marigold.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, deco_block = 1, flower = 1, flora = 1, color_yellow = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:orange" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        -- drop = def.drop or nil,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name                 = "elysflowers:golden_groundsel",
        _botanical_name      = "P. aurea",
        description          = S("Golden Groundsel"),
        drawtype             = "plantlike",
        long_description     =
        "Herbacious mounding perennial, with many tiny yellow blooms. It can be found dotting the floors of decidious forests with sunflower like foliage",
        tiles                = { "groundsel.png" },
        wield_image          = "groundsel.png",
        inventory_image      = "groundsel.png",
        waving               = 1,
        visual_scale         = 1.4,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, deco_block = 1, flora = 1, color_yellow = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:yellow" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        -- drop = def.drop or nil,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        },
    }, {
        name                 = "elysflowers:yarrow_pink",
        _botanical_name      = "A. millefolium",
        description          = S("Yarrow"),
        drawtype             = "plantlike",
        tiles                = { "yarrow.png" },
        wield_image          = "yarrow.png",
        inventory_image      = "yarrow.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, deco_block = 1, flora = 1, color_pink = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:pink" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        },
    }, {
        name                 = "elysflowers:marshmallow",
        _botanical_name      = "A. officinalis",
        description          = S("Marshmallow"),
        drawtype             = "plantlike",
        tiles                = { "marshmallow.png" },
        wield_image          = "marshmallow.png",
        inventory_image      = "marshmallow.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, color_pink = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:pink" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        },
    }, {
        name                 = "elysflowers:lavender",
        _botanical_name      = "L. officinalis",
        description          = S("Lavender"),
        drawtype             = "plantlike",
        _doc_items_longdesc  = "Herbacious & fragrant perennial with alluring purple blooms",
        long_description     =
        "Herbacious & fragrant perennial with alluring purple blooms. Can be found growing in cooler biomes, in open fields.",
        tiles                = { "lavender.png" },
        wield_image          = "lavender.png",
        inventory_image      = "lavender.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_violet = 1, compostability = 75 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:purple" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name                 = "elysflowers:hyacinth",
        _botanical_name      = "",
        description          = S("Hyacinth"),
        drawtype             = "plantlike",
        _doc_items_longdesc  = "Herbacious & fragrant perennial with alluring purple blooms",
        long_description     =
        "Herbacious & fragrant perennial with alluring purple blooms. Can be found growing in cooler biomes, in open fields.",
        tiles                = { "hyacinth.png" },
        wield_image          = "hyacinth.png",
        inventory_image      = "hyacinth.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, deco_block = 1, flora = 1, plant = 1, color_blue = 1, compostability = 75 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:dark_blue" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name                 = "elysflowers:california_poppy",
        _botanical_name      = "E. californica",
        description          = S("California Poppy"),
        drawtype             = "plantlike",
        _doc_items_longdesc  =
        "Perennial with golden domelike blooms, found in arid climates that receive plenty of sunlight and warmth.",
        long_description     =
        "",
        tiles                = { "california_poppy.png" },
        wield_image          = "california_poppy.png",
        inventory_image      = "california_poppy.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, deco_block = 1, plant = 1, color_orange = 1, compostability = 75 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:orange" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name = "elysflowers:purple_coneflower",
        _botanical_name = "E. purpurea",
        description = S("Purple Coneflower"),
        drawtype = "plantlike",
        _doc_items_longdesc =
        "",
        long_description =
        "",
        tiles = { "purple_coneflower_0.png" },
        wield_image = "purple_coneflower_0.png",
        inventory_image = "purple_coneflower_0.png",
        waving = 1,
        paramtype = "light",
        sunlight_propagates = true,
        walkable = false,
        groups = { dig_immediate = 3, snappy = 3, flammable = 2, flora = 1, deco_block = 1, plant = 1, color_purple = 1, compostability = 75 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:purple" } },
        _sound_def = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable = true,
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
        selection_box = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    }, {
        name                 = "elysflowers:purple_coneflower_1",
        _botanical_name      = "E. purpurea",
        description          = S("Purple Coneflower"),
        drawtype             = "plantlike",
        _doc_items_longdesc  =
        "",
        long_description     =
        "",
        tiles                = { "purple_coneflower_1.png" },
        wield_image          = "purple_coneflower_0.png",
        inventory_image      = "purple_coneflower_0.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, seagrass = 1, flora = 1, deco_block = 1, plant = 1, color_orange = 1, compostability = 75, not_in_creative_inventory = 1 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:purple" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        },
        drop                 = "elysflowers:purple_coneflower"
    }, {
        name                 = "elysflowers:phlox",
        _botanical_name      = "P. drummondii",
        description          = S("Phlox"),
        drawtype             = "plantlike",
        _doc_items_longdesc  = "",
        long_description     =
        "Charming, abundant blooms on tall stems.",
        tiles                = { "phlox.png" },
        wield_image          = "phlox.png",
        inventory_image      = "phlox.png",
        waving               = 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_violet = 1, compostability = 75 },
        _mcl_crafting_output = { single = { output = "mcl_dyes:purple" } },
        _sound_def           = {
            key = "node_sound_leaves_defaults",
            input = {},
        },
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
        }
    },
        {
            name                 = "elysflowers:black_eyed_susan",
            _botanical_name      = "R. Hertia",
            description          = S("Black-eyed-susan"),
            drawtype             = "plantlike",
            _doc_items_longdesc  = "",
            long_description     =
            "Commonly found in temperate praries",
            tiles                = { "black_eyed_susan.png" },
            wield_image          = "black_eyed_susan.png",
            inventory_image      = "black_eyed_susan.png",
            waving               = 1,
            paramtype            = "light",
            sunlight_propagates  = true,
            walkable             = false,
            groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_violet = 1, compostability = 75 },
            _mcl_crafting_output = { single = { output = "mcl_dyes:yellow" } },
            _sound_def           = {
                key = "node_sound_leaves_defaults",
                input = {},
            },
            floodable            = true,
            selection_box        = {
                type = "fixed",
                fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            }
        },
        {
            name                 = "elysflowers:forget_me_not",
            _botanical_name      = "C. Amabile",
            description          = S("Chinese Forget-me-not"),
            drawtype             = "plantlike",
            _doc_items_longdesc  = "",
            long_description     =
            "",
            tiles                = { "forget_me_not.png" },
            wield_image          = "forget_me_not.png",
            inventory_image      = "forget_me_not.png",
            waving               = 1,
            paramtype            = "light",
            sunlight_propagates  = true,
            walkable             = false,
            groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_violet = 1, compostability = 75 },
            _mcl_crafting_output = { single = { output = "mcl_dyes:light_blue" } },
            _sound_def           = {
                key = "node_sound_leaves_defaults",
                input = {},
            },
            floodable            = true,
            selection_box        = {
                type = "fixed",
                fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            }
        },
        {
            name                 = "elysflowers:larkspur",
            _botanical_name      = "D. nuttallianum",
            description          = S("Larkspur"),
            drawtype             = "plantlike",
            _doc_items_longdesc  = "",
            long_description     =
            "",
            tiles                = { "larkspur.png" },
            wield_image          = "larkspur.png",
            inventory_image      = "larkspur.png",
            waving               = 1,
            paramtype            = "light",
            sunlight_propagates  = true,
            walkable             = false,
            groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_violet = 1, compostability = 75 },
            _mcl_crafting_output = { single = { output = "mcl_dyes:purple" } },
            _sound_def           = {
                key = "node_sound_leaves_defaults",
                input = {},
            },
            floodable            = true,
            selection_box        = {
                type = "fixed",
                fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            }
        },
        {
            name                 = "elysflowers:hibiscus",
            _botanical_name      = "D. nuttallianum",
            description          = S("Hibiscus"),
            drawtype             = "plantlike",
            _doc_items_longdesc  = "",
            long_description     =
            "",
            tiles                = { "hibiscus_flower.png" },
            wield_image          = "hibiscus_flower.png",
            inventory_image      = "hibiscus_flower.png",
            waving               = 1,
            paramtype            = "light",
            sunlight_propagates  = true,
            walkable             = false,
            groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_pink = 1, compostability = 30 },
            _mcl_crafting_output = { single = { output = "mcl_dyes:pink" } },
            _sound_def           = {
                key = "node_sound_leaves_defaults",
                input = {},
            },
            floodable            = true,
            selection_box        = {
                type = "fixed",
                fixed = { -0.35, -0.5, -0.35, 0.35, 0.40, 0.35 },
            }
        },
        {
            name                 = "elysflowers:foxglove",
            _botanical_name      = "Digitalis. purpurea",
            description          = S("Foxglove"),
            drawtype             = "plantlike",
            _doc_items_longdesc  = "Careful this plant is poisonous!",
            long_description     =
            "",
            tiles                = { "foxglove2.png" },
            wield_image          = "foxglove2.png",
            inventory_image      = "foxglove2.png",
            waving               = 1,
            paramtype            = "light",
            sunlight_propagates  = true,
            walkable             = false,
            groups               = { dig_immediate = 3, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_violet = 1, compostability = 75 },
            _mcl_crafting_output = { single = { output = "mcl_dyes:pink" } },
            _sound_def           = {
                key = "node_sound_leaves_defaults",
                input = {},
            },
            floodable            = true,
            selection_box        = {
                type = "fixed",
                fixed = { -0.25, -0.49, -0.25, 0.25, 0.50, 0.25 },
            }
        }
    },

}


-- add botanical names to item descriptions if global setting == yes
local function format_description(dat)
    if dat._botanical_name then
        dat.description = dat.description ..
            "\n" .. core.colorize("#d0ffd0", dat._botanical_name)
    end
end



-- botanical formatting for inventory, if enabled
if not core.settings:get("elysflowers_botanical_descriptions") then
    for a, dat in pairs(elysflowers.nodes) do
        format_description(dat)
        core.register_node(dat.name, dat)
    end
end


dofile(core.get_modpath("elysflowers") .. "/decorations.lua")


-- handle misc mcl registration
if gameid == "mineclonia" or gameid == "mineclone2" then
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
    mcl_flowerpots.register_potted_flower("elysflowers:hibiscus",
        { name = "elysflowers:hibiscus", desc = "Hibiscus", image = "hibiscus_flower.png" })
    mcl_flowerpots.register_potted_flower("elysflowers:california_poppy",
        { name = "elysflowers:california_poppy", desc = "California Poppy", image = "california_poppy.png" })
    mcl_flowerpots.register_potted_flower("elysflowers:purple_coneflower",
        { name = "elysflowers:purple_coneflower", desc = "Purple Coneflower", image = "purple_coneflower_0.png" })
    mcl_flowerpots.register_potted_flower("elysflowers:hyacinth",
        { name = "elysflowers:hyacinth", desc = "Hyacinth", image = "hyacinth.png" })
    mcl_flowerpots.register_potted_flower("elysflowers:phlox",
        { name = "elysflowers:phlox", desc = "Phlox", image = "phlox.png" })
    mcl_flowerpots.register_potted_flower("elysflowers:forget_me_not",
        { name = "elysflowers:forget_me_not", desc = "Chinese Forget-me-not", image = "forget_me_not.png" })
    mcl_flowerpots.register_potted_flower("elysflowers:arctic_poppy",
        { name = "elysflowers:arctic_poppy", desc = "Arctic Poppy", image = "arctic_poppy.png" })
    mcl_flowerpots.register_potted_flower("elysflowers:black_eyed_susan",
        { name = "elysflowers:black_eyed_susan", desc = "Arctic Poppy", image = "black_eyed_susan.png" })
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
    flowerpot.register_node("elysflowers:california_poppy")
    flowerpot.register_node("elysflowers:larkspur")
    flowerpot.register_node("elysflowers:hibiscus")
    flowerpot.register_node("elysflowers:purple_coneflower")
    flowerpot.register_node("elysflowers:hyacinth")
    flowerpot.register_node("elysflowers:phlox")
    flowerpot.register_node("elysflowers:foxglove")
    flowerpot.register_node("elysflowers:forget_me_not")
    flowerpot.register_node("elysflowers:black_eyed_susan")
end

dofile(core.get_modpath("elysflowers") .. "/crafting.lua")
