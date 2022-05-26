obs = obslua;

local scriptsDir = "C:/Users/narwhal/Desktop/dev/pokemon-battler/src/main/scripts/obs";
local currentImagesDir = scriptsDir .. "/battle-images/current";
local scene = 0;
local SCENE_INIT_INDEX = 0;
local SCENE_STARTING_OBS_NAME = "pokemon-init";
local SCENE_BETTING_INDEX = 1;
local SCENE_BETTING_OBS_NAME = "pokemon-bet";
local SCENE_BATTLING_INDEX = 2;
local SCENE_BATTLING_OBS_NAME = "pokemon-battle";
local SCENE_POSTGAME_INDEX = 3;
local SCENE_POSTGAME_OBS_NAME = "pokemon-postgame";
local startTime = 0;
local postGameTimer = 0;
local postGameLength = 10;

function printItemsInTable(table)
    for i = 1, #table do
        print(tostring(table[i]));
    end
end

function find_source_by_name_in_list(source_list, name)
    for i, source in pairs(source_list) do
        source_name = obs.obs_source_get_name(source)
        if source_name == name then
            return source
        end
    end

    return nil
end

function activate_scene(switch_scene_name)
    local scenes = obs.obs_frontend_get_scenes()
    local switch_scene = find_source_by_name_in_list(scenes, switch_scene_name)
    obs.obs_frontend_set_current_scene(switch_scene)
    obs.source_list_release(scenes)
end

function fileExists(file)
    local f = io.open(file, "rb")
    if f then f:close() end
    return f ~= nil
end

function getFileLines(file)
    local lines = {}
    for line in io.lines(file) do
        lines[#lines + 1] = line
    end
    return lines;
end

function stringToBoolean(inputString)
    local bool = false
    if inputString == "true" then
        bool = true
    end
    return bool
end

function updatePreviewImages()
    for j = 1, 2 do
        local team = "red";
        if j == 2 then
            team = "blue";
        end
        for i = 1, 3 do
            local source = obs.obs_get_source_by_name(team .. i);
            if source ~= nil then
                local settings = obs.obs_source_get_settings(source)
                obs.obs_data_set_string(settings, "file", currentImagesDir .. "/" .. team .. i .. ".png")
                obs.obs_source_update(source, settings)
                obs.obs_data_release(settings)
                obs.obs_source_release(source)
            end
        end
    end
end

function setFilters(pokemonAlive)
    for j = 1, 2 do
        local team = "red";
        if j == 2 then
            team = "blue";
        end
        for i = 1, 3 do
            local source = obs.obs_get_source_by_name(team .. i)
            if source ~= nil then
                local alive = stringToBoolean(pokemonAlive[i + 3 * (j - 1)]);
                local filter = obs.obs_source_get_filter_by_name(source, "gray-filter");
                obs.obs_source_set_enabled(filter, not alive)
                obs.obs_source_release(source)
                obs.obs_source_release(filter)
            end
        end
    end
end

--this is a global obs function called every frame (so it's basically a while true)
function script_tick(seconds)
    if scene == SCENE_INIT_INDEX then
        if fileExists(scriptsDir .. "/teams.txt") then
            updatePreviewImages();
            setFilters({"true", "true", "true", "true", "true", "true"});
            --get the names here if needed
            os.remove(scriptsDir .. "/teams.txt");
        end
        if fileExists(scriptsDir .. "/outcome.txt") then
            local lines = getFileLines(scriptsDir .. "/outcome.txt");
            startTime = tonumber(lines[7]);
            os.remove(scriptsDir .. "/outcome.txt");
            scene = SCENE_BETTING_INDEX;
            activate_scene(SCENE_BETTING_OBS_NAME);
        end
    elseif scene == SCENE_BETTING_INDEX then
        if startTime <= os.time() and startTime > os.time() - 10 then
            --if the time is more than 10 seconds old, we can be confident it's from the previous loop
            scene = SCENE_BATTLING_INDEX;
            activate_scene(SCENE_BATTLING_OBS_NAME);
        end
    elseif scene == SCENE_BATTLING_INDEX then
        if fileExists(scriptsDir .. "/outcome.txt") then
            local lines = getFileLines(scriptsDir .. "/outcome.txt");
            local pokemonAlive = {lines[1], lines[2], lines[3], lines[4], lines[5], lines[6]};
            setFilters(pokemonAlive);
            startTime = tonumber(lines[7]);
            os.remove(scriptsDir .. "/outcome.txt");
            scene = SCENE_POSTGAME_INDEX;
            postGameTimer = os.time();
            activate_scene(SCENE_POSTGAME_OBS_NAME);
        end
    elseif scene == SCENE_POSTGAME_INDEX then
        if fileExists(scriptsDir .. "/teams.txt") then
            --get the names here if needed
            os.remove(scriptsDir .. "/teams.txt");
        end
        if os.time() - postGameTimer > postGameLength then
            scene = SCENE_BETTING_INDEX;
            setFilters({"true", "true", "true", "true", "true", "true"});
            activate_scene(SCENE_BETTING_OBS_NAME);
        end
    end
end