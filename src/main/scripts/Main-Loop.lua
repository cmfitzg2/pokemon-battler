--Address Constants
local cursorXIndexAddr = 0xCC25;
local cursorYIndexAddr = 0xCC26;
local menuAddr = 0xCC4E;
local moveSelectMenuVal = 0x5D;
local pokemonSelectXIndexVal = 0x00;
local battleStatusAddr = 0xD062;
local multiTurnMoveVal = 0x20;
local hpSlot1Byte1 = 0xD16C;
local hpSlot1Byte2 = 0xD16D;
local hpSlot2Byte1 = 0xD198;
local hpSlot2Byte2 = 0xD199;
local hpSlot3Byte1 = 0xD1C4;
local hpSlot3Byte2 = 0xD1C5;

--Variables
local activePokemonP1Index = 1;
local activePokemonP2Index = 1;
local p1Mash = true;
local p2Mash = true;
local WAIT_OP = "WAIT";
inputP1 = {};
inputP2 = {};
inputQueueP1 = {};
inputQueueP2 = {};

--initialize RNG
math.randomseed(os.time());
math.random();
math.random();
math.random();

function switchPokemonInputs(playerNum, fromMoveSelect)
	if fromMoveSelect then
		insertWaits(20, playerNum);
		insertOp("B true", playerNum)
	end
	insertWaits(20, playerNum);
	insertOp("Right true", playerNum);
	insertWaits(20, playerNum);
	insertOp("A true", playerNum);
	insertWaits(40, playerNum);
end

function insertWaits(count, playerNum)
	local inputQueue = {};
	if playerNum == 1 then
		inputQueue = inputQueueP1;
	else
		inputQueue = inputQueueP2;
	end
	for i = 1,count,1
	do
		table.insert(inputQueue, WAIT_OP);
	end
end

function insertOp(op, playerNum)
	if playerNum == 1 then
		table.insert(inputQueueP1, op);
	else
		table.insert(inputQueueP2, op);
	end
end

function clearInputs(inputs, memoryDomain)
	memory.usememorydomain(memoryDomain);
	inputs['A'] = false
	inputs['B'] = false
	inputs['Down'] = false
	inputs['Left'] = false
	inputs['Power'] = false
	inputs['Right'] = false
	inputs['Select'] = false
	inputs['Start'] = false
	inputs['Up'] = false
end

function randomChance(odds)
	return math.random(1, 100) <= odds
end

