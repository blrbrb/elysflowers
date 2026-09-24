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

}

--  lazy helper function
local function findMatchingStrings(list1, list2)
local set = {}
for _, str in ipairs(list1) do set[str] = true end

    local matches = {}
    for _, str in ipairs(list2) do
        if set[str] then table.insert(matches, str) end
            end
            return matches

end

-- generates a bitmask by fetching the list of enabled mods from core.get_modnames() [luanti 5.16] and BOR-ing the sum into a mod presence flag. 
-- NOTE: core.get_modnames() is used specifically here because it returns an immutable list of ALL mods currently enabled in the world regardless of if they have been loaded or not
local function get_mask()
local active_mask = 0
for index, mod in pairs(core.get_modnames()) do

    if supported_mods[mod] ~= nil then
        active_mask = bit.bor(active_mask, supported_mods[mod])
        end
        end
        return active_mask
end

-- the list of enabled mods 
-- NOTE: enabled ~= loaded. These globals may not exist yet, see has_mod_loaded
-- @param mask current bitmask
local function get_mod_environment(mask)
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
-- retruns true if a mod is presently loaded
local function has_mod_loaded(modname)
    return core.global_exists(modname)
end

-- fetches the nodes that a flower is allowed to be placed on
-- @param flowerdef - table of an individual flower
-- @param mods - list of currently enabled mods
local function get_placeable_nodes(flower_def, mods)
    local nodes = {}
    if #mods > 0 then
        for _, mod in ipairs(mods) do
            if flower_def.place_on[mod] then
            table.move(flower_def.place_on[mod],1,#flower_def.place_on[mod], #nodes + 1, nodes)
           -- minetest.log("info", "" .. mod)
            end
            end

end
return nodes
end

-- fetches the biomes that a flower is allowed to spawn in 
-- @param flower_def - table of an individual flower
-- @param mods - list of currently enabled mods
local function get_placeable_biomes(flower_def, mods)
local biomes = {}
if #mods > 0 then
    for _, mod in ipairs(mods) do
        if flower_def.biomes[mod] then
            table.move(flower_def.biomes[mod],1,#flower_def.biomes[mod], #biomes + 1, biomes)
            end
            end

            end
            return biomes
end

-- fetches the nodes that a flower is set to spawn by, if set
-- @param flower_def - table of an individual flower
-- @param mods - list of currently enabled mods
local function get_spawnby_nodes(flower_def, mods)
local nodes = {}
if flower_def and flower_def["spawn_by"] ~= nil then -- no "spawn_by" property in node def
if #mods > 0 then
    for _, mod in ipairs(mods) do
        if flower_def.spawn_by[mod] then

            table.move(flower_def.spawn_by[mod],1,#flower_def.spawn_by[mod], #nodes + 1, nodes)
            -- minetest.log("info", "" .. mod)
            end
            end

            end
            return nodes
            end
end

-- determine if the new map generator is being used for mineclonia worlds
local function get_mapgen_env()
 local mg = ""
 mg = core.get_mapgen_setting("mg_name")
 return mg
end



return
{
    get_mask = get_mask,
    get_mod_environment = get_mod_environment,
    get_placeable_nodes = get_placeable_nodes,
    get_placeable_biomes = get_placeable_biomes,
    get_spawnby_nodes = get_spawnby_nodes,
    has_mod_loaded = has_mod_loaded,
    game_id = game_id,
    get_mapgen_env = get_mapgen_env

}
