// Wizard mutator

#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "x2_inc_switches"
#include "lutes"
#include "x3_inc_skin"

void MMP_DoEquip()
{
    AssignCommand(OBJECT_SELF,ActionEquipMostEffectiveArmor());
}

object MMP_GenerateRing()
{
    string sRing = "lutes_ring0";
    int n = Random(10)+1;
    if( n < 10) sRing = sRing + "0" + IntToString(n);
    else sRing = sRing + IntToString(n);
    object oRing = CreateItemOnObject(sRing,oObject,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oRing;
    Enchants.sName = "Enchanted Ring";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);
    return oRing;
}

object MMP_GenerateAmulet()
{
    string sAmulet = "lutes_amulet0";
    int n = Random(10)+1;
    if( n < 10) sAmulet = sAmulet + "0" + IntToString(n);
    else sAmulet = sAmulet + IntToString(n);
    object oAmulet = CreateItemOnObject(sAmulet,oObject,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oAmulet;
    Enchants.sName = "Enchanted Amulet";
    EnchantItem(Enchants);
    SetName(Enchants.oItem,Enchants.sName);
    return oAmulet;
}

object MMP_GenerateWand()
{
    string item = "lutes_wand";
    object oitem = CreateItemOnObject(item,OBJECT_SELF,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Wand";
    SetName(oitem,Enchants.sName);
    SetIdentified(oitem, TRUE);
    EnchantMagic(Enchants);
    return oitem;
}

object MMP_GenerateStaff()
{
    string item = "lutes_staff";
    object oitem = CreateItemOnObject(item,OBJECT_SELF,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Staff";
    SetName(oitem,Enchants.sName);
    struct sItemInfo info;

    struct sItemInfo wi;
    wi.sBluePrint=item;
    wi.sName     ="Enchanted Staff";
    wi.wType     = WEAPON_STAFF;
    EnchantWeapon(wi);
    EnchantMagic(Enchants);
    return oitem;
}

object MMP_GenerateRod()
{
    string item = "lutes_rod";
    object oitem = CreateItemOnObject(item,OBJECT_SELF,1);
    struct sEnchantments Enchants;
    Enchants.oItem = oitem;
    Enchants.sName = "Enchanted Rod";
    SetName(oitem,Enchants.sName);
    SetIdentified(oitem, TRUE);
    EnchantMagic(Enchants);
    return oitem;
}


object MMP_GenerateClericWeapon(int type = -1)
{
    struct sItemInfo ItemInfo;

    int iRoll = Random(5)+1;
    ItemInfo=GenerateBluntWeapon();

    ItemInfo.oItem = CreateItemOnObject(ItemInfo.sBluePrint,oObject);
    if( !GetIsObjectValid(ItemInfo.oItem) )
    {
        PrintString("Create Weapon " + ItemInfo.sName + " bp="+ItemInfo.sBluePrint+" failed.");
        return OBJECT_INVALID;
    }
    EnchantWeapon(ItemInfo);
    return ItemInfo.oItem;
}

object MMP_GenerateHeavyArmor()
{
    int iRoll = d6();
    struct sItemInfo ItemInfo;
    switch(iRoll)
    {
    case 1: ItemInfo = GenerateBandedMail(); break;
    case 2: ItemInfo = GenerateFullPlate(); break;
    case 3: ItemInfo = GenerateHalfPlate(); break;
    case 4: ItemInfo = GenerateSplintMail(); break;
    case 5: ItemInfo = GenerateScaleMail(); break;
    case 6: ItemInfo = GenerateBreastPlate(); break;
    case 7:
    default:
        ItemInfo = GenerateChainMail(); break;
    }

    ItemInfo.oItem = CreateItemOnObject(ItemInfo.sBluePrint,oObject);
    if( !GetIsObjectValid(ItemInfo.oItem) )
    {
        PrintString("Create Armor " + ItemInfo.sName + " bp="+ItemInfo.sBluePrint+" failed.");
        return OBJECT_INVALID;
    }
    EnchantArmor(ItemInfo);
    return ItemInfo.oItem;

}


object MMP_GenerateShield()
{
    int iRoll = d3();
    struct sItemInfo ItemInfo;

