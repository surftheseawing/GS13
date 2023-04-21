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
	var/datum/action/innate/aura/heal
	
/datum/species/golem/calorite/on_species_gain(mob/living/carbon/C, datum/species/old_species)
	..()
	if(ishuman(C))
		heal = new
		heal.Grant(C)

/datum/species/golem/calorite/on_species_loss(mob/living/carbon/C)
	if(heal)
		heal.Remove(C)
	..()

/datum/action/innate/aura
	name = "Healing Aura"
	desc = "Emit a healing aura around yourself."
	check_flags = AB_CHECK_CONSCIOUS
	icon_icon = 'icons/mob/actions/actions_spells.dmi'
	button_icon_state = "sacredflame"

/datum/action/innate/aura/Activate()
	if(ishuman(owner))
		to_chat(owner, "<span class='notice'>You heal those around you!</span>")
		//Heal all those around you, unbiased
		for(var/mob/living/L in view(7, owner))
			if(L.health < L.maxHealth)
				new /obj/effect/temp_visual/heal(get_turf(L), "#375637")
			if(iscarbon(L))
				L.adjustBruteLoss(-3.5)
				L.adjustFireLoss(-3.5)
				L.adjustToxLoss(-3.5, forced = TRUE) //Because Slime People are people too
				L.adjustOxyLoss(-3.5)
				L.adjustStaminaLoss(-3.5)
				L.adjustOrganLoss(ORGAN_SLOT_BRAIN, -3.5)
				L.adjustCloneLoss(-1) //Becasue apparently clone damage is the bastion of all health
			else if(issilicon(L))
				L.adjustBruteLoss(-3.5)
				L.adjustFireLoss(-3.5)
			else if(isanimal(L))
				var/mob/living/simple_animal/SM = L
				SM.adjustHealth(-3.5, forced = TRUE)
