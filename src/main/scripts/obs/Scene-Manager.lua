local scene = 0;
local SCENE_STARTING = 0;
local SCENE_BETTING = 1;
local SCENE_BATTLING = 2;
local SCENE_POSTGAME = 3;
local startTime = 0;
local pokemon1Alive;
local pokemon2Alive;
local pokemon3Alive;
local pokemon4Alive;
local pokemon5Alive;
local pokemon6Alive;

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

while true do
    if scene == SCENE_STARTING then
        if file_exists("teams.txt") then
            scene = SCENE_BETTING;
            os.remove("teams.txt");
        end
    elseif scene == SCENE_BETTING then
        if startTime == 0 then
            --loop 1, need to find our when to start betting
            if fileExists("outcome.txt") then
                local lines = getFileLines("outcome.txt");
                startTime = tonumber(lines[7]);
                os.remove("outcome.txt");
            end
        elseif startTime <= os.time() and startTime > os.time() - 10 then
            --if the time is more than 10 seconds old, we can be confident it's from the previous loop
            scene = SCENE_BATTLING;
        end
    elseif scene == SCENE_BATTLING then
        if fileExists("outcome.txt") then
            local lines = getFileLines("outcome.txt");
            pokemon1Alive = stringToBoolean(lines[1]);
            pokemon2Alive = stringToBoolean(lines[2]);
            pokemon3Alive = stringToBoolean(lines[3]);
            pokemon4Alive = stringToBoolean(lines[4]);
            pokemon5Alive = stringToBoolean(lines[5]);
            pokemon6Alive = stringToBoolean(lines[6]);
            startTime = tonumber(lines[7]);
            scene = SCENE_POSTGAME;
        end
    elseif scene == SCENE_POSTGAME then
        print(tostring(pokemon1Alive) .. tostring(pokemon2Alive) .. tostring(pokemon3Alive) .. tostring(pokemon4Alive .. tostring(pokemon5Alive) .. tostring(pokemon6Alive)));
        scene = SCENE_BETTING;
    end
end