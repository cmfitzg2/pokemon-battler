local teams =
{
	team1 =
	{
		pokemon1 =
		{
			pokemonName = "MACHOP",
			pokemonCode = 0x6A,
			pokemonLevel = 0x32,
			pokemonType1 = 0x01,
			pokemonType2 = 0x01,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0xa1,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x78,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x52,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x3f,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x51,
			move1Code = 0x46,
			move1Pp = 0xf,
			move2Code = 0x59,
			move2Pp = 0xa,
			move3Code = 0x7D,
			move3Pp = 0x14,
			move4Code = 0x40,
			move4Pp = 0x23
		},
		pokemon2 =
		{
			pokemonName = "ODDISH",
			pokemonCode = 0xB9,
			pokemonLevel = 0x32,
			pokemonType1 = 0x16,
			pokemonType2 = 0x03,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0x83,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x5b,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x5c,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x37,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x6d,
			move1Code = 0x73,
			move1Pp = 0x14,
			move2Code = 0x4E,
			move2Pp = 0x1e,
			move3Code = 0x4D,
			move3Pp = 0x23,
			move4Code = 0x52,
			move4Pp = 0xa
		},
		pokemon3 =
		{
			pokemonName = "EEVEE",
			pokemonCode = 0x66,
			pokemonLevel = 0x32,
			pokemonType1 = 0x00,
			pokemonType2 = 0x00,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0x89,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x5b,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x54,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x55,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x56,
			move1Code = 0x0D,
			move1Pp = 0xa,
			move2Code = 0x11,
			move2Pp = 0x23,
			move3Code = 0x16,
			move3Pp = 0xa,
			move4Code = 0x3F,
			move4Pp = 0x5
		}
	},
	team2 =
	{
		pokemon1 =
		{
			pokemonName = "NIDOKING",
			pokemonCode = 0x07,
			pokemonLevel = 0x32,
			pokemonType1 = 0x03,
			pokemonType2 = 0x04,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0xae,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x6c,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x66,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x6c,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x5c,
			move1Code = 0x4D,
			move1Pp = 0x23,
			move2Code = 0x2B,
			move2Pp = 0x1e,
			move3Code = 0x79,
			move3Pp = 0xa,
			move4Code = 0x92,
			move4Pp = 0xa
		},
		pokemon2 =
		{
			pokemonName = "DUGTRIO",
			pokemonCode = 0x76,
			pokemonLevel = 0x32,
			pokemonType1 = 0x04,
			pokemonType2 = 0x04,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0x83,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x73,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x55,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x9b,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x69,
			move1Code = 0x40,
			move1Pp = 0x23,
			move2Code = 0xA4,
			move2Pp = 0xa,
			move3Code = 0x60,
			move3Pp = 0x28,
			move4Code = 0x86,
			move4Pp = 0xf
		},
		pokemon3 =
		{
			pokemonName = "NIDORINA",
			pokemonCode = 0xA8,
			pokemonLevel = 0x32,
			pokemonType1 = 0x03,
			pokemonType2 = 0x03,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0x9c,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x61,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x6f,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x57,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x58,
			move1Code = 0x06,
			move1Pp = 0x14,
			move2Code = 0x25,
			move2Pp = 0x14,
			move3Code = 0x6A,
			move3Pp = 0x1e,
			move4Code = 0x2A,
			move4Pp = 0x14
		}
	}
}


--Address Constants
local pokemonSlot1AAddr = 0xD164
local pokemonSlot1BAddr = 0xD16B
local pokemonSlot1Type1 = 0xD170
local pokemonSlot1Type2 = 0xD171
local pokemonSlot1CurrentHpAAddr = 0xD16C
local pokemonSlot1CurrentHpBAddr = 0xD16D
local pokemonSlot1HpAAddr = 0xD18D
local pokemonSlot1HpBAddr = 0xD18E
local pokemonSlot1AtkAAddr = 0xD18F
local pokemonSlot1AtkBAddr = 0xD190
local pokemonSlot1DefAAddr = 0xD191
local pokemonSlot1DefBAddr = 0xD192
local pokemonSlot1SpdAAddr = 0xD193
local pokemonSlot1SpdBAddr = 0xD194
local pokemonSlot1SpcAAddr = 0xD195
local pokemonSlot1SpcBAddr = 0xD196
local pokemonSlot1Move1Addr = 0xD173
local pokemonSlot1Move1PpAddr = 0xD188
local pokemonSlot1Move2Addr = 0xD174
local pokemonSlot1Move2PpAddr = 0xD189
local pokemonSlot1Move3Addr = 0xD175
local pokemonSlot1Move3PpAddr = 0xD18A
local pokemonSlot1Move4Addr = 0xD176
local pokemonSlot1Move4PpAddr = 0xD18B
local pokemonSlot1LevelAddr = 0xD18C

