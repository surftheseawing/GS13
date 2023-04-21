/datum/species/golem/calorite //golems that heal people around them, and cook groovy food. essentially the support class of golems
	name = "Calorite Golem"
	id = "calorite golem"
	prefix = "Calorite"
	special_names = list("Callie Wright")
	info_text = "As a <span class='danger'>Calorite Golem</span>, you can heal other people just by standing close to them, and your cooking is more nourishing than it would be if produced by anyone else. Unfortunately, you are also very flimsy, and can't dish out much damage with your hands."
	fixed_mut_color = "ffffff"
	limbs_id = "cal_golem" //special sprites
	attack_verb = "bop" //they don't hit too hard, so their attack verb is fittingly pretty soft
	armor = 25
	punchdamagelow = 5
	punchstunthreshold = 0 //no chance to stun
	punchdamagehigh = 5
	var/datum/action/innate/ignite/ignite

	
/datum/action/innate/ignite
	name = "Ignite"
	desc = "Set yourself aflame, bringing yourself closer to exploding!"
	check_flags = AB_CHECK_CONSCIOUS
	button_icon_state = "sacredflame"

/datum/species/golem/calorite/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	
	if(ishuman(owner))
		ignite = new
		ignite.Grant(owner)
	..()

/datum/species/golem/calorite/on_species_loss(mob/living/carbon/C)
	if(ignite)
		ignite.Remove(C)
	..()

/datum/action/innate/ignite/Activate()
	var/mob/living/carbon/human/C = owner
	C.put_in_hands(/obj/item/melee/touch_attack/fattening/steal)
	to_chat(owner, "<span class='balling</span>")