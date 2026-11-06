-- ============================================================================
-- elysflowers - hanging_flowerpot.lua
--
-- This file contains code adapted from:
--   Mod:  "flowerpots" by Auke Kok
--   URL:      https://github.com/minetest-mods/flowerpot
--   License:  LGPL-2.1 (Relicensed to GPL-3.0-or-later under LGPL v2.1 Section 3)
-- 	 Copyright (C) Auke Kok <sofar@foo-projects.org>
-- ============================================================================


-- ============================================================================
-- adpated from flowerpot init.lua:13
-- ============================================================================
local flower_items_by_pot = {}
-- ============================================================================
-- adpated from flowerpot init.lua:49 and flowerpot init.lua:57
-- ============================================================================
local function get_tile(def)
	local tile = {}

	if type(def) == "string" then -- def is still a string for some reason
	  def = core.registered_nodes[def]
	end

	if def.tiles then
	 tile = def.tiles[1]
	if type (tile) == "table" then	
		return tile.name
	end
		return tile
	else
		return nil
	end
end

local old_get_node_drops = core.get_node_drops
-- ============================================================================
-- adpated from flowerpot init.lua:59
-- ============================================================================
function core.get_node_drops(node, toolname)
	local node_name
	if type(node) == "table" then
		node_name = node.name

	elseif type(node) == "string" then
		node_name = node
	end

	if node_name then
		local flower_item = flower_items_by_pot[node_name]
		if flower_item then
			local drops = old_get_node_drops(flower_item, toolname)
			if drops then
				table.insert(drops, "elysflowers:hanging_flowerpot_empty")
				return drops
			else
				return { "elysflowers:hanging_flowerpot_empty" }
			end
		end
	end

	return old_get_node_drops(node, toolname)
end

-- ============================================================================
-- adpated from flowerpot init.lua:22
-- ============================================================================
local function elysflowers_hanging_flowerpot_on_rightclick(pos, node, clicker, itemstack, pointed_thing)

	if not core.is_player(clicker) then
		core.debug("not a player")
		return itemstack
	end

	local player_name = clicker:get_player_name()

	if core.is_protected(pos, player_name) then
		core.debug("protected_node")
		return itemstack
	end

	local item_name = itemstack:get_name()
  
	local pot_name = "elysflowers:elysflowers_hanging_flowerpot_" .. item_name:gsub(":", "_")
   
	local def = core.registered_nodes[pot_name]
	if not def then
		return itemstack
	end
	
	core.sound_play(def.sounds.place, {pos = pos})
	core.swap_node(pos, {name = pot_name})
	if not core.settings:get_bool("creative_mode") then
		itemstack:take_item()
	end
	return itemstack
end


local function build(S,modcompat)
-- ============================================================================
-- adpated from flowerpot init.lua:152
-- ============================================================================
local function register_node(nodename)
	assert(nodename, "no nodename passed")
	local nodedef = core.registered_nodes[nodename]

	if not nodedef then
		error(string.format("%s is not a known node, unable to register flowerpot", nodename))
	end

	local desc = nodedef.description
	local name = nodedef.name:gsub(":", "_")
	local tiles

	if nodedef.drawtype == "plantlike" then
		tiles = {
			{name = "elysflowers_hanging_flowerpot.png"},
			{name = get_tile(nodedef)},
			
		}
	else
		tiles = {
			{name = "elysflowers_hanging_flowerpot.png"},
			{name = get_tile(nodedef)},
		}
	end

	flower_items_by_pot["elysflowers:elysflowers_hanging_flowerpot_" .. name] = nodename

	core.register_node(":elysflowers:elysflowers_hanging_flowerpot_" .. name, {
		description = S("Hanging flowerpot with @1", desc),
		drawtype = "mesh",
		mesh = "elysflowers_hanging_flowerpot.obj",
		tiles = tiles,
		paramtype = "light",
		sunlight_propagates = true,
		use_texture_alpha = core.features.use_texture_alpha_string_modes and "clip" or true,
		collision_box = {
			type = "fixed",
			fixed = {-0.23, -1/2, -1/4, 1/4, -1/8, 1/4},
		},
		selection_box = {
			type = "fixed",
			fixed = {-0.23, 0.4, -0.23, 0.23, -0.1, 0.23},
		},
		sounds = modcompat.get_default_grass_node_sounds(),
		groups = {attached_node = 1, oddly_breakable_by_hand = 1, snappy = 3,not_in_creative_inventory=1},
		flowerpot_plantname = nodename,
		node_dig_prediction = "elysflowers:hanging_flowerpot_empty",
		on_punch = function(pos, node, puncher, pointed_thing)
			if not (puncher and puncher:is_player()) then
				return
			end
			if core.is_protected(pos, puncher:get_player_name()) then
				return
			end
			local toolname = puncher:get_wielded_item()
			if node.name then
				local flower_item = flower_items_by_pot[node.name]
				if flower_item then
					local drops = old_get_node_drops(flower_item, toolname)
					core.handle_node_drops(pos, drops, puncher)
				end
			end
			core.swap_node(pos, {name = "elysflowers:hanging_flowerpot_empty"})
		end,
	})