local pokemonSlot2AAddr = 0xD165
local pokemonSlot2BAddr = 0xD197
local pokemonSlot2Type1 = 0xD19C
local pokemonSlot2Type2 = 0xD19D
local pokemonSlot2CurrentHpAAddr = 0xD198
local pokemonSlot2CurrentHpBAddr = 0xD199
local pokemonSlot2HpAAddr = 0xD1B9
local pokemonSlot2HpBAddr = 0xD1BA
local pokemonSlot2AtkAAddr = 0xD1BB
local pokemonSlot2AtkBAddr = 0xD1BC
local pokemonSlot2DefAAddr = 0xD1BD
local pokemonSlot2DefBAddr = 0xD1BE
local pokemonSlot2SpdAAddr = 0xD1BF
local pokemonSlot2SpdBAddr = 0xD1C0
local pokemonSlot2SpcAAddr = 0xD1C1
local pokemonSlot2SpcBAddr = 0xD1C2
local pokemonSlot2Move1Addr = 0xD19F
local pokemonSlot2Move1PpAddr = 0xD1B4
local pokemonSlot2Move2Addr = 0xD1A0
local pokemonSlot2Move2PpAddr = 0xD1B5
local pokemonSlot2Move3Addr = 0xD1A1
local pokemonSlot2Move3PpAddr = 0xD1B6
local pokemonSlot2Move4Addr = 0xD1A2
local pokemonSlot2Move4PpAddr = 0xD1B7
local pokemonSlot2LevelAddr = 0xD1B8

local pokemonSlot3AAddr = 0xD166
local pokemonSlot3BAddr = 0xD1C3
local pokemonSlot3Type1 = 0xD1C8
local pokemonSlot3Type2 = 0xD1C9
local pokemonSlot3CurrentHpAAddr = 0xD1C4
local pokemonSlot3CurrentHpBAddr = 0xD1C5
local pokemonSlot3HpAAddr = 0xD1E5
local pokemonSlot3HpBAddr = 0xD1E6
local pokemonSlot3AtkAAddr = 0xD1E7
local pokemonSlot3AtkBAddr = 0xD1E8
local pokemonSlot3DefAAddr = 0xD1E9
local pokemonSlot3DefBAddr = 0xD1EA
local pokemonSlot3SpdAAddr = 0xD1EB
local pokemonSlot3SpdBAddr = 0xD1EC
local pokemonSlot3SpcAAddr = 0xD1ED
local pokemonSlot3SpcBAddr = 0xD1EE
local pokemonSlot3Move1Addr = 0xD1CB
local pokemonSlot3Move1PpAddr = 0xD1E0
local pokemonSlot3Move2Addr = 0xD1CC
local pokemonSlot3Move2PpAddr = 0xD1E1
local pokemonSlot3Move3Addr = 0xD1CD
local pokemonSlot3Move3PpAddr = 0xD1E2
local pokemonSlot3Move4Addr = 0xD1CE
local pokemonSlot3Move4PpAddr = 0xD1E3
local pokemonSlot3LevelAddr = 0xD1E4

function charToHex(char)
    --Nidoran gender codes
    --Mr. Mime period
    --Farfetch'd apostrophe
    if char == "1" then
        return 0xEF
    elseif char == "2" then
        return 0xF5
    elseif char == 0x50 then
        return 0x50
    elseif char == "." then
        return 0xE8
    elseif char == "'" then
        return 0xE0
    end
    local alphabet = "ABCDEFGHIJKLMNOPQRSTUVWXYZ"
    for i = 1, #alphabet do
        if char == alphabet:sub(i, i) then
            return 0x80 + i - 1
        end
    end
    return nil;
end