    switch(iRoll)
    {
    case 1: ItemInfo = GenerateSmallShield(); break;
    case 2: ItemInfo = GenerateLargeShield(); break;
    case 3: ItemInfo = GenerateTowerShield(); break;
    }

    ItemInfo.oItem = CreateItemOnObject(ItemInfo.sBluePrint,oObject);
    if( !GetIsObjectValid(ItemInfo.oItem) )
    {
        PrintString("Create Shield " + ItemInfo.sName + " bp="+ItemInfo.sBluePrint+" failed.");
        return OBJECT_INVALID;
    }

    EnchantArmor(ItemInfo);
    return ItemInfo.oItem;

}

void main()
{
    ExecuteScript("nw_c2_default9",OBJECT_SELF);
    if(GetLocalInt(GetModule(),"bUseAIScripts") == FALSE) return;

    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_STEALTH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_STEALTH);
    }
    // * Same, but for Search mode
    // *
    // SetSpawnInCondition(NW_FLAG_SEARCH);

    //--------------------------------------------------------------------------
    // Make creature enter search mode after spawning by setting a variable
    // Great for guards, etc
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_SEARCH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_SEARCH);
    }
    // * This will set the NPC to give a warning to non-enemies
    // * before attacking.
    // * NN -- no clue what this really does yet
    // *
    // SetSpawnInCondition(NW_FLAG_SET_WARNINGS);

    // * Separate the NPC's waypoints into day & night.
    // * See comment on WalkWayPoints() for use.
    // *
    // SetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING);

    // * If this is set, the NPC will appear using the "EffectAppear"
    // * animation instead of fading in, *IF* SetListeningPatterns()
    // * is called below.
    // *
    //SetSpawnInCondition(NW_FLAG_APPEAR_SPAWN_IN_ANIMATION);

    // * This will cause an NPC to use common animations it possesses,
    // * and use social ones to any other nearby friendly NPCs.
    // *
    // SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);

    //--------------------------------------------------------------------------
    // Enable immobile ambient animations by setting a variable
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT_IMMOBILE) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    }
    // * Same as above, except NPC will wander randomly around the
    // * area.
    // *
    // SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);


    //--------------------------------------------------------------------------
    // Enable mobile ambient animations by setting a variable
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
    }
    // **** Animation Conditions **** //
    // * These are extra conditions you can put on creatures with ambient
    // * animations.

    // * Civilized creatures interact with placeables in
    // * their area that have the tag "NW_INTERACTIVE"
    // * and "talk" to each other.
    // *
    // * Humanoid races are civilized by default, so only
    // * set this flag for monster races that you want to
    // * behave the same way.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_CIVILIZED);

    // * If this flag is set, this creature will constantly
    // * be acting. Otherwise, creatures will only start
    // * performing their ambient animations when they
    // * first perceive a player, and they will stop when
    // * the player moves away.
    // SetAnimationCondition(NW_ANIM_FLAG_CONSTANT);

    // * Civilized creatures with this flag set will
    // * randomly use a few voicechats. It's a good
    // * idea to avoid putting this on multiple
    // * creatures using the same voiceset.
    // SetAnimationCondition(NW_ANIM_FLAG_CHATTER);

    // * Creatures with _immobile_ ambient animations
    // * can have this flag set to make them mobile in a
    // * close range. They will never leave their immediate
    // * area, but will move around in it, frequently
    // * returning to their starting point.
    // *
    // * Note that creatures spawned inside interior areas
    // * that contain a waypoint with one of the tags
    // * "NW_HOME", "NW_TAVERN", "NW_SHOP" will automatically
    // * have this condition set.
    // SetAnimationCondition(NW_ANIM_FLAG_IS_MOBILE_CLOSE_RANGE);


    // **** Special Combat Tactics *****//
    // * These are special flags that can be set on creatures to
    // * make them follow certain specialized combat tactics.
    // * NOTE: ONLY ONE OF THESE SHOULD BE SET ON A SINGLE CREATURE.

    // * Ranged attacker
    // * Will attempt to stay at ranged distance from their
    // * target.
    // SetCombatCondition(X0_COMBAT_FLAG_RANGED);

    // * Defensive attacker
    // * Will use defensive combat feats and parry
    // SetCombatCondition(X0_COMBAT_FLAG_DEFENSIVE);

    // * Ambusher
    // * Will go stealthy/invisible and attack, then
    // * run away and try to go stealthy again before
    // * attacking anew.
    // SetCombatCondition(X0_COMBAT_FLAG_AMBUSHER);

    // * Cowardly
    // * Cowardly creatures will attempt to flee
    // * attackers.
    // SetCombatCondition(X0_COMBAT_FLAG_COWARDLY);


    // **** Escape Commands ***** //
    // * NOTE: ONLY ONE OF THE FOLLOWING SHOULD EVER BE SET AT ONE TIME.
    // * NOTE2: Not clear that these actually work. -- NN

    // * Flee to a way point and return a short time later.
    // *
    // SetSpawnInCondition(NW_FLAG_ESCAPE_RETURN);

    // * Flee to a way point and do not return.
    // *
    // SetSpawnInCondition(NW_FLAG_ESCAPE_LEAVE);

    // * Teleport to safety and do not return.
    // *
    // SetSpawnInCondition(NW_FLAG_TELEPORT_LEAVE);

    // * Teleport to safety and return a short time later.
    // *
    // SetSpawnInCondition(NW_FLAG_TELEPORT_RETURN);



    // ***** CUSTOM USER DEFINED EVENTS ***** /


    /*
      If you uncomment any of these conditions, the creature will fire
      a specific user-defined event number on each event. That will then
      allow you to write custom code in the "OnUserDefinedEvent" handler
      script to go on top of the default NPC behaviors for that event.

      Example: I want to add some custom behavior to my NPC when they
      are damaged. I uncomment the "NW_FLAG_DAMAGED_EVENT", then create
      a new user-defined script that has something like this in it:

      if (GetUserDefinedEventNumber() == 1006) {
          // Custom code for my NPC to execute when it's damaged
      }

      These user-defined events are in the range 1001-1007.
    */

    // * Fire User Defined Event 1001 in the OnHeartbeat
    // *
    // SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);

    // * Fire User Defined Event 1002
    // *
    // SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);

    // * Fire User Defined Event 1005
    // *
    //SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);

    // * Fire User Defined Event 1006
    // *
    //SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);

    // * Fire User Defined Event 1008
    // *
    // SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);

    // * Fire User Defined Event 1003
    // *
    //SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);

    // * Fire User Defined Event 1004
    // *
    // SetSpawnInCondition(NW_FLAG_ON_DIALOGUE_EVENT);



    // ***** DEFAULT GENERIC BEHAVIOR (DO NOT TOUCH) ***** //

    // * Goes through and sets up which shouts the NPC will listen to.
    // *
    SetListeningPatterns();

    // * Walk among a set of waypoints.
    // * 1. Find waypoints with the tag "WP_" + NPC TAG + "_##" and walk
    // *    among them in order.
    // * 2. If the tag of the Way Point is "POST_" + NPC TAG, stay there
    // *    and return to it after combat.
    //
    // * Optional Parameters:
    // * void WalkWayPoints(int nRun = FALSE, float fPause = 1.0)
    //
    // * If "NW_FLAG_DAY_NIGHT_POSTING" is set above, you can also
    // * create waypoints with the tags "WN_" + NPC Tag + "_##"
    // * and those will be walked at night. (The standard waypoints
    // * will be walked during the day.)
    // * The night "posting" waypoint tag is simply "NIGHT_" + NPC tag.
    WalkWayPoints();

    //* Create a small amount of treasure on the creature
    if ((GetLocalInt(GetModule(), "X2_L_NOTREASURE") == FALSE)  &&
        (GetLocalInt(OBJECT_SELF, "X2_L_NOTREASURE") == FALSE)   )
    {
        CTG_GenerateNPCTreasure(TREASURE_TYPE_MONSTER, OBJECT_SELF);
    }


    // ***** ADD ANY SPECIAL ON-SPAWN CODE HERE ***** //

    // * If Incorporeal, apply changes
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_IS_INCORPOREAL) == TRUE)
    {
        effect eConceal = EffectConcealment(50, MISS_CHANCE_TYPE_NORMAL);
        effect eGhost = EffectCutsceneGhost();
        effect eKDImmunity = EffectImmunity(IMMUNITY_TYPE_KNOCKDOWN);
        effect eImmunity = EffectImmunity(IMMUNITY_TYPE_ENTANGLE);//Shadooow: logically also immune to trap, but thats too much hardcore I guess
        effect eLink = EffectLinkEffects(eConceal,eGhost);
        eLink = EffectLinkEffects(eLink,eKDImmunity);
        eLink = EffectLinkEffects(eLink,eImmunity);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, SupernaturalEffect(eLink), OBJECT_SELF);
    }

    // * Give the create a random name.
    // * If you create a script named x3_name_gen in your module, you can
    // * set the value of the variable X3_S_RANDOM_NAME on OBJECT_SELF inside
    // * the script to override the creature's default name.
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_RANDOMIZE_NAME) == TRUE)
    {
        ExecuteScript("x3_name_gen",OBJECT_SELF);
        string sName = GetLocalString(OBJECT_SELF,"X3_S_RANDOM_NAME");
        if ( sName == "" )
        {
            sName = RandomName();
        }
        SetName(OBJECT_SELF,sName);
    }

    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
    iChestLevel = GetHitDice(OBJECT_SELF);
    if(!GetIsObjectValid(oSkin))
    {
        oSkin = CreateItemOnObject("mmp_baseskin");
        AssignCommand(OBJECT_SELF,SKIN_SupportEquipSkin(oSkin));
    }
    struct sItemInfo ItemInfo;
    struct sEnchantments Enchants;
    oObject = OBJECT_SELF;
    ItemInfo.oItem = oSkin;
    EnchantArmor(ItemInfo);
    int n = d6();
    int i;

    if(d6()==1)
    {
        object oRing = MMP_GenerateRing();
        AssignCommand(OBJECT_SELF,ActionEquipItem(oRing,INVENTORY_SLOT_RIGHTRING));
        SetDroppableFlag(oRing,TRUE);
    }
    if(d6()==1)
    {
        object oRing = MMP_GenerateRing();
        AssignCommand(OBJECT_SELF,ActionEquipItem(oRing,INVENTORY_SLOT_LEFTRING));
        SetDroppableFlag(oRing,TRUE);
    }
    if(d6()==1)
    {
        object oAmulet = MMP_GenerateAmulet();
        AssignCommand(OBJECT_SELF,ActionEquipItem(oAmulet,INVENTORY_SLOT_NECK));
        SetDroppableFlag(oAmulet,TRUE);
    }

    for(i = 0; i < n; i++)
    {
        object oitem = MMP_GenerateWand();
        SetDroppableFlag(oitem,FALSE);
    }
    if(d6() == 1)
    {
        object oitem = MMP_GenerateStaff();
        SetDroppableFlag(oitem,FALSE);
    }
    if(d6() == 1)
    {
        object oitem = MMP_GenerateRod();
        SetDroppableFlag(oitem,FALSE);
    }

    for(i = 0; i < d8(); i++) CreateStdPotion();
    for(i = 0; i < d6(); i++) CreateStdScroll();

    SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);
    SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);
    SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);
    SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);

   // for(i = 0; i < 3+d4(); i++) CreateObject(OBJECT_TYPE_CREATURE,"nw_goblina",GetLocation(OBJECT_SELF));
}
