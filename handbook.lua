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

local function is_flower_discovered(player,mod_storage,flower)
    local pdat = mod_storage:get(player:get_player_name())

    if pdat then
     local known = core.deserialize(pdat)
     return known[flower] ~= nil
    end

    return false
end

local function create_handbook_pages(flowers,modcompat,S)
    local pages = {}
    local page_template = "formspec_version[6]size[8,6]textarea[0.5,0.5;7,5;;;"
    for index, flower in ipairs(flowers) do
        if flower.not_in_creative_inventory then
          goto continue
        end
        
        local textcolor = "#FFFFFF"
        if modcompat.game_id() == "mineclonia" or modcompat.game_id() == "mineclone2" then
            textcolor = "#000000"
        end


       
        local page = "formspec_version[6]size[8,6]hypertext[0.5,0.5;7,5;" .. core.formspec_escape(flower.name) .. ";" .. "<style color=" .. textcolor .. ">" .. string.format("<big>%s</big>\n", S(flower.description):gsub("\n.*$", ""))
        .. "<b><i>" .. flower._botanical_name .. "</b></i>"..  "\n" .. core.formspec_escape(flower._guidebook_entry) .. "</style>".. "]"
        
        page = page .. "button[1,4;2,1;elysflowers_back;Back]"

        local handle = function(player, fields)
            if fields.back then
                core.show_formspec(player:get_player_name(), "elysflowers")
            end
        end

        pages[flower.name] = {form = page, handle =  handle}
        ::continue::
    end
    
    return pages
end

local function item_discovery_callback(mod_storage)
    return function(pos, oldnode, oldmetadata, digger)
            local item_name = oldnode.name
            if string.match(item_name, "^elysflowers:") then

                if digger and digger:is_player() then
                    local known = {}
                    local player_name = digger:get_player_name()
                    known = core.deserialize(mod_storage:get(player_name))

                    if known == nil then
                        ---core.debug("action", "[elysflowers] Creating bestiary data for " .. player_name)
                        known = {item_name = true}
                        mod_storage:set_string(player_name,core.serialize(known))
                    else
                            known[item_name] = true
                            mod_storage:set_string(player_name,core.serialize(known))
                    end

                end    
            end
            return nil
        end
end



-- builds the botany guide formspec string, the formspec string for each individual plant, and the plant discovery callback function
-- @field pages table Formspec strings for each individual plant
-- look, I know this is hard to read but it keeps mod_storage in scope the entire time
-- so that core.get_modstorage() doesn't need to be called more than once
local function build_handbook(flowers,mod_storage,modcompat,S)
    local pages = create_handbook_pages(flowers,modcompat,S)

    local build = function(player,...)
        
        local formspec = "size[8,8]textarea[0,8;4,5;;;"  .. core.formspec_escape(S("The wildflowers you've encountered will show up here. The ones you haven't discovered yet are greyed out")) .."]"
        formspec = formspec .. "scroll_container[0,0.3;8,8;img_scrollbar;vertical]"
        local max_columns = 4
        local start_x = 0.5
        local start_y = 0.5
        local spacing = 1.5
        local pdat = mod_storage:get(player:get_player_name())
        local known = {}

        if pdat then
            known = core.deserialize(pdat)
        end
        
        
        for index, item_name in pairs(elysflowers.nodes) do
            
            if item_name.not_in_creative_inventory then
                index = index - 1
                goto continue
            end
            
            local col = (index - 1) % max_columns
            local row = math.floor((index - 1) / max_columns)
            
            local x = start_x + (col * spacing)
            local y = start_y + (row * spacing)
            --core.debug(tprint(known))
            
            if known and known[item_name.name] then
                formspec = formspec .. string.format("item_image_button[%f,%f;1,1;%s;%s;%s]", x, y, item_name.name, item_name.name,"") ..";#222222;#FFFFFF]"
            else
            -- (dimensions: 1x1) "item_image[%f,%f;1,1;%s]"
                   formspec = formspec .. string.format("image_button[%f,%f;1,1;%s" .. core.formspec_escape("^[colorize:#000000:255]") .. ";%s;%s]", x, y,item_name.wield_image, item_name.name, "", "")
            end
            ::continue::

        end
        --close scrlbar
        formspec = formspec .. "scroll_container_end[]scrollbar[6.10,0.5;0.4,4;vertical;img_scrollbar;]"
        -- convert to i3 formspec string if present 
        
        return formspec
        
    end

    local handle = function(player, formname, fields)

        if type(fields) == 'string' then 
            core.debug(fields)
             if string.match(fields,"^elysflowers:") then
                if is_flower_discovered(player,mod_storage,fields) then
                      core.show_formspec(player:get_player_name(),"" , pages[fields].form)
                end
            
            end
            if fields == "elysflowers_back" then
              core.show_formspec(player:get_player_name(), "elysflowers:botanical_handbook", build(player))
            end
        else
        for field in pairs(fields) do
            --core.debug(field)
            if string.match(field,"^elysflowers:") then
                if is_flower_discovered(player,mod_storage,field) then
                      local formname,val = next(fields, nil)
                      core.show_formspec(player:get_player_name(), formname , pages[field].form)
                end
            
            end
            if field == "elysflowers_back" then
                core.show_formspec(player:get_player_name(), "elysflowers:botanical_handbook", build(player))
            end
        end
    end
    end

    local function craftitem()
    local recipe = {

    }
    return recipe
    end
    return {pages = pages, build = build, handle = handle, on_use = on_use, craftitem = craftitem}
end



return {build_handbook = build_handbook,item_discovery_callback= item_discovery_callback}
