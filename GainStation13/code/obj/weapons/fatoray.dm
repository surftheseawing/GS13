/////GS13 - fattening rayguns and ranged weapons

///The base fatoray
/obj/item/gun/energy/fatoray
	name = "Fatoray"
	desc = "An energy gun that fattens up anyone it hits."
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	lefthand_file = 'GainStation13/icons/obj/guns_lefthand.dmi'
	righthand_file = 'GainStation13/icons/obj/guns_righthand.dmi'
	icon_state = "fatoray"
	item_state = "fatoray"
	pin = /obj/item/firing_pin
	fire_sound = 'sound/weapons/plasma_cutter.ogg'
	ammo_type = list(/obj/item/ammo_casing/energy/fattening)

/obj/item/ammo_casing/energy/fattening
	name = "fattening weapon lens"
	select_name = "fatten"
	projectile_type = /obj/item/projectile/energy/fattening

///The base projectile used by the fatoray
/obj/item/projectile/energy/fattening
	name = "fat energy"
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "ray"
	ricochets_max = 50
	ricochet_chance = 80
	hitsound = 'sound/weapons/sear.ogg'
	hitsound_wall = 'sound/weapons/effects/searwall.ogg'
	is_reflectable = TRUE
	light_range = 2
	light_color = LIGHT_COLOR_ORANGE
	///How much fat is added to the target mob?
	var/fat_to_add = ADJUST_FATNESS_ENERGY

////// Fatoray - cannon variant, strong but can be charged

/obj/item/gun/energy/fatoray/cannon
	name = "Fatoray Cannon"
	desc = "An energy gun that fattens up anyone it hits. This version functions as a glass cannon of some sorts. It cannot be recharged."
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "fatoray_cannon"
	recoil = 3
	can_charge = 0
	slowdown = 1
	pin = /obj/item/firing_pin
	// charge_sections = 3
	weapon_weight = WEAPON_HEAVY
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/cannon)


/obj/item/ammo_casing/energy/fattening/cannon
	name = "one-shot fattening weapon lens"
	select_name = "fatten"
	e_cost = 100
	projectile_type = /obj/item/projectile/energy/fattening/cannon

/obj/item/projectile/energy/fattening/cannon
	name = "fat energy"            
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "cannon_ray"
	///How much fat is added to the target mob?
	fat_to_add = ADJUST_FATNESS_ENERGY_CANNON

////////////////////////////////////////////////////////////////////
////////FATORAYS THAT CAN BE MADE BY LATHES OR RESEARCHED///////////
////////////////////////////////////////////////////////////////////

///Weaker version of fatoray
/obj/item/gun/energy/fatoray/weak
	name = "Basic Fatoray"
	desc = "An energy gun that fattens up anyone it hits. This version is considerably weaker than its original counterpart, the technology behind it seemingly still not  perfected."
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "fatoray_weak"
	pin = /obj/item/firing_pin
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/weak)

/obj/item/ammo_casing/energy/fattening/weak
	name = "budget fattening weapon lens"
	select_name = "fatten"
	projectile_type = /obj/item/projectile/energy/fattening/weak

///The base projectile used by the fatoray
/obj/item/projectile/energy/fattening/weak
	name = "fat energy"            
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "ray"
	///How much fat is added to the target mob?
	fat_to_add = ADJUST_FATNESS_ENERGY_WEAK

///////////////////////////////////////////////////

///Single shot glass cannon fatoray
/obj/item/gun/energy/fatoray/cannon_weak
	name = "Basic Fatoray Cannon"
	desc = "An energy gun that fattens up anyone it hits. This version functions as a glass cannon of some sorts. It cannot be recharged."
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "fatoray_cannon_weak"
	can_charge = 0
	recoil = 3
	slowdown = 1
	pin = /obj/item/firing_pin
	// charge_sections = 3
	weapon_weight = WEAPON_HEAVY
	ammo_type = list(/obj/item/ammo_casing/energy/fattening/cannon_weak)

/obj/item/ammo_casing/energy/fattening/cannon_weak
	name = "one-shot fattening weapon lens"
	select_name = "fatten"
	e_cost = 300
	projectile_type = /obj/item/projectile/energy/fattening/cannon_weak

/obj/item/projectile/energy/fattening/cannon_weak
	name = "fat energy"            
	icon = 'GainStation13/icons/obj/fatoray.dmi'
	icon_state = "cannon_ray"
	///How much fat is added to the target mob?
	fat_to_add = ADJUST_FATNESS_ENERGY_CANNON_WEAK

///////////////////////////////////////
//////PROJECTILE MECHANICS/////////////
///////////////////////////////////////


/obj/item/projectile/energy/fattening/on_hit(atom/target, blocked)
	. = ..()
	
	var/mob/living/carbon/gainer = target
	if(!iscarbon(gainer))
		return FALSE
	
	if(!gainer.adjust_fatness(fat_to_add, FATTENING_TYPE_WEAPON))
		return FALSE

	return TRUE
