local teams =
{
	team1 =
	{
		pokemon1 =
		{
			pokemonName = "Golduck",
			pokemonCode = 0x80,
			pokemonLevel = 0x32,
			pokemonType1 = 0x15,
			pokemonType2 = 0x15,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0xb1,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x7d,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x73,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x70,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x72,
			move1Code = 0x94,
			move1Pp = 0x14,
			move2Code = 0x1E,
			move2Pp = 0x19,
			move3Code = 0x1C,
			move3Pp = 0xf,
			move4Code = 0x74,
			move4Pp = 0x1e
		},
		pokemon2 =
		{
			pokemonName = "Butterfree",
			pokemonCode = 0x7D,
			pokemonLevel = 0x32,
			pokemonType1 = 0x07,
			pokemonType2 = 0x02,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0x98,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x50,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x4b,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x6a,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x75,
			move1Code = 0x9B,
			move1Pp = 0xa,
			move2Code = 0x8F,
			move2Pp = 0x5,
			move3Code = 0xA3,
			move3Pp = 0x14,
			move4Code = 0x44,
			move4Pp = 0x14
		},
		pokemon3 =
		{
			pokemonName = "Sandshrew",
			pokemonCode = 0x60,
			pokemonLevel = 0x32,
			pokemonType1 = 0x04,
			pokemonType2 = 0x04,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0x83,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x7a,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x68,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x43,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x3e,
			move1Code = 0x3F,
			move1Pp = 0x5,
			move2Code = 0x22,
			move2Pp = 0xf,
			move3Code = 0x57,
			move3Pp = 0xa,
			move4Code = 0x86,
			move4Pp = 0xf
		}
	},
	team2 =
	{
		pokemon1 =
		{
			pokemonName = "Eevee",
			pokemonCode = 0x66,
			pokemonLevel = 0x32,
			pokemonType1 = 0x00,
			pokemonType2 = 0x00,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0x95,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x54,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x51,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x65,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x57,
			move1Code = 0x79,
			move1Pp = 0xa,
			move2Code = 0x2C,
			move2Pp = 0x19,
			move3Code = 0x5C,
			move3Pp = 0xa,
			move4Code = 0x70,
			move4Pp = 0x1e
		},
		pokemon2 =
		{
			pokemonName = "Exeggcute",
			pokemonCode = 0x0C,
			pokemonLevel = 0x32,
			pokemonType1 = 0x16,
			pokemonType2 = 0x18,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0x8b,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x40,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x75,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x46,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x49,
			move1Code = 0x8D,
			move1Pp = 0xf,
			move2Code = 0x72,
			move2Pp = 0x1e,
			move3Code = 0x78,
			move3Pp = 0x5,
			move4Code = 0x2A,
			move4Pp = 0x14
		},
		pokemon3 =
		{
			pokemonName = "Slowbro",
			pokemonCode = 0x08,
			pokemonLevel = 0x32,
			pokemonType1 = 0x15,
			pokemonType2 = 0x18,
			pokemonHp1 = 0x00,
			pokemonHp2 = 0xbe,
			pokemonAttack1 = 0x00,
			pokemonAttack2 = 0x64,
			pokemonDefense1 = 0x00,
			pokemonDefense2 = 0x96,
			pokemonSpeed1 = 0x00,
			pokemonSpeed2 = 0x4c,
			pokemonSpecial1 = 0x00,
			pokemonSpecial2 = 0x6a,
			move1Code = 0x40,
			move1Pp = 0x23,
			move2Code = 0x3B,
			move2Pp = 0x5,
			move3Code = 0x2F,
			move3Pp = 0xf,
			move4Code = 0x32,
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