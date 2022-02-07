--Address Constants
local cursorXIndexAddr = 0xCC25;
local cursorYIndexAddr = 0xCC26;
local menuAddr = 0xCC4E;
local moveSelectMenuVal = 0x5D;
local pokemonSelectXIndexVal = 0x00;
--local battleStatusAddr = 0xD062;
--local multiTurnMoveVal = 0x20;
local hpSlot1Byte1 = 0xD16C;
local hpSlot1Byte2 = 0xD16D;
local hpSlot2Byte1 = 0xD198;
local hpSlot2Byte2 = 0xD199;
local hpSlot3Byte1 = 0xD1C4;
local hpSlot3Byte2 = 0xD1C5;
local activePokemonIndexAddr = 0xCC2F;
local ppMove1Addr = 0xD02D;
local ppMove2Addr = 0xD02E;
local ppMove3Addr = 0xD02F;
local ppMove4Addr = 0xD030;

--Variables
local WAIT_OP = "WAIT";
local turnCount = 0;
local randomSwitchChanceDefault = 3;
local randomSwitchChance = randomSwitchChanceDefault;
local resettingP1 = false;
local resettingP2 = false;
local p1Outcome;
local p2Outcome;
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
	randomSwitchChance = randomSwitchChanceDefault;
	turnCount = 0;
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
	for _ = 1,count,1
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

function checkWinner(playerNum)
	local outcomeTextWinLose = 0xC44A
	local outcomeTextDraw = 0xC448
	if memory.readbyte(outcomeTextDraw) == 0x83 then
		if playerNum == 1 then
			p1Outcome = "DRAW";
		else
			p2Outcome = "DRAW";
		end
		return true;
	elseif memory.readbyte(outcomeTextWinLose) == 0x8B then
		if playerNum == 1 then
			p1Outcome = "LOSE";
		else
			p2Outcome = "LOSE";
		end
		return true;
	elseif memory.readbyte(outcomeTextWinLose) == 0x96 then
		if playerNum == 1 then
			p1Outcome = "WIN";
		else
			p2Outcome = "WIN";
		end
		return true;
	end
	return false;
end

function reset()
	print("Re-rolling teams");
	dofile("Randomize-Teams.lua");
	print("Teams reset. Outputting outcome.")
	print("P1 " .. p1Outcome);
	print("P2 " .. p2Outcome);
	file = io.open("battle-log.txt", "w")
	file:write(p1Outcome .. "\n" .. p2Outcome);
	file:close()
	print("File writing finished")
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
			if turnCount > 35 and randomSwitchChance < 100 then
				--this will actually bump the odds by an unpredictable amount since it's based on either player entering the battle menu
				randomSwitchChance = randomSwitchChance + 1;
			end
			if totalAlive > 1 and randomChance(randomSwitchChance) then
				switchPokemonInputs(playerNum, true);
			else
				turnCount = turnCount + 1;
				move = chooseRandomMove();
				memory.writebyte(cursorYIndexAddr, move)
				insertWaits(20, playerNum);
			end
		elseif xIndex == pokemonSelectXIndexVal then
			chooseRandomPokemon(playerNum);
		end
		if checkWinner(playerNum) then
			if (resettingP2 == false or resettingP1 == false) then
				--true if win/lose/draw text is displayed, avoid rerunning the reset every frame
				if playerNum == 1 and not resettingP1 then
					resettingP1 = true;
				elseif playerNum == 2 and not resettingP2 then
					resettingP2 = true;
				end
				if resettingP1 and resettingP2 then
					reset();
				end
			end
		else
			--Reset the winners in case they haven't been yet
			if resettingP1 or resettingP2 then
				resettingP1 = false;
				resettingP2 = false;
			end
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
	ppMove1 = memory.readbyte(ppMove1Addr);
	ppMove2 = memory.readbyte(ppMove2Addr);
	ppMove3 = memory.readbyte(ppMove3Addr);
	ppMove4 = memory.readbyte(ppMove4Addr);
	local availableMoves = {}
	if ppMove1 > 0 then
		table.insert(availableMoves, 1);
	end
	if ppMove2 > 0 then
		table.insert(availableMoves, 2);
	end
	if ppMove3 > 0 then
		table.insert(availableMoves, 3);
	end
	if ppMove4 > 0 then
		table.insert(availableMoves, 4);
	end

	--e.g., availableMoves = {1, 4} -> availableMoves[math.random(1, 2)] will return 1 or 4
	return availableMoves[math.random(1, #availableMoves)];
end

function chooseRandomPokemon(playerNum)
	local pokemon1Alive = memory.readbyte(hpSlot1Byte1) ~= 0 or memory.readbyte(hpSlot1Byte2) ~= 0;
	local pokemon2Alive = memory.readbyte(hpSlot2Byte1) ~= 0 or memory.readbyte(hpSlot2Byte2) ~= 0;
	local pokemon3Alive = memory.readbyte(hpSlot3Byte1) ~= 0 or memory.readbyte(hpSlot3Byte2) ~= 0;
	local randNum = math.random(0, 1);
	local index = memory.readbyte(activePokemonIndexAddr);
	--conditions for final pokemon selection
	if pokemon1Alive and not pokemon2Alive and not pokemon3Alive then
		index = 0;
	elseif pokemon2Alive and not pokemon1Alive and not pokemon3Alive then
		index = 1;
	elseif pokemon3Alive and not pokemon1Alive and not pokemon2Alive then
		index = 2;
	else
		if index == 0 then
			if pokemon2Alive and pokemon3Alive then
				index = math.random(1, 2);
			elseif pokemon2Alive then
				index = 1;
			else
				index = 2;
			end
		elseif index == 1 then
			if pokemon1Alive and pokemon3Alive then
				if randNum == 0 then
					index = 0;
				else
					index = 2;
				end
			elseif pokemon1Alive then
				index = 0;
			else
				index = 2;
			end
		elseif index == 2 then
			if pokemon1Alive and pokemon2Alive then
				index = randNum;
			elseif pokemon1Alive then
				index = 0;
			else
				index = 1;
			end
		end
	end
	memory.writebyte(cursorYIndexAddr, index);
	insertWaits(20, playerNum);
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