end

core.register_node("elysflowers:hanging_flowerpot_empty",{
    description = S("Hanging Flowerpot"),
	drawtype = "mesh",
	mesh = "elysflowers_hanging_flowerpot.obj",
    tiles = {
		{name = "elysflowers_hanging_flowerpot.png"},
		{name = "blank.png"},
	},
	paramtype = "light",
	sunlight_propagates = true,
	use_texture_alpha = core.features.use_texture_alpha_string_modes and "clip" or true,
    node_box = {
        type = "wallmounted",
        wall_top = {-0.23, 0.1, -0.23, 0.23, 0.3, 0.23}, 
    },
	collision_box = {
		type = "fixed",
		fixed = {0.23, -0.1, -0.23, 0.23, 0.3, 0.23},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.23, -0.1, -0.23, 0.23, 0.3, 0.23},
	},
	sounds = modcompat.get_default_grass_node_sounds(),
	groups = {attached_node = 1, oddly_breakable_by_hand = 3, cracky = 1, dig_immediate = 3},
    on_rightclick=elysflowers_hanging_flowerpot_on_rightclick,
    on_place = function(itemstack, placer, pointed_thing)
      
        if pointed_thing.type ~= "node" then
            return itemstack
        end

        local pos = pointed_thing.above
        local ceiling_pos = pointed_thing.under 
        local below_pos = {x = pos.x, y = pos.y - 1, z = pos.z}

        local node_above = core.get_node(ceiling_pos)
        local node_below = core.get_node(below_pos)
        local def_above = core.registered_nodes[node_above.name]

        local has_block_above = node_above.name ~= "air" and node_above.name ~= "ignore" and def_above and def_above.walkable

        local has_air_below = (node_below.name == "air")

       
        local place_node = core.get_node(pos)
        local def_place = core.registered_nodes[place_node.name]
        local is_place_free = def_place and def_place.buildable_to

		-- make sure the block we're placing under isn't a half-slab, a staircase, or mesh
		local correct_geom_above = def_above.drawtype ~= "nodebox" and def_above.drawtype ~= "mesh"

		
        local is_ceiling_placement = (ceiling_pos.y == pos.y + 1
            and ceiling_pos.x == pos.x 
            and ceiling_pos.z == pos.z)

        if has_block_above and is_ceiling_placement and has_air_below and is_place_free and correct_geom_above then
           
            local dir = vector.direction(pos, ceiling_pos)
            local param2 = core.dir_to_wallmounted(dir)

            core.set_node(pos, {name = "elysflowers:hanging_flowerpot_empty", param2 = param2})

            local sound = core.registered_nodes["elysflowers:hanging_flowerpot_empty"].sounds
            if sound and sound.place then
                core.sound_play(sound.place, {pos = pos}, true)
            end

          
            if (placer and placer:is_player() and not core.is_creative_enabled(placer:get_player_name())) then
                itemstack:take_item()
            end

            return itemstack
        end

        return itemstack
    end,}
    )
local function register_craft()

	local game_clay=""
	local game_string=""

	if modcompat.game_id == "mineclonia" or modcompat.game_id == "mineclone2" then
		game_clay = "mcl_core:brick"
		game_string = "mcl_mobitems:string"
	elseif modcompat.is_mod_enabled("x_farming") then
		game_string ="x_farming:string"
		game_clay = "default:clay_brick"
	else
		game_string="farming:string"
		game_clay="default:clay_brick"
	end

	core.register_craft({
		output="elysflowers:hanging_flowerpot_empty",
		recipe = {
			{game_string,"",game_string},
			{game_clay,"",game_clay},
			{game_clay,game_clay,game_clay}
		}
	})
end

local function register_existing_flowers(elysflowers_flowers, hf_def)
	for i, node in pairs(modcompat.get_hanging_flowerpot_nodes(hf_def)) do
		if(type(node) == "table") then
			register_node(node.name)
		else
			register_node(node)
		end
	end
	for i, node in pairs(elysflowers_flowers) do
		if(type(node) == "table") then
			register_node(node.name)
		else
			register_node(node)
		end
	end
end
 return {register_node=register_node,register_craft=register_craft,register_existing_flowers=register_existing_flowers}
end


return
{
	build=build,
}
