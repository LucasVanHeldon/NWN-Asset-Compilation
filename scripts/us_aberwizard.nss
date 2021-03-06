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

    for(i = 0; i < GetHitDice(OBJECT_SELF); i++)
    {
        object oitem = MMP_GenerateWand();
        SetDroppableFlag(oitem,FALSE);
    }
    if(d6() < 3)
    {
        object oitem = MMP_GenerateStaff();
        SetDroppableFlag(oitem,FALSE);
    }
    if(d6() < 3)
    {
        object oitem = MMP_GenerateRod();
        SetDroppableFlag(oitem,FALSE);
    }

    for(i = 0; i < GetHitDice(OBJECT_SELF); i++) CreateStdPotion();
    for(i = 0; i < GetHitDice(OBJECT_SELF); i++) CreateStdScroll();

    for(i = 0; i < GetHitDice(OBJECT_SELF); i++)
    {
        MMP_AbberationTable(oSkin);
    }
    object oBite = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B);
    MMP_AbberationCW(oBite);
    object oClaw = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L);
    MMP_AbberationCW(oBite);

    SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY);
    SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);
    SetSpawnInCondition(NW_FLAG_SPELL_CAST_AT_EVENT);
    SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);

}

