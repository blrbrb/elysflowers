local create_variants = function(itemstack, placer, pointed_thing)

if not pointed_thing or pointed_thing.type ~= "node" then
    return itemstack
    end
    ndef = itemstack:get_definition()
    local variant = math.random(0, ndef._num_variants)
    local playername = placer and placer:get_player_name() or ""
    local pos = pointed_thing.above
    if not core.is_protected(pos, playername) then
      if variant == 0 then
         core.set_node(pos, { name = itemstack:get_name() })
      else
         core.set_node(pos, { name = itemstack:get_name() .. "_" .. variant })
      end
        itemstack:take_item()
        return itemstack
     else
         core.record_protection_violation(pos, playername)
    end
end

local place_water_surface_plant = function(itemstack, placer, pointed_thing)
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
                    core.record_protection_violation(pos, player_name)
                end
            end

            return itemstack
        end

return {create_variants = create_variants,place_water_surface_plant = place_water_surface_plant}