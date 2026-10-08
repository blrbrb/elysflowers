
---------------- helpers
local modcompat = dofile(core.get_modpath("elysflowers") .. "/modcompat.lua")
local storage = core.get_mod_storage()
local handbook = nil
local place = dofile(core.get_modpath("elysflowers") .. "/place.lua")
local S = core.get_translator("elysflowers")

-------------- config booleans 
local handbook_enabled =  (core.settings:get("elysflowers_botany_handbook") == "true")
local botanic_descriptions = (core.settings:get("elysflowers_botanical_descriptions") == "true")

if handbook_enabled then 
   handbook = dofile(core.get_modpath("elysflowers") .. "/handbook.lua")
end


---------------- load the node data 
local dfile = io.open(core.get_modpath("elysflowers") .. "/data.json", "r")
if dfile then

local json_string = dfile:read("*all")

dfile:close()

elysflowers = core.parse_json(json_string)
    if elysflowers then
    core.log("action", "[elysflowers] Successfully loaded JSON flower data!")
    else
        core.log("error", "[elysflowers] Failed to parse JSON string. (this is probably my fault, oops)")
    end

else -- elf, can't open the file
    core.log("error", "[elysflowers] Could not open data.json file at" .. dfile)
end

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

-- translate descriptions and 
-- add botanical names if enabled
local function format_description(def)
    if def._botanical_name and botanic_descriptions then
        def.description = def.description ..
            "\n" .. core.colorize("#d0ffd0", S(def._botanical_name))
    else
        def.description = S(def.description)
    end
end


local function register_water_surface_plant(def)
    local groups = { dig_by_boat = 1, destroy_by_lava_flow = 1, dig_by_water = 1, dig_immediate = 3, snappy = 3, plant = 1, deco_block = 1, compostability = 35, floating_node = 3,elysflowers = 1 }

    if def.not_in_creative_inventory then
        groups["not_in_creative_inventory"] = 1
    else
        groups["not_in_creative_inventory"] = 0
    end
    if def.dye then
        groups["color_" .. def.dye] = 1
    end

    format_description(def)


    core.register_node(def.name, {
        name                      = def.name,
        _botanical_name           = def._botanical_name,
        description               = def.description,
        drawtype                  = "nodebox",
        _guidebook_entry       =  def._guidebook_entry,
        tiles                     = def.tiles,
        wield_image               = def.wield_image,
        waving                    = 3,
        inventory_image           = def.inventory_image,
        visual_scale              = def.visual_scale,
        paramtype                 = "light",
        paramtype2                = def.paramtype2 or nil,
        use_texture_alpha         = def.use_texture_alpha or nil,
        buildable_to              = true,
        sunlight_propagates       = true,
        walkable                  = false,
        liquids_pointable         = true,
        groups                    = groups,
        node_placement_prediction = "",
        _mcl_crafting_output      = { single = { output = def.mcl_dye } },
        sounds = modcompat.get_default_grass_node_sounds(),
        _pathfinding_class        = "TRAPDOOR",
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
        on_place                  = place.place_water_surface_plant
    })

    core.register_decoration({
        name = def.name,
        deco_type = "simple",
        spawn_by = def.spawn_by or nil,
        waving = 3,
        num_spawn_by = def.num_spawn_by or -1,
        noise_params = def.noise_params,
        place_on = modcompat.get_placeable_nodes(def),
        sidelen = def.sidelen or 16,
        rotation = "random",
        biomes = modcompat.get_placeable_biomes(def),
        param2 = 0,
        param2_max = 3,
        flags = "place_center_x, place_center_z, liquid_surface",
        decoration = def.name,
    })
end

local function register_plant(def)
    local groups = { attached_node = 1, dig_by_piston = 1, unsticky = 1, non_mycelium_plant = 1, dig_by_water = 1, destroy_by_lava_flow = 1, fire_encouragement = 60, enderman_takable = 1, fire_flammability = 100, place_flowerlike = 1, dig_immediate = 0, snappy = 3, flammable = 2, flower = 1, flora = 1, plant = 1, color_white = 1, deco_block = 1, elysflowers = 1, compost=35,compostability = 35 }

    local on_place = nil
    local after_dig_node = nil

    if def.not_in_creative_inventory then
        groups["not_in_creative_inventory"] = 1
    else
        groups["not_in_creative_inventory"] = 0
    end
    
    -- make default digging behavior consistent with minetest_game
    -- only assign dig_immediate for mcl
    if modcompat.gameid == "mineclonia" or modcompat.gameid == "mineclone2" then
        groups["dig_immediate"] = 3
    end

    format_description(def)

    if def.dye then
        groups["color_" .. def.dye] = 1
        if modcompat.gameid == "mineclone2" then
            if def.not_in_creative_inventory == false then
                local namefix = string.gsub(def.mcl_dye, "s(:)", "%1")
                core.register_craft({
                    output = namefix,
                    recipe = {{def.name}}
                })
                end
        end
    end
   
    -- in mineclonia based games, items tagged with flower are prevented from spawning on anything that isn't in the dirt group by an abm.
    -- Flowers and plants that need to grow in sand, or on snow can't have the flower tag because they'll be popped.
    if def._do_not_pop then
        groups["flower"] = 0
    end

    -- place variants
    if def.has_variants then
        on_place = place.create_variants
    end
    -- handbook discovery callback
    if handbook_enabled then
       after_dig_node = handbook.item_discovery_callback(storage)
    end

    core.register_node(def.name, {
        name                 = def.name,
        _botanical_name      = def._botanical_name,
        description          = def.description,
        drawtype             = def.drawtype or "plantlike",
        _guidebook_entry  = def._guidebook_entry,
        tiles                = def.tiles,
        wield_image          = def.wield_image,
        inventory_image      = def.inventory_image,
        visual_scale         = def.visual_scale,
        waving               = def.waving or 1,
        paramtype            = "light",
        sunlight_propagates  = true,
        walkable             = false,
        liquids_pointable    = def.liquids_pointable or false,
        groups               = groups,
        _mcl_crafting_output = { single = { output = def.mcl_dye } },
        _on_bone_meal = def._on_bone_meal or nil,
        sounds = modcompat.get_default_grass_node_sounds(),
        _num_variants = def.num_variants or 0,
        floodable            = true,
        selection_box        = {
            type = "fixed",
            fixed = {def.selection_box.x1, def.selection_box.y1, def.selection_box.z1, def.selection_box.x2, def.selection_box.y2, def.selection_box.z2},
        },
        drop                 = def.drop,
        on_place             = on_place,
        after_dig_node = after_dig_node,
        after_destruct = def.after_destruct
    })
    --debug
    if def._no_register_decoration then
        return
    end

    core.register_decoration({
        name = def.name,
        deco_type = def.deco_type or "simple",
        spawn_by = modcompat.get_spawnby_nodes(def) or nil,
        num_spawn_by = def.num_spawn_by or -1,
        noise_params = def.noise_params,
        place_on =  modcompat.get_placeable_nodes(def) or nil,
        sidelen = def.sidelen or 16,
        rotation = "random",
        waving = 1,
        biomes = modcompat.get_placeable_biomes(def) or nil,
        schematic = def.schematic or nil,
        y_min = def.y_min or 1,
        y_max = def.y_max or 31000,
        decoration = def.name,
    })