function stringSplit (inputString, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={}
	for str in string.gmatch(inputString, "([^"..sep.."]+)") do
		table.insert(t, str)
	end
	return t
end

function stringToBoolean(inputString)
	local bool = false
	if inputString == "true" then
		bool = true
	end
	return bool
end

function doInputs(inputs, memoryDomain)
	memory.usememorydomain(memoryDomain);
	local playerNum;
	if memoryDomain == "L System Bus" then
		playerNum = 1;
	else
		playerNum = 2;
	end
	if (playerNum == 1 and #inputQueueP1 == 0) or (playerNum == 2 and #inputQueueP2 == 0) then
		local xIndex = memory.readbyte(cursorXIndexAddr);
		local yIndex = memory.readbyte(cursorYIndexAddr);
		local pokemon1Alive = memory.readbyte(hpSlot1Byte1) ~= 0 or memory.readbyte(hpSlot1Byte2) ~= 0;
		local pokemon2Alive = memory.readbyte(hpSlot2Byte1) ~= 0 or memory.readbyte(hpSlot2Byte2) ~= 0;
		local pokemon3Alive = memory.readbyte(hpSlot3Byte1) ~= 0 or memory.readbyte(hpSlot3Byte2) ~= 0;
		local totalAlive = 0;
		if pokemon1Alive then
			totalAlive = totalAlive + 1;
		end
		if pokemon2Alive then
			totalAlive = totalAlive + 1;
		end
		if pokemon3Alive then
			totalAlive = totalAlive + 1;
		end

		if xIndex == 0x05 and memory.readbyte(menuAddr) == moveSelectMenuVal then
			--attack select menu
			if totalAlive > 1 and randomChance(3) then
				switchPokemonInputs(playerNum, true);
			else
				move = chooseRandomMove();
				memory.writebyte(cursorYIndexAddr, move)
				insertWaits(20, playerNum);
			end
		elseif xIndex == pokemonSelectXIndexVal then
			chooseRandomPokemon(memoryDomain);
		end
		--Multi-turn moves block access to the attack menu, check the pokemon switch condition earlier
		if playerNum == 1 then
			memory.usememorydomain("R System Bus");
		else
			memory.usememorydomain("L System Bus");
		end
		local enemyMoveStatus = memory.readbyte(battleStatusAddr)
		memory.usememorydomain(memoryDomain);
		if totalAlive > 1 and enemyMoveStatus == multiTurnMoveVal and randomChance(3) then
			print("Switching Pokemon Randomly during multiturn move");
			switchPokemonInputs(playerNum, false);
		else
			--Mash A every frame (so every 2 frames)
			inputs['A'] = true;
			joypad.set(inputs, playerNum);
			emu.frameadvance();
			inputs['A'] = false;
			joypad.set(inputs, playerNum);
			emu.frameadvance();
		end
	else
		--the input queue has at least one element
		local queue = {};
		local inputQueueWaitIndex;
		if playerNum == 1 then
			queue = inputQueueP1;
			inputQueueWaitIndex = inputQueueWaitIndexP1;
		else
			queue = inputQueueP2;
			inputQueueWaitIndex = inputQueueWaitIndexP2;
		end
		--pop the first value and set the input
		local op = table.remove(queue, 1);
		local opParts = {};
		if op ~= WAIT_OP then
			opParts = stringSplit(op, nil);
			inputs[opParts[1]] = stringToBoolean(opParts[2]);
		end
	end
end

function chooseRandomMove()
	return math.random(1, 4);
end

function chooseRandomPokemon(memoryDomain)
	memory.usememorydomain(memoryDomain);
	local pokemon1Alive = memory.readbyte(hpSlot1Byte1) ~= 0 or memory.readbyte(hpSlot1Byte2) ~= 0;
	local pokemon2Alive = memory.readbyte(hpSlot2Byte1) ~= 0 or memory.readbyte(hpSlot2Byte2) ~= 0;
	local pokemon3Alive = memory.readbyte(hpSlot3Byte1) ~= 0 or memory.readbyte(hpSlot3Byte2) ~= 0;
	local randNum = math.random(1, 2);
	local index;
	if memoryDomain == "L System Bus" then
		index = activePokemonP1Index;
	else
		index = activePokemonP2Index
	end
	--conditions for final pokemon selection
	if pokemon1Alive and not pokemon2Alive and not pokemon3Alive then
		index = 1;
	elseif pokemon2Alive and not pokemon1Alive and not pokemon3Alive then
		index = 2;
	elseif pokemon3Alive and not pokemon1Alive and not pokemon2Alive then
		index = 3;
	else
		if index == 1 then
			if pokemon2Alive and pokemon3Alive then
				index = math.random(2, 3);
			elseif pokemon2Alive then
				index = 2;
			else
				index = 3;
			end
		elseif index == 2 then
			if pokemon1Alive and pokemon3Alive then
				if randNum == 1 then
					index = 1;
				else
					index = 3;
				end
			elseif pokemon1Alive then
				index = 1;
			else
				index = 3;
			end
		elseif index == 3 then
			if pokemon1Alive and pokemon2Alive then
				index = randNum;
			elseif pokemon1Alive then
				index = 1;
			else
				index = 2;
			end
		end
	end
	memory.writebyte(cursorYIndexAddr, index - 1);
	if memoryDomain == "L System Bus" then
		activePokemonP1Index = index;
		insertWaits(20, 1);
	else
		activePokemonP2Index = index;
		insertWaits(20, 2);
	end
end

while (true) do
	--Clear inputs P1
	clearInputs(inputP1, "L System Bus");
	clearInputs(inputP2, "R System Bus");
	doInputs(inputP1, "L System Bus");
	doInputs(inputP2, "R System Bus");
	joypad.set(inputP1, 1)
	joypad.set(inputP2, 2)
	emu.frameadvance()
end