//we'll put funky non-toxic chems here

//fattening chem
/datum/reagent/consumable/lipoifier
	name = "Lipoifier"
	description = "A very potent chemical that causes those that ingest it to build up fat cells quickly."
	taste_description = "lard"
	reagent_state = LIQUID
	color = "#e2e1b1"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM
	var/fat_to_add = ADJUST_FATNESS_REAGENT

/datum/reagent/consumable/lipoifier/on_mob_life(mob/living/carbon/M)
	M.adjust_fatness(fat_to_add, FATTENING_TYPE_CHEM)
	return ..()

// TODO lipoifier OD -> fizulphite

//BURPY CHEM

/datum/reagent/consumable/fizulphite
	name = "Fizulphite"
	description = "A strange chemical that produces large amounts of gas when in contact with organic, typically fleshy environments."
	color = "#4cffed" // rgb: 102, 99, 0
	reagent_state = LIQUID
	taste_description = "fizziness"
	metabolization_rate = 2 * REAGENTS_METABOLISM

/datum/reagent/consumable/fizulphite/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs.weight_gain_chems)
		M.fullness += ADJUST_FULLNESS_MAJOR_MIN
		if (M.burpslurring < ADJUST_BURPLSLUR_MAX)
			M.burpslurring += ADJUST_BURPLSLUR_GAIN
		var/amount = M.reagents.get_reagent_amount(/datum/reagent/consumable/fizulphite)
		if(amount >= 3)
			to_chat(M,"<span class='notice'>You feel pretty gassy...</span>")
			M.emote("belch")
		else if(amount >= 1)
			to_chat(M,"<span class='notice'>You feel substantially bloated...</span>")
			M.emote("burp")
	return ..()

//ANTI-BURPY CHEM

/datum/reagent/consumable/extilphite
	name = "Extilphite"
	description = "A very useful chemical that helps soothe bloated stomachs."
	color = "#2aed96"
	reagent_state = LIQUID
	taste_description = "smoothness"
	metabolization_rate = 0.8 * REAGENTS_METABOLISM

/datum/reagent/consumable/extilphite/on_mob_life(mob/living/carbon/M)
	if(M.fullness > FULLNESS_LEVEL_HALF_FULL)
		M.fullness -= ADJUST_FULLNESS_MAJOR_MAX
	if(M && M?.client?.prefs.weight_gain_chems)
		M.burpslurring -= ADJUST_BURPLSLUR_LOSE
	return ..()

//FARTY CHEM

/datum/reagent/consumable/flatulose
	name = "Flatulose"
	description = "A sugar largely indigestible to most known organic organisms. Causes frequent flatulence."
	color = "#634500"
	reagent_state = LIQUID
	taste_description = "sulfury sweetness"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM //Done by Zestyspy, Jan 2023

/datum/reagent/consumable/flatulose/on_mob_life(mob/living/carbon/M)
	if(M && M?.client?.prefs.weight_gain_chems)
		var/amount = M.reagents.get_reagent_amount(/datum/reagent/consumable/flatulose)
		if(amount > 3)
			to_chat(M,"<span class='notice'>You feel pretty gassy...</span>")
			M.emote(pick("brap","fart")) // we gotta categorize this into "slob" category or something later! - GDLW2
		else if(amount > 1)
			to_chat(M,"<span class='notice'>You feel substantially bloated...</span>")
	return ..()

// calorite blessing chem, used in the golem ability

/datum/reagent/consumable/caloriteblessing
	name = "Calorite blessing"
	description = "A strange, viscous liquid derived from calorite. It is said to have physically enhancing properties surprisingly unrelated to weight gain when consumed"
	color = "#eb6e00"
	reagent_state = LIQUID
	taste_description = "sweet salvation"
	metabolization_rate = 0.5 * REAGENTS_METABOLISM

/datum/reagent/consumable/caloriteblessing/on_mob_metabolize(mob/living/L)
	return ..()
	ADD_TRAIT(L, TRAIT_GOTTAGOFAST, type)

/datum/reagent/consumable/caloriteblessing/on_mob_end_metabolize(mob/living/L)
	REMOVE_TRAIT(L, TRAIT_GOTTAGOFAST, type)
	return ..()

//BLUEBERRY CHEM - ONLY CHANGES PLAYER'S COLOR AND NOTHING MORE

/datum/reagent/blueberry_juice
	name = "Blueberry Juice"
	description = "Non-infectious. Hopefully."
	reagent_state = LIQUID
	color = "#0004ff"
	var/list/random_color_list = list("#0058db","#5d00c7","#0004ff","#0057e7")
	taste_description = "blueberry pie"
	var/no_mob_color = FALSE

/datum/reagent/blueberry_juice/on_mob_life(mob/living/carbon/M)
	if(!no_mob_color)
		M.add_atom_colour(pick(random_color_list), WASHABLE_COLOUR_PRIORITY)
	return ..()
