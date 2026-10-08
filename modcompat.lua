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

-- mod presence flags used to define combinations for biome placement toggles
-- bitwise logic SUM_FLAGS^2 is used to determine the comb. of mods currently enabled, and index the correct values in data.json accordingly
-- e.g. if both mcl_biomes and ethereal are present:
-- active_mask = 10
local supported_mods = {
    default = 1,
    mcl_biomes  = 2,
    ebiomes     = 4,
    ethereal = 8,
    naturalbiomes = 16,
    prairie = 32,
    asuna_core = 64,
    everness = 128
}

--is a mod on the list of currently enabled mods for the world?  
local function is_mod_enabled(mod, _mods)
    for _, str in ipairs(_mods) do
        if str == mod then
            return true
        end
    end
    return false
end

-- generates a bitmask by fetching the list of enabled mods from core.get_modnames() [luanti 5.16] and BOR-ing the sum into a mod presence flag. 
local function _get_mask()
local active_mask = 0
for index, mod in pairs(core.get_modnames()) do

    if supported_mods[mod] ~= nil then
        active_mask = bit.bor(active_mask, supported_mods[mod])
        end
        end
        return active_mask
end

-- the list of currently enabled mods for the world. 
-- NOTE: enabled ~= loaded. These globals may not exist yet, see is_mod_loaded
-- @param mask current bitmask
local function _get_mod_environment(mask)
local mods = {}

for mod, flag in pairs(supported_mods) do
    if bit.band(mask, flag) == flag then
        table.insert(mods, mod)
        end
        end
        return mods
end

local function game_id()
    return core.get_game_info().id
end

--is a mod presently loaded? Not just on the list of enabled mods for a world. But actually loaded?
--unused for now, but may be useful later
local function is_mod_loaded(modname)
    return core.global_exists(modname)
end

-- fetches the nodes that a flower is allowed to be placed on
-- @param flowerdef - table of an individual flower
-- @param mods - list of currently enabled mods
local function get_placeable_nodes(flower_def, _mods)
    local nodes = {}
    if not flower_def.place_on then return end

    if #_mods > 0 then
        for _, mod in ipairs(_mods) do
            if flower_def.place_on[mod] ~= nil then
            table.move(flower_def.place_on[mod],1,#flower_def.place_on[mod], #nodes + 1, nodes)
            end
        end

    end
    return nodes
end

-- fetches the biomes that a flower is allowed to spawn in 
-- @param flower_def - table of an individual flower
-- @param mods - list of currently enabled mods
local function get_placeable_biomes(flower_def, _mods)
local biomes = {}

if not flower_def.biomes then return end

if #_mods > 0 then
    for _, mod in ipairs(_mods) do
        if flower_def.biomes[mod] ~= nil then
            table.move(flower_def.biomes[mod],1,#flower_def.biomes[mod], #biomes + 1, biomes)
        end
    end
end
    return biomes
end

-- fetches the nodes that a flower is set to spawn by, if set
-- @param flower_def - table of an individual flower
-- @param mods - list of currently enabled mods
local function get_spawnby_nodes(flower_def, _mods)
local nodes = {}
-- no "spawn_by" property in node def

if not flower_def.spawn_by then return end
if #_mods > 0 then
    for _, mod in ipairs(_mods) do
            if flower_def.spawn_by[mod] ~= nil then
            
            table.move(flower_def.spawn_by[mod],1,#flower_def.spawn_by[mod], #nodes + 1, nodes)
          
            end
    end
end
    return nodes
end

local function get_default_grass_node_sounds(_mods,_gameid)
    if _gameid == "mineclonia" or _gameid == "mineclone2" then
        return mcl_sounds.node_sound_leaves_defaults()
    else if is_mod_enabled("default",_mods) then-- minetest_game, asuna_core, nodeverse
        return default.node_sound_leaves_defaults()
    end
    end
end

--used to determine if the new map generator is being used for mineclonia worlds
local function get_mapgen_env()
 local mg = ""
    mg = core.get_mapgen_setting("mg_name")
 return mg
end


local MASK=_get_mask()
local MOD_ENV=_get_mod_environment(MASK)
local GAMEID=game_id()
return
{
    mask = MASK,
    mod_environment = MOD_ENV,
    gameid = GAMEID,
    get_placeable_nodes = function(flower_def) return get_placeable_nodes(flower_def, MOD_ENV) end,
    get_placeable_biomes = function(flower_def) return get_placeable_biomes(flower_def, MOD_ENV) end,
    get_spawnby_nodes = function(flower_def) return get_spawnby_nodes(flower_def, MOD_ENV) end,
    is_mod_enabled = function(mod) return is_mod_enabled(mod, MOD_ENV) end,
    get_default_grass_node_sounds = function() return get_default_grass_node_sounds(MOD_ENV,GAMEID) end,
    is_mod_loaded = is_mod_loaded,
    get_mapgen_env = get_mapgen_env
}
