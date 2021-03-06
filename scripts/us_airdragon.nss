// Wizard mutator

#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "x2_inc_switches"
#include "lutes"
#include "x3_inc_skin"
#include "inc_mmp"
#include "inc_mmplutes"
#include "inc_mmpmrbd"
#include "inc_abtemplate"
#include "inc_oozetemplate"
#include "inc_mmpair"


void main()
{

    ExecuteScript("nw_c2_default9",OBJECT_SELF);
    if(GetLocalInt(GetModule(),"bUseAIScripts") == FALSE) return;

    //--------------------------------------------------------------------------
    // Enable stealth mode by setting a variable on the creature
    // Great for ambushes
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_STEALTH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_STEALTH);
    }

    //--------------------------------------------------------------------------
    // Make creature enter search mode after spawning by setting a variable
    // Great for guards, etc
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_SEARCH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_SEARCH);
    }

    //--------------------------------------------------------------------------
    // Enable immobile ambient animations by setting a variable
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT_IMMOBILE) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    }


    //--------------------------------------------------------------------------
    // Enable mobile ambient animations by setting a variable
    // See x2_inc_switches for more information about this
    //--------------------------------------------------------------------------
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
    }

    // * Goes through and sets up which shouts the NPC will listen to.
    // *
    SetListeningPatterns();
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
    int n = GetHitDice(OBJECT_SELF);
    int i;

    object oRing = MMP_GenerateRing();
    AssignCommand(OBJECT_SELF,ActionEquipItem(oRing,INVENTORY_SLOT_RIGHTRING));
    SetDroppableFlag(oRing,TRUE);
    oRing = MMP_GenerateRing();
    AssignCommand(OBJECT_SELF,ActionEquipItem(oRing,INVENTORY_SLOT_LEFTRING));
    SetDroppableFlag(oRing,TRUE);

    object oAmulet = MMP_GenerateAmulet();
    AssignCommand(OBJECT_SELF,ActionEquipItem(oAmulet,INVENTORY_SLOT_NECK));
    SetDroppableFlag(oAmulet,TRUE);

    for(i = 0; i < n; i++)
    {
        object oitem = MMP_GenerateWand();
        SetDroppableFlag(oitem,FALSE);
        oitem = MMP_GenerateStaff();
        SetDroppableFlag(oitem,FALSE);
        oitem = MMP_GenerateRod();
        SetDroppableFlag(oitem,FALSE);
    }


    for(i = 0; i < n; i++) CreateStdPotion();
    for(i = 0; i < n; i++) CreateStdScroll();


    for(i = 0; i < GetHitDice(OBJECT_SELF); i++) MMP_HalfAirTable(oSkin);

    SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);
    SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);
    SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);
    SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);
    MMPAIR_GustOfWind(oSkin);

    effect eEffect = EffectAbilityIncrease(ABILITY_STRENGTH,2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectAbilityIncrease(ABILITY_DEXTERITY,2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION,4);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectAbilityIncrease(ABILITY_INTELLIGENCE,2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectAbilityIncrease(ABILITY_CHARISMA,2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectAbilityIncrease(ABILITY_WISDOM,2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectTemporaryHitpoints(d12(4));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);


    int nHD = GetHitDice(OBJECT_SELF);
    effect eDR;
    eDR = EffectSpellResistanceIncrease(10+nHD);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDR,OBJECT_SELF);

    eDR = EffectDamageImmunityIncrease(DAMAGE_TYPE_COLD,100);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDR,OBJECT_SELF);
    eDR = EffectImmunity(IMMUNITY_TYPE_DISEASE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDR,OBJECT_SELF);
}