function writeNameBytes(stringName, slotNumber)
    local pokemon1NameAddrPointer = 0xD2B5
    local pokemon2NameAddrPointer = 0xD2C0
    local pokemon3NameAddrPointer = 0xD2CB
    local nameLength = 10;
    for i = 1, nameLength do
        local char;
        if i <= #stringName then
            char = stringName:sub(i, i)
        else
            --zero out the remaining name slots so we don't get the data from the previous pokemon's name
            char = 0x50;
        end
        local address;
        if slotNumber == 1 then
            address = pokemon1NameAddrPointer + i - 1;
        elseif slotNumber == 2 then
            address = pokemon2NameAddrPointer + i - 1;
        elseif slotNumber == 3 then
            address = pokemon3NameAddrPointer + i - 1;
        end
        memory.writebyte(address, charToHex(char))
    end
end

--Team 1 (Left Screen)
memory.usememorydomain("L System Bus")

memory.writebyte(pokemonSlot1AAddr, teams.team1.pokemon1.pokemonCode)
memory.writebyte(pokemonSlot1BAddr, teams.team1.pokemon1.pokemonCode)
memory.writebyte(pokemonSlot1Type1, teams.team1.pokemon1.pokemonType1)
memory.writebyte(pokemonSlot1Type2, teams.team1.pokemon1.pokemonType2)
memory.writebyte(pokemonSlot1HpAAddr, teams.team1.pokemon1.pokemonHp1)
memory.writebyte(pokemonSlot1HpBAddr, teams.team1.pokemon1.pokemonHp2)
memory.writebyte(pokemonSlot1CurrentHpAAddr, teams.team1.pokemon1.pokemonHp1)
memory.writebyte(pokemonSlot1CurrentHpBAddr, teams.team1.pokemon1.pokemonHp2)
memory.writebyte(pokemonSlot1AtkAAddr, teams.team1.pokemon1.pokemonAttack1)
memory.writebyte(pokemonSlot1AtkBAddr, teams.team1.pokemon1.pokemonAttack2)
memory.writebyte(pokemonSlot1DefAAddr, teams.team1.pokemon1.pokemonDefense1)
memory.writebyte(pokemonSlot1DefBAddr, teams.team1.pokemon1.pokemonDefense2)
memory.writebyte(pokemonSlot1SpdAAddr, teams.team1.pokemon1.pokemonSpeed1)
memory.writebyte(pokemonSlot1SpdBAddr, teams.team1.pokemon1.pokemonSpeed2)
memory.writebyte(pokemonSlot1SpcAAddr, teams.team1.pokemon1.pokemonSpecial1)
memory.writebyte(pokemonSlot1SpcBAddr, teams.team1.pokemon1.pokemonSpecial2)
memory.writebyte(pokemonSlot1Move1Addr, teams.team1.pokemon1.move1Code)
memory.writebyte(pokemonSlot1Move1PpAddr, teams.team1.pokemon1.move1Pp)
memory.writebyte(pokemonSlot1Move2Addr, teams.team1.pokemon1.move2Code)
memory.writebyte(pokemonSlot1Move2PpAddr, teams.team1.pokemon1.move2Pp)
memory.writebyte(pokemonSlot1Move3Addr, teams.team1.pokemon1.move3Code)
memory.writebyte(pokemonSlot1Move3PpAddr, teams.team1.pokemon1.move3Pp)
memory.writebyte(pokemonSlot1Move4Addr, teams.team1.pokemon1.move4Code)
memory.writebyte(pokemonSlot1Move4PpAddr, teams.team1.pokemon1.move4Pp)
memory.writebyte(pokemonSlot1LevelAddr, teams.team1.pokemon1.pokemonLevel)
writeNameBytes(teams.team1.pokemon1.pokemonName, 1)

