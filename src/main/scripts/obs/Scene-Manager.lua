obs = obslua;

local scriptsDir = "C:/Users/narwhal/Desktop/dev/pokemon-battler/src/main/scripts/obs";
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
local pokemon1Alive;
local pokemon2Alive;
local pokemon3Alive;
local pokemon4Alive;
local pokemon5Alive;
local pokemon6Alive;

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

--this is a global obs function called every frame (so it's basically a while true)
function script_tick(seconds)
    if scene == SCENE_INIT_INDEX then
        if fileExists(scriptsDir .. "/teams.txt") then
            scene = SCENE_BETTING_INDEX;
            activate_scene(SCENE_BETTING_OBS_NAME);
            os.remove(scriptsDir .. "/teams.txt");
            print("switching to " .. SCENE_BETTING_OBS_NAME);
        end
    elseif scene == SCENE_BETTING_INDEX then
        if startTime == 0 then
            --loop 1, need to find our when to start betting
            if fileExists(scriptsDir .. "/outcome.txt") then
                local lines = getFileLines(scriptsDir .. "/outcome.txt");
                startTime = tonumber(lines[7]);
                os.remove(scriptsDir .. "/outcome.txt");
            end
        elseif startTime <= os.time() and startTime > os.time() - 10 then
            --if the time is more than 10 seconds old, we can be confident it's from the previous loop
            scene = SCENE_BATTLING_INDEX;
        end
    elseif scene == SCENE_BATTLING_INDEX then
        if fileExists(scriptsDir .. "/outcome.txt") then
            local lines = getFileLines(scriptsDir .. "/outcome.txt");
            pokemon1Alive = stringToBoolean(lines[1]);
            pokemon2Alive = stringToBoolean(lines[2]);
            pokemon3Alive = stringToBoolean(lines[3]);
            pokemon4Alive = stringToBoolean(lines[4]);
            pokemon5Alive = stringToBoolean(lines[5]);
            pokemon6Alive = stringToBoolean(lines[6]);
            startTime = tonumber(lines[7]);
            scene = SCENE_POSTGAME_INDEX;
        end
    elseif scene == SCENE_POSTGAME_INDEX then
        print(tostring(pokemon1Alive) .. tostring(pokemon2Alive) .. tostring(pokemon3Alive) .. tostring(pokemon4Alive .. tostring(pokemon5Alive) .. tostring(pokemon6Alive)));
        scene = SCENE_BETTING_INDEX;
    end
end