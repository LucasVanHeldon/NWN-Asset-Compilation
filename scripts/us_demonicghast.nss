// Demonic Template
// By Weed Wizard

#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "x2_inc_switches"
#include "lutes"
#include "x3_inc_skin"
#include "inc_mmp"

void main()
{
    ExecuteScript("nw_c2_default9",OBJECT_SELF);
    if(GetLocalInt(GetModule(),"bUseAIScripts") == FALSE) return;

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
    SetBaseAttackBonus(3);
    SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);

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

    SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);
    SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);
    SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);
    SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);
    SetBaseAttackBonus(3);

    effect eEffect = EffectAbilityIncrease(ABILITY_STRENGTH,4);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectAbilityIncrease(ABILITY_DEXTERITY,4);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION,4);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectAbilityIncrease(ABILITY_INTELLIGENCE,4);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectAbilityIncrease(ABILITY_CHARISMA,2);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    eEffect = EffectTemporaryHitpoints(d12(4));
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

    int nHDc = GetHitDice(OBJECT_SELF)/5+1;
    effect eDR = EffectDamageReduction(5,nHDc);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDR,OBJECT_SELF);
    eDR = EffectDamageResistance(DAMAGE_TYPE_ACID,10);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDR,OBJECT_SELF);
    eDR = EffectDamageResistance(DAMAGE_TYPE_FIRE,10);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDR,OBJECT_SELF);
    eDR = EffectDamageResistance(DAMAGE_TYPE_ELECTRICAL,10);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDR,OBJECT_SELF);
    eDR = EffectDamageResistance(DAMAGE_TYPE_COLD,10);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDR,OBJECT_SELF);

    int nHD = GetHitDice(OBJECT_SELF);
    eDR = EffectSpellResistanceIncrease(10+nHD);
    ApplyEffectToObject(DURATION_TYPE_INSTANT,eDR,OBJECT_SELF);

    int i;
   for(i = 0; i < 2+d4(); i++)
        CreateObject(OBJECT_TYPE_CREATURE,"nw_ghast",GetLocation(OBJECT_SELF));

}