memory.writebyte(pokemonSlot2AAddr, teams.team1.pokemon2.pokemonCode)
memory.writebyte(pokemonSlot2BAddr, teams.team1.pokemon2.pokemonCode)
memory.writebyte(pokemonSlot2Type1, teams.team1.pokemon2.pokemonType1)
memory.writebyte(pokemonSlot2Type2, teams.team1.pokemon2.pokemonType2)
memory.writebyte(pokemonSlot2HpAAddr, teams.team1.pokemon2.pokemonHp1)
memory.writebyte(pokemonSlot2HpBAddr, teams.team1.pokemon2.pokemonHp2)
memory.writebyte(pokemonSlot2CurrentHpAAddr, teams.team1.pokemon2.pokemonHp1)
memory.writebyte(pokemonSlot2CurrentHpBAddr, teams.team1.pokemon2.pokemonHp2)
memory.writebyte(pokemonSlot2AtkAAddr, teams.team1.pokemon2.pokemonAttack1)
memory.writebyte(pokemonSlot2AtkBAddr, teams.team1.pokemon2.pokemonAttack2)
memory.writebyte(pokemonSlot2DefAAddr, teams.team1.pokemon2.pokemonDefense1)
memory.writebyte(pokemonSlot2DefBAddr, teams.team1.pokemon2.pokemonDefense2)
memory.writebyte(pokemonSlot2SpdAAddr, teams.team1.pokemon2.pokemonSpeed1)
memory.writebyte(pokemonSlot2SpdBAddr, teams.team1.pokemon2.pokemonSpeed2)
memory.writebyte(pokemonSlot2SpcAAddr, teams.team1.pokemon2.pokemonSpecial1)
memory.writebyte(pokemonSlot2SpcBAddr, teams.team1.pokemon2.pokemonSpecial2)
memory.writebyte(pokemonSlot2Move1Addr, teams.team1.pokemon2.move1Code)
memory.writebyte(pokemonSlot2Move1PpAddr, teams.team1.pokemon2.move1Pp)
memory.writebyte(pokemonSlot2Move2Addr, teams.team1.pokemon2.move2Code)
memory.writebyte(pokemonSlot2Move2PpAddr, teams.team1.pokemon2.move2Pp)
memory.writebyte(pokemonSlot2Move3Addr, teams.team1.pokemon2.move3Code)
memory.writebyte(pokemonSlot2Move3PpAddr, teams.team1.pokemon2.move3Pp)
memory.writebyte(pokemonSlot2Move4Addr, teams.team1.pokemon2.move4Code)
memory.writebyte(pokemonSlot2Move4PpAddr, teams.team1.pokemon2.move4Pp)
memory.writebyte(pokemonSlot2LevelAddr, teams.team1.pokemon2.pokemonLevel)
writeNameBytes(teams.team1.pokemon2.pokemonName, 2)

memory.writebyte(pokemonSlot3AAddr, teams.team1.pokemon3.pokemonCode)
memory.writebyte(pokemonSlot3BAddr, teams.team1.pokemon3.pokemonCode)
memory.writebyte(pokemonSlot3Type1, teams.team1.pokemon3.pokemonType1)
memory.writebyte(pokemonSlot3Type2, teams.team1.pokemon3.pokemonType2)
memory.writebyte(pokemonSlot3HpAAddr, teams.team1.pokemon3.pokemonHp1)
memory.writebyte(pokemonSlot3HpBAddr, teams.team1.pokemon3.pokemonHp2)
memory.writebyte(pokemonSlot3CurrentHpAAddr, teams.team1.pokemon3.pokemonHp1)
memory.writebyte(pokemonSlot3CurrentHpBAddr, teams.team1.pokemon3.pokemonHp2)
memory.writebyte(pokemonSlot3AtkAAddr, teams.team1.pokemon3.pokemonAttack1)
memory.writebyte(pokemonSlot3AtkBAddr, teams.team1.pokemon3.pokemonAttack2)
memory.writebyte(pokemonSlot3DefAAddr, teams.team1.pokemon3.pokemonDefense1)
memory.writebyte(pokemonSlot3DefBAddr, teams.team1.pokemon3.pokemonDefense2)
memory.writebyte(pokemonSlot3SpdAAddr, teams.team1.pokemon3.pokemonSpeed1)
memory.writebyte(pokemonSlot3SpdBAddr, teams.team1.pokemon3.pokemonSpeed2)
memory.writebyte(pokemonSlot3SpcAAddr, teams.team1.pokemon3.pokemonSpecial1)
memory.writebyte(pokemonSlot3SpcBAddr, teams.team1.pokemon3.pokemonSpecial2)
memory.writebyte(pokemonSlot3Move1Addr, teams.team1.pokemon3.move1Code)
memory.writebyte(pokemonSlot3Move1PpAddr, teams.team1.pokemon3.move1Pp)
memory.writebyte(pokemonSlot3Move2Addr, teams.team1.pokemon3.move2Code)
memory.writebyte(pokemonSlot3Move2PpAddr, teams.team1.pokemon3.move2Pp)
memory.writebyte(pokemonSlot3Move3Addr, teams.team1.pokemon3.move3Code)
memory.writebyte(pokemonSlot3Move3PpAddr, teams.team1.pokemon3.move3Pp)
memory.writebyte(pokemonSlot3Move4Addr, teams.team1.pokemon3.move4Code)
memory.writebyte(pokemonSlot3Move4PpAddr, teams.team1.pokemon3.move4Pp)
memory.writebyte(pokemonSlot3LevelAddr, teams.team1.pokemon3.pokemonLevel)
writeNameBytes(teams.team1.pokemon3.pokemonName, 3)

