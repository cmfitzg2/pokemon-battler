--initialize RNG
math.randomseed(os.time());
math.random();
math.random();
math.random();

function chooseRandomMove()
	return math.random(1, 4);
end

while (true) do
	inputP1 = {}
	inputP2 = {}
	--Clear inputs P1
	inputP1['A'] = false
	inputP1['B'] = false
	inputP1['Down'] = false
	inputP1['Left'] = false
	inputP1['Power'] = false
	inputP1['Right'] = false
	inputP1['Select'] = false
	inputP1['Start'] = false
	inputP1['Up'] = false

	--Clear inputs P2
	inputP2['A'] = false
	inputP2['B'] = false
	inputP2['Down'] = false
	inputP2['Left'] = false
	inputP2['Power'] = false
	inputP2['Right'] = false
	inputP2['Select'] = false
	inputP2['Start'] = false
	inputP2['Up'] = false

	--decide what to do here
	--P1 inputs
	memory.usememorydomain("L System Bus")
	if memory.readbyte(0xCC26) == 0x00 then
		if inputP1['A'] then
			inputP1['A'] = false;
		else
			inputP1['A'] = true;
		end
		emu.frameadvance();
	else
		memory.writebyte(0xCC26, chooseRandomMove())
		inputP1['A'] = false;
		emu.frameadvance();
		inputP1['A'] = true;
		emu.frameadvance();
	end

	--P2 inputs
	memory.usememorydomain("R System Bus")
	if memory.readbyte(0xCC26) == 0x00 then
		if inputP2['A'] then
			inputP2['A'] = false;
		else
			inputP2['A'] = true;
		end
		emu.frameadvance();
	else
		memory.writebyte(0xCC26, chooseRandomMove())
		inputP2['A'] = false;
		emu.frameadvance();
		inputP2['A'] = true;
		emu.frameadvance();
	end

	--enter inputs
	joypad.set(inputP1, 1)
	joypad.set(inputP2, 2)
	emu.frameadvance()
end