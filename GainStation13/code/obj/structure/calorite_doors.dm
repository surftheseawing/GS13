

/obj/structure/mineral_door/calorite //GS13
	name = "calorite door"
	icon = 'GainStation13/icons/obj/structure/calorite_door.dmi'
	icon_state = "calorite"
	sheetType = /obj/item/stack/sheet/mineral/calorite
	max_integrity = 200
	light_range = 1
	var/fatten = FALSE // whether player will be fattened
	var/fatten_delay = 1 // ticks per periodic loop
	var/fat_to_add = ADJUST_FATNESS_CALORITE_DOOR // fatness per tick stunned
	var/stuck = FALSE // whether player is stuck
	var/stuck_delay = 0 // set in proc/Fatten
	var/blocked = FALSE // whether door is blocked

// override /obj/structure/mineral_door/proc/Open()
/obj/structure/mineral_door/calorite/Open() //GS13
	isSwitchingStates = 1
	playsound(src, openSound, 100, 1)
	set_opacity(FALSE)
	flick("[initial_state]opening",src)
	sleep(10)
	density = FALSE
	state = 1
	air_update_turf(1)
	update_icon()
	isSwitchingStates = 0

	if(close_delay != -1)
		addtimer(CALLBACK(src, .proc/Close), close_delay)

	// start periodic loop
	stuck = FALSE
	addtimer(CALLBACK(src, .proc/Fatten), fatten_delay)

/obj/structure/mineral_door/calorite/proc/Fatten() //GS13
	if(state == 1) // door must be open
		// check periodically
		addtimer(CALLBACK(src, .proc/Fatten), fatten_delay)
		// check for mobs in open door
		var/turf/T = get_turf(src)
		blocked = FALSE
		for(var/mob/living/carbon/M in T)
			blocked = TRUE
			// determine if mob should get stuck and be fattened
			if(M.fatness >= FATNESS_LEVEL_BARELYMOBILE)
				fatten = TRUE
				if (!stuck)
					stuck_delay = 120
					M.visible_message(
						"<span class='boldnotice'>[M] gets stuck in the doorway!</span>",
						"<span class='boldwarning'>You feel yourself get stuck in the doorway!</span>")
			else if(M.fatness >= FATNESS_LEVEL_MORBIDLY_OBESE)
				fatten = TRUE
				if (!stuck)
					stuck_delay = 50
					M.visible_message(
						"<span class='boldnotice'>[M] barely squeezes through the doorway!</span>",
						"<span class='boldwarning'>You feel your sides barely squeeze through the doorway!</span>")
			else if(M.fatness >= FATNESS_LEVEL_FATTER)
				fatten = TRUE
				if (!stuck)
					stuck_delay = 15
					M.visible_message(
						"<span class='boldnotice'>[M]'s sides briefly smush against the doorway.</span>",
						"<span class='boldwarning'>You feel your sides smush against the doorway!.</span>")
			else if(M.fatness >= FATNESS_LEVEL_FAT)
				fatten = TRUE
				if (!stuck)
					stuck_delay = 5
					M.visible_message(
						"<span class='boldnotice'>[M]'s sides briefly brush against the doorway.</span>",
						"<span class='boldwarning'>You feel your sides briefly brush against the doorway!</span>")
			else
				fatten = FALSE
				stuck = FALSE
				stuck_delay = 0

			if (fatten) // get stuck
				if (!stuck)
					M.Stun(stuck_delay/2) // give player time to escape
					stuck = TRUE
				if (stuck_delay > 0) // wait for stun to end
					stuck_delay = stuck_delay - fatten_delay
					if (stuck_delay <= 0)
						stuck_delay = 0
					// gain weight while stuck
					M.adjust_fatness(fat_to_add, FATTENING_TYPE_ITEM)

	if (!blocked)
		stuck = FALSE // ready to go again
