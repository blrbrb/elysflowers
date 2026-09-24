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



for i, flower in pairs(get_flowers()) do 
    core.debug(flower.name)
    mcl_levelgen.register_feature(flower.name, {
         place = function (self, x, y, z, cfg, rng)
            mcl_levelgen.set_block (x, y, z, core.get_content_id(flower.name), "")
        end
    }) 

    mcl_levelgen.register_configured_feature(flower.name .. "_stub",{
        feature = flower.name
    })

    mcl_levelgen.register_placed_feature(flower.name .. "_",{
        configured_feature = flower.name .. "_stub",
         placement_modifiers = {
        mcl_levelgen.build_count (function (rng) return 10 end),
    }
    })
end 


core.debug(tprint(mcl_levelgen.registered_features))