--Team 2 (Right Screen)
memory.usememorydomain("R System Bus")

memory.writebyte(pokemonSlot1AAddr, teams.team2.pokemon1.pokemonCode)
memory.writebyte(pokemonSlot1BAddr, teams.team2.pokemon1.pokemonCode)
memory.writebyte(pokemonSlot1Type1, teams.team2.pokemon1.pokemonType1)
memory.writebyte(pokemonSlot1Type2, teams.team2.pokemon1.pokemonType2)
memory.writebyte(pokemonSlot1HpAAddr, teams.team2.pokemon1.pokemonHp1)
memory.writebyte(pokemonSlot1HpBAddr, teams.team2.pokemon1.pokemonHp2)
memory.writebyte(pokemonSlot1CurrentHpAAddr, teams.team2.pokemon1.pokemonHp1)
memory.writebyte(pokemonSlot1CurrentHpBAddr, teams.team2.pokemon1.pokemonHp2)
memory.writebyte(pokemonSlot1AtkAAddr, teams.team2.pokemon1.pokemonAttack1)
memory.writebyte(pokemonSlot1AtkBAddr, teams.team2.pokemon1.pokemonAttack2)
memory.writebyte(pokemonSlot1DefAAddr, teams.team2.pokemon1.pokemonDefense1)
memory.writebyte(pokemonSlot1DefBAddr, teams.team2.pokemon1.pokemonDefense2)
memory.writebyte(pokemonSlot1SpdAAddr, teams.team2.pokemon1.pokemonSpeed1)
memory.writebyte(pokemonSlot1SpdBAddr, teams.team2.pokemon1.pokemonSpeed2)
memory.writebyte(pokemonSlot1SpcAAddr, teams.team2.pokemon1.pokemonSpecial1)
memory.writebyte(pokemonSlot1SpcBAddr, teams.team2.pokemon1.pokemonSpecial2)
memory.writebyte(pokemonSlot1Move1Addr, teams.team2.pokemon1.move1Code)
memory.writebyte(pokemonSlot1Move1PpAddr, teams.team2.pokemon1.move1Pp)
memory.writebyte(pokemonSlot1Move2Addr, teams.team2.pokemon1.move2Code)
memory.writebyte(pokemonSlot1Move2PpAddr, teams.team2.pokemon1.move2Pp)
memory.writebyte(pokemonSlot1Move3Addr, teams.team2.pokemon1.move3Code)
memory.writebyte(pokemonSlot1Move3PpAddr, teams.team2.pokemon1.move3Pp)
memory.writebyte(pokemonSlot1Move4Addr, teams.team2.pokemon1.move4Code)
memory.writebyte(pokemonSlot1Move4PpAddr, teams.team2.pokemon1.move4Pp)
memory.writebyte(pokemonSlot1LevelAddr, teams.team2.pokemon1.pokemonLevel)
writeNameBytes(teams.team2.pokemon1.pokemonName, 1)

