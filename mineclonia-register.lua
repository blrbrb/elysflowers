local function get_flowers()
    local flowers = {}
    local prefix = "elysflowers" .. ":"  
    for name, def in pairs(core.registered_nodes) do
        if name:sub(1, #prefix) == prefix then
            flowers[name] = def
        end
    end
    
    return flowers
end




local function require_air (x, y, z, rng)
	if mcl_levelgen.is_air (x, y, z) then
		return { x, y, z, }
	end
	return nil
end


for i, flower in pairs(get_flowers()) do
    core.debug(flower.name)

    mcl_levelgen.register_configured_feature(flower.name .. "_stub",{
        feature = "mcl_levelgen:simple_block",
        content = function (_, _, _, _)
		    return core.get_content_id(flower.name), 0
	    end
    })

    mcl_levelgen.register_configured_feature(flower.name ,{
         feature = "mcl_levelgen:random_patch",
         placed_feature = {
            configured_feature = flower.name .. "_stub",
            placement_modifiers = {
            require_air,
         },
        tries = 64,
		xz_spread = 7,
		y_spread = 3
    }
    })

    mcl_levelgen.register_placed_feature (flower.name, {
	configured_feature = flower.name,
	placement_modifiers = {
		mcl_levelgen.build_rarity_filter(32),
		mcl_levelgen.build_in_square (),
		mcl_levelgen.build_heightmap ("motion_blocking"),
	},
})

end

