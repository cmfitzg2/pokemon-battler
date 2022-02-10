# Pokemon Battler

### Breakdown
init:
	pokemon script file runs from previous java iteration (run java main at least once or use existing Randomize-Teams.lua)
loop:
	java picks next team
	betting phase open for 1:00 or whatever
	battle runs
	battle outcome output with winner, loser, team, and timestamp for when the next battle will start
	java reads output and pays out winners (pay out extra for upsets?)

obs:
    scene 0:
        -initializing.................
loop:
	scene 1: 
        -betting phase, RED vs BLUE / Team previews, countdown timer, bet now, bet commands shown
	scene 2:
        -battle start, RED / BLUE split game screens in overlay, team overviews, non-bet commands visible, battle timer, bet totals (if space allows)
	scene 3: 
        -battle outcome "X WINS!", dead pokemon get X's drawn over them?

obs impl (py or lua):
	script that listens for cues to change scenes via output files
	scene 1: 
        -java outputs image files containing team data, script picks up teams.txt containing pokemon names and any other info needed (bet totals?)
        -delete teams.txt
        -basic static overlay with dynamic pokemon images loaded from file system, kept in memory for later. timer reset on switch
        -switch to scene 2 when time = battle start time
    scene 2:
        -completely static overlay other than potential battle timer and bet totals
        -switch to scene 3 when outcome.txt exists after writing its data to the scene
        -delete outcome.txt
    scene 3:
        -static overlay + the images from scene 1 + X's over dead pokemon (unless draw??)