memory.writebyte(pokemonSlot2AAddr, teams.team2.pokemon2.pokemonCode)
memory.writebyte(pokemonSlot2BAddr, teams.team2.pokemon2.pokemonCode)
memory.writebyte(pokemonSlot2Type1, teams.team2.pokemon2.pokemonType1)
memory.writebyte(pokemonSlot2Type2, teams.team2.pokemon2.pokemonType2)
memory.writebyte(pokemonSlot2HpAAddr, teams.team2.pokemon2.pokemonHp1)
memory.writebyte(pokemonSlot2HpBAddr, teams.team2.pokemon2.pokemonHp2)
memory.writebyte(pokemonSlot2CurrentHpAAddr, teams.team2.pokemon2.pokemonHp1)
memory.writebyte(pokemonSlot2CurrentHpBAddr, teams.team2.pokemon2.pokemonHp2)
memory.writebyte(pokemonSlot2AtkAAddr, teams.team2.pokemon2.pokemonAttack1)
memory.writebyte(pokemonSlot2AtkBAddr, teams.team2.pokemon2.pokemonAttack2)
memory.writebyte(pokemonSlot2DefAAddr, teams.team2.pokemon2.pokemonDefense1)
memory.writebyte(pokemonSlot2DefBAddr, teams.team2.pokemon2.pokemonDefense2)
memory.writebyte(pokemonSlot2SpdAAddr, teams.team2.pokemon2.pokemonSpeed1)
memory.writebyte(pokemonSlot2SpdBAddr, teams.team2.pokemon2.pokemonSpeed2)
memory.writebyte(pokemonSlot2SpcAAddr, teams.team2.pokemon2.pokemonSpecial1)
memory.writebyte(pokemonSlot2SpcBAddr, teams.team2.pokemon2.pokemonSpecial2)
memory.writebyte(pokemonSlot2Move1Addr, teams.team2.pokemon2.move1Code)
memory.writebyte(pokemonSlot2Move1PpAddr, teams.team2.pokemon2.move1Pp)
memory.writebyte(pokemonSlot2Move2Addr, teams.team2.pokemon2.move2Code)
memory.writebyte(pokemonSlot2Move2PpAddr, teams.team2.pokemon2.move2Pp)
memory.writebyte(pokemonSlot2Move3Addr, teams.team2.pokemon2.move3Code)
memory.writebyte(pokemonSlot2Move3PpAddr, teams.team2.pokemon2.move3Pp)
memory.writebyte(pokemonSlot2Move4Addr, teams.team2.pokemon2.move4Code)
memory.writebyte(pokemonSlot2Move4PpAddr, teams.team2.pokemon2.move4Pp)
memory.writebyte(pokemonSlot2LevelAddr, teams.team2.pokemon2.pokemonLevel)
writeNameBytes(teams.team2.pokemon2.pokemonName, 2)

memory.writebyte(pokemonSlot3AAddr, teams.team2.pokemon3.pokemonCode)
memory.writebyte(pokemonSlot3BAddr, teams.team2.pokemon3.pokemonCode)
memory.writebyte(pokemonSlot3Type1, teams.team2.pokemon3.pokemonType1)
memory.writebyte(pokemonSlot3Type2, teams.team2.pokemon3.pokemonType2)
memory.writebyte(pokemonSlot3HpAAddr, teams.team2.pokemon3.pokemonHp1)
memory.writebyte(pokemonSlot3HpBAddr, teams.team2.pokemon3.pokemonHp2)
memory.writebyte(pokemonSlot3CurrentHpAAddr, teams.team2.pokemon3.pokemonHp1)
memory.writebyte(pokemonSlot3CurrentHpBAddr, teams.team2.pokemon3.pokemonHp2)
memory.writebyte(pokemonSlot3AtkAAddr, teams.team2.pokemon3.pokemonAttack1)
memory.writebyte(pokemonSlot3AtkBAddr, teams.team2.pokemon3.pokemonAttack2)
memory.writebyte(pokemonSlot3DefAAddr, teams.team2.pokemon3.pokemonDefense1)
memory.writebyte(pokemonSlot3DefBAddr, teams.team2.pokemon3.pokemonDefense2)
memory.writebyte(pokemonSlot3SpdAAddr, teams.team2.pokemon3.pokemonSpeed1)
memory.writebyte(pokemonSlot3SpdBAddr, teams.team2.pokemon3.pokemonSpeed2)
memory.writebyte(pokemonSlot3SpcAAddr, teams.team2.pokemon3.pokemonSpecial1)
memory.writebyte(pokemonSlot3SpcBAddr, teams.team2.pokemon3.pokemonSpecial2)
memory.writebyte(pokemonSlot3Move1Addr, teams.team2.pokemon3.move1Code)
memory.writebyte(pokemonSlot3Move1PpAddr, teams.team2.pokemon3.move1Pp)
memory.writebyte(pokemonSlot3Move2Addr, teams.team2.pokemon3.move2Code)
memory.writebyte(pokemonSlot3Move2PpAddr, teams.team2.pokemon3.move2Pp)
memory.writebyte(pokemonSlot3Move3Addr, teams.team2.pokemon3.move3Code)
memory.writebyte(pokemonSlot3Move3PpAddr, teams.team2.pokemon3.move3Pp)
memory.writebyte(pokemonSlot3Move4Addr, teams.team2.pokemon3.move4Code)
memory.writebyte(pokemonSlot3Move4PpAddr, teams.team2.pokemon3.move4Pp)
memory.writebyte(pokemonSlot3LevelAddr, teams.team2.pokemon3.pokemonLevel)
writeNameBytes(teams.team2.pokemon3.pokemonName, 3)