end


local function register_normal()

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

for a, def in pairs(elysflowers.nodes) do

    register_plant(def)

    if def.potted and modcompat.is_mod_loaded("flowerpot") then
        flowerpot.register_node(def.name)
    end

end

for a, def in pairs(elysflowers.water_surface_plants) do
    register_water_surface_plant(def)
end

end

local function register_mineclonia_old_mapgen()

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
    _mcl_groups = { is_overworld=true },
    weight = 1.0
})

for a, def in pairs(elysflowers.nodes) do
    -- work w/ mineclonia random plant positions mod. If
    if modcompat.is_mod_loaded("mcl_random_plant_positions") then
        def.paramtype2 = "meshoptions"
        def.place_param2 = 8
    end

    def._on_bone_meal = mcl_flowers.bone_meal_simple_flower
    register_plant(def)

    if def.potted then
        if def.potted_image then
                mcl_flowerpots.register_potted_flower(def.name,{ name = def.name, desc = def.description, image = def.potted_image })
            else
                mcl_flowerpots.register_potted_flower(def.name,{ name = def.name, desc = def.description, image = def.tiles[1] })
            end
        end
end

for a, def in pairs(elysflowers.water_surface_plants) do
    register_water_surface_plant(def)
end

end


--TD
local function register_mineclonia_new_mapgen()
    core.log("Currently, this mod only supports legacy level generators for mineclonia. To fix this, either remove elysflowers -- or create a world that does not use 'singlenode' mapgen")
    --mcl_levelgen.register_levelgen_script(core.get_modpath("elysflowers") .. "/mineclonia-register.lua")
end

local function initalize_handbook(mod_storage, modcompat)

   elysflowers.handbook = handbook.build_handbook(elysflowers.nodes, mod_storage, modcompat,S)
   -- core.register_on_item_pickup(elysflowers.handbook.item_discovery_callback)

   core.register_craftitem("elysflowers:botanical_handbook", {
       output = "elysflowers:botanical_handbook",
       description = S("Botanical Handbook"),
       inventory_image = "elysflowers_botanical_handbook.png",
       stack_max = 1,
        on_secondary_use = function(itemstack, user, pointed_thing)
        if not user then return
        end

            local pn = user:get_player_name()
             core.show_formspec(pn,"elysflowers:botanical_handbook",tostring(elysflowers.handbook.build(user)))
            end})
   core.register_craft({
       output = "elysflowers:botanical_handbook",
       description = S("Botanical Handbook"),
       recipe ={
       {"", "group:elysflowers", ""},
       {"", "group:elysflowers", ""},
       {"", "group:elysflowers", ""}}

})
   core.register_on_player_receive_fields(elysflowers.handbook.handle)

end


if handbook_enabled then
     initalize_handbook(storage, modcompat)
end

if modcompat.gameid == "mineclonia" or modcompat.gameid == "mineclone2" then

    if modcompat.get_mapgen_env() == "singlenode" then
    -- TD
        register_mineclonia_new_mapgen()
    else
        register_mineclonia_old_mapgen()
    end
else
    register_normal()
end


-- compat 
core.register_alias("elysflowers:indian_paintbrush", "elysflowers:prairie_fire")

core.register_alias("elysflowers:beach_heath", "elysflowers:beach_heather")

core.register_lbm({
    name = "elysflowers:beath_heather_fix",
                      nodenames = {"elysflowers:beath_heath"},
                      run_at_every_load = false, -- false ensures it only runs ONCE per map block, ever.
                      action = function(pos, node)
                      -- We use set_node to replace it, but we carry over param1 (light)
                    -- and param2 (rotation/facedir/color) so stairs or machines don't break.
                    core.set_node(pos, {
                        name = "elysflowers:beach_heather",
                        param1 = node.param1,
                        param2 = node.param2
                    })


                core.log("action", "[elysflowers] updated elysflowers:beach_heath to elysflowers:beach_heather at " .. core.pos_to_string(pos))
end
})

