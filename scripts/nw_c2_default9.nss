#include "x0_i0_anims"
#include "x0_i0_treasure"

#include "x2_inc_switches"
#include "lutes"
#include "x3_inc_skin"
#include "inc_ai"
#include "mmp_lutes"

#include "inc_mmpaberr"
#include "inc_mmpmrbd"
#include "inc_mmpooze"

int IsAberration(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_ABERRATION)
            return TRUE;
    }
    return FALSE;
}

int IsFighter(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_FIGHTER ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_PALADIN ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_RANGER ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_MONK ||
           // don't know, if should include this guy or not.
           GetClassByPosition(i,oTarget) == CLASS_TYPE_CLERIC)
            return TRUE;
    }
    return FALSE;
}

int IsRogue(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_ROGUE ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_BARD ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_ASSASSIN)
            return TRUE;
    }
    return FALSE;
}

int IsMagicUser(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_SORCERER ||
           GetClassByPosition(i,oTarget) == CLASS_TYPE_WIZARD)
            return TRUE;
    }
    return FALSE;
}

int IsCleric(object oTarget)
{
    int i=1;
    for(i = 1; i < 4; i++)
    {
        if(GetClassByPosition(i,oTarget) == CLASS_TYPE_CLERIC)
            return TRUE;
    }
    return FALSE;
}

void GiveXP(object oPC, int nXP)
{
    // Calculate new XP value
    nXP=GetXP(oPC)+nXP;

    SetXP(oPC, nXP);
}


int CalcEL(object oC)
{
    object oX = GetFirstPC();
    int total = 0;
    int cnt = 0;

    while(GetIsObjectValid(oX))
    {
        if(GetIsEnemy(oX,oC) || GetIsPC(oX))
        {
            total += GetCharacterLevel(oX);
            cnt++;
        }
        oX = GetNextPC();
    }
    //SendMessageToPC(GetFirstPC(),"total="+IntToString(total)+",cnt="+IntToString(cnt));
    if(cnt == 0) return 0;
    return total/cnt;
}

void LevelUp()
{
    // this doesn't really work
    int EL = CalcEL(OBJECT_SELF);
    int class1 = GetClassByPosition(0);
    int class2 = GetClassByPosition(1);
    int class3 = GetClassByPosition(2);

    while(GetCharacterLevel(OBJECT_SELF) < EL)
    {
        if(!LevelUpHenchman(OBJECT_SELF,class1,TRUE))
            if(!LevelUpHenchman(OBJECT_SELF,class2,TRUE))
                if(!LevelUpHenchman(OBJECT_SELF,class3,TRUE))
                {
                    SendMessageToPC(GetFirstPC(),GetName(OBJECT_SELF)+" failed to lvl up");
                    break;
                }
    }

}

object ModifyArmor(object oItem)
{
    int color1=Random(64);
    int color2=Random(64);
    int color3=Random(64);
    oItem=    IPDyeArmor(oItem,ITEM_APPR_ARMOR_COLOR_CLOTH1,color1);
    oItem=    IPDyeArmor(oItem,ITEM_APPR_ARMOR_COLOR_CLOTH2,color2);
    oItem=    IPDyeArmor(oItem,ITEM_APPR_ARMOR_COLOR_LEATHER1,color1);
    oItem=    IPDyeArmor(oItem,ITEM_APPR_ARMOR_COLOR_LEATHER2,color2);
    oItem=    IPDyeArmor(oItem,ITEM_APPR_ARMOR_COLOR_METAL1,color1);
    oItem=    IPDyeArmor(oItem,ITEM_APPR_ARMOR_COLOR_METAL2,color2);


    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_LBICEP,X2_IP_ARMORTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_LFOOT,X2_IP_ARMORTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_LFOREARM,X2_IP_ARMORTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_LHAND,X2_IP_ARMORTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_LSHIN,X2_IP_ARMORTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_LSHOULDER,X2_IP_ARMORTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_LTHIGH,X2_IP_ARMORTYPE_RANDOM,TRUE);

    int nPart = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LTHIGH);
    object oOld = oItem;
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RTHIGH,nPart);
    DestroyObject(oOld);

    oOld = oItem;
    nPart = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LBICEP);
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RBICEP,nPart);
    DestroyObject(oOld);

    oOld = oItem;
    nPart = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LFOOT);
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RFOOT,nPart);
    DestroyObject(oOld);

    oOld = oItem;
    nPart = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LFOREARM);
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RFOREARM,nPart);
    DestroyObject(oOld);

    oOld = oItem;
    nPart = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LHAND);
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RHAND,nPart);
    DestroyObject(oOld);

    oOld = oItem;
    nPart = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LSHIN);
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RSHIN,nPart);
    DestroyObject(oOld);

    oOld = oItem;
    nPart = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LSHOULDER);
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RSHOULDER,nPart);
    DestroyObject(oOld);

    oOld = oItem;
    nPart = GetItemAppearance(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_LTHIGH);
    oItem= CopyItemAndModify(oItem, ITEM_APPR_TYPE_ARMOR_MODEL ,ITEM_APPR_ARMOR_MODEL_RTHIGH,nPart);
    DestroyObject(oOld);


    //oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_TORSO,X2_IP_ARMORTYPE_RANDOM,TRUE);
    //oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_ROBE,X2_IP_ARMORTYPE_RANDOM,TRUE);

    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_BELT,X2_IP_ARMORTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_NECK,X2_IP_ARMORTYPE_RANDOM,TRUE);
    oItem=    IPGetModifiedArmor(oItem,ITEM_APPR_ARMOR_MODEL_PELVIS,X2_IP_ARMORTYPE_RANDOM,TRUE);

    return oItem;
}

void EnhanceSkin()
{
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR,OBJECT_SELF);
    iChestLevel = GetHitDice(OBJECT_SELF);
    if(!GetIsObjectValid(oSkin))
    {
        oSkin = CreateItemOnObject("mmp_baseskin");
        AssignCommand(OBJECT_SELF,SKIN_SupportEquipSkin(oSkin));
    }
    if(d6() < 4)
    {
        itemproperty ip = ItemPropertySkillBonus(255, d10());
        IPSafeAddItemProperty(oSkin,ip);
    }

    if(GetRacialType(OBJECT_SELF)== RACIAL_TYPE_UNDEAD || GetRacialType(OBJECT_SELF)== RACIAL_TYPE_OUTSIDER)
    {
        itemproperty ip;
        ip = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_BLUDGEONING,4);
        IPSafeAddItemProperty(oSkin,ip);
        ip = ItemPropertyDamageImmunity(IP_CONST_DAMAGETYPE_PIERCING,4);
        IPSafeAddItemProperty(oSkin,ip);
        int nRed = GetHitDice(OBJECT_SELF)/4;
        int soak = GetHitDice(OBJECT_SELF)/4+1;
        ip = ItemPropertyDamageReduction(nRed,soak);
        IPSafeAddItemProperty(oSkin,ip);
    }

    struct sItemInfo ItemInfo;
    struct sEnchantments Enchants;
    oObject = OBJECT_SELF;
    ItemInfo.oItem = oSkin;
    EnchantArmor(ItemInfo);
}

void EnhanceItems()
{
    int n = d6();
    int i;

    if(IsMagicUser(OBJECT_SELF) || IsCleric(OBJECT_SELF) || IsFighter(OBJECT_SELF) || IsRogue(OBJECT_SELF))
    {
        object oRing =MMP_GenerateRing();
        AssignCommand(OBJECT_SELF,ActionEquipItem(oRing,INVENTORY_SLOT_RIGHTRING));
        SetDroppableFlag(oRing,FALSE);
        oRing = MMP_GenerateRing();
        AssignCommand(OBJECT_SELF,ActionEquipItem(oRing,INVENTORY_SLOT_LEFTRING));
        SetDroppableFlag(oRing,FALSE);
        object oAmulet = MMP_GenerateAmulet();
        AssignCommand(OBJECT_SELF,ActionEquipItem(oAmulet,INVENTORY_SLOT_NECK));
        SetDroppableFlag(oAmulet,FALSE);
    }

    object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST);
    struct sItemInfo iteminfo;
    if(GetIsObjectValid(oArmor))
    {
        iteminfo.oItem = oArmor;
        iteminfo.sBluePrint = GetResRef(oArmor);
        EnchantArmor(iteminfo);
    }


    oArmor = GetItemInSlot(INVENTORY_SLOT_LEFTHAND);

    int iBase = GetBaseItemType(oArmor);
    if(GetIsObjectValid(oArmor) && (iBase == BASE_ITEM_SMALLSHIELD || iBase == BASE_ITEM_LARGESHIELD || iBase==BASE_ITEM_TOWERSHIELD))
    {
        iteminfo.oItem = oArmor;
        iteminfo.sBluePrint = GetResRef(oArmor);
        EnchantArmor(iteminfo);
    }
    object oWeapon = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND);

    if(GetIsObjectValid(oWeapon))
    {
        iteminfo.oItem = oWeapon;
        iteminfo.sBluePrint = GetResRef(oWeapon);
        if(!GetWeaponRanged(oWeapon))
            EnchantWeapon(iteminfo);
        else
            EnchantRangedWeapon(iteminfo);
    }

    oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_B);

    if(GetIsObjectValid(oWeapon))
    {
        iteminfo.oItem = oWeapon;
        iteminfo.sBluePrint = GetResRef(oWeapon);
        if(!GetWeaponRanged(oWeapon))
            EnchantWeapon(iteminfo);
        else
            EnchantRangedWeapon(iteminfo);
    }

    oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_L);

    if(GetIsObjectValid(oWeapon))
    {
        iteminfo.oItem = oWeapon;
        iteminfo.sBluePrint = GetResRef(oWeapon);
        if(!GetWeaponRanged(oWeapon))
            EnchantWeapon(iteminfo);
        else
            EnchantRangedWeapon(iteminfo);
    }


    oWeapon = GetItemInSlot(INVENTORY_SLOT_CWEAPON_R);

    if(GetIsObjectValid(oWeapon))
    {
        iteminfo.oItem = oWeapon;
        iteminfo.sBluePrint = GetResRef(oWeapon);
        if(!GetWeaponRanged(oWeapon))
            EnchantWeapon(iteminfo);
        else
            EnchantRangedWeapon(iteminfo);
    }

}

/// power,num
void TEMPLATE_Skin(object oSkin)
{
    int die = Die(58);
    int nEffect;

    switch(die)
    {
    case 1:
        MMPABB_Adhesive(oSkin);
        break;
    case 2:
        MMPABB_Slow(oSkin);
        break;
    case 3:
        MMPABB_Sleep(oSkin);
        break;
    case 4:
        MMPABB_Blindness(oSkin);
        break;
    case 5:
        MMPABB_Daze(oSkin);
        break;
    case 6:
        MMPABB_Fear(oSkin);
        break;
    case 7:
        MMPABB_Confusion(oSkin);
        break;
    case 8:
        MMPABB_Contagion(oSkin);
        break;
    case 9:
        MMPABB_HoldPerson(oSkin);
        break;
    case 10:
        MMPABB_HoldMonster(oSkin);
        break;
    case 11:
        MMPABB_CharmingGaze(oSkin,d6());
        break;
    case 12:
        MMPABB_MindBlast(oSkin,d6());
        break;
    case 13:
        MMPABB_MindFog(oSkin,d6());
        break;
    case 14:
        MMPABB_LesserMindBlank(oSkin,d6());
        break;
    case 15:
        MMPABB_AuraBlindness(oSkin,d6());
        break;
    case 16:
        MMPABB_AuraCold(oSkin,d6());
        break;
    case 17:
        MMPABB_AuraElectricity(oSkin,d6());
        break;
    case 18:
        MMPABB_AuraFear(oSkin,d6());
        break;
    case 19:
        MMPABB_AuraFire(oSkin,d6());
        break;
    case 20:
        MMPABB_AuraHorror(oSkin,d6());
        break;
    case 21:
        MMPABB_AuraMenace(oSkin,d6());
        break;
    case 22:
        MMPABB_AuraProtection(oSkin,d6());
        break;
    case 23:
        MMPABB_AuraStun(oSkin,d6());
        break;
    case 24:
        MMPABB_AuraUnearthlyVisage(oSkin,d6());
        break;
    case 25:
        MMPABB_BoltDrainCharisma(oSkin,d6());
        break;
    case 26:
        MMPABB_BoltDrainConstitution(oSkin,d6());
        break;
    case 27:
        MMPABB_BoltDrainStrength(oSkin,d6());
        break;
    case 28:
        MMPABB_BoltDrainIntelligence(oSkin,d6());
        break;
    case 29:
        MMPABB_BoltDrainWisdom(oSkin,d6());
        break;
    case 30:
        MMPABB_SonicCone(oSkin,d6());
        break;
    case 31:
        MMPABB_GazeParalysis(oSkin,d6());
        break;
    case 32:
        MMPABB_GazeCharm(oSkin,d6());
        break;
    case 33:
        MMPABB_GazeConfusion(oSkin,d6());
        break;
    case 34:
        MMPABB_GazeDaze(oSkin,d6());
        break;
    case 35:
        MMPABB_GazeParalysis(oSkin,d6());
        break;
    case 36:
        MMPABB_GazeDominate(oSkin,d6());
        break;
    case 37:
        MMPABB_RayOfEnfeeble(oSkin,d6());
        break;
    case 38:
        MMPABB_PulseDrainCHA(oSkin,d6());
        break;
    case 39:
        MMPABB_PulseDrainINT(oSkin,d6());
        break;
    case 40:
        MMPABB_PulseDrainWIS(oSkin,d6());
        break;
    case 41:
        MMPABB_PulseDrainCON(oSkin,d6());
        break;
    case 42:
        MMPABB_PulseDrainDEX(oSkin,d6());
        break;
    case 43:
        MMPABB_PulseDrainSTR(oSkin,d6());
        break;
    case 44:
        MMPF_HoldPerson(oSkin,d6());
        break;
    case 45:
        MMPF_HoldMonster(oSkin,d6());
        break;
    case 46:
        MMPF_CharmPerson(oSkin,d6());
        break;
    case 47:
        MMPF_CharmMonster(oSkin,d6());
        break;
    case 48:
        MMPF_DominatePerson(oSkin,d6());
        break;
    case 49:
        MMPF_DominateMonster(oSkin,d6());
        break;
    case 50:
        MMPF_Boom(oSkin,d6());
        break;
    case 51:
        MMPF_Scare(oSkin,d6());
        break;
    case 52:
        MMPF_Daze(oSkin,d6());
        break;
    case 53:
        MMPF_Insanity(oSkin,d6());
        break;
    case 54:
        MMPF_DeafeningClang(oSkin,d6());
        break;
    case 55:
        MMPF_Displacement(oSkin,d6());
        break;
    case 56:
        MMPF_GhoulTouch(oSkin,d6());
        break;
    case 57:
        MMPF_VampiricTouch(oSkin,d6());
        break;
    case 58:
        MMPMRBD_PulseDrainDEX(oSkin,d6());
        break;
    case 59:
        MMPMRBD_Contagion(oSkin);
        break;
    case 60:
        MMPMRBD_HoldPerson(oSkin);
        break;
    case 61:
        MMPMRBD_HoldMonster(oSkin);
        break;
    case 62:
        MMPMRBD_PulseDrainCHA(oSkin,d6());
        break;
    case 63:
        MMPMRBD_PulseDrainINT(oSkin,d6());
        break;
    case 64:
        MMPMRBD_PulseDrainWIS(oSkin,d6());
        break;
    case 65:
        MMPMRBD_PulseDrainCON(oSkin,d6());
        break;
    case 66:
        MMPMRBD_PulseLevelDrain(oSkin,d6());
        break;
    case 67:
        MMPMRBD_Darkness(oSkin);
        break;
    case 68:
        MMPMRBD_Bane(oSkin);
        break;
    case 69:
        MMPMRBD_BestowCurse(oSkin);
        break;
    case 70:
        MMPMRBD_DispelMagic(oSkin);
        break;
     case 71:
        MMPMRBD_Doom(oSkin);
        break;
    case 72:
        MMPMRBD_EnergyDrain(oSkin);
        break;
    case 73:
        MMPMRBD_EvilBlight(oSkin);
        break;
    case 74:
        MMPMRBD_GhoulTouch(oSkin);
        break;
    case 75:
        MMPMRBD_HorridWilting(oSkin);
        break;
    case 76:
        MMPMRBD_InfestationOfMaggots(oSkin);
        break;
    case 77:
        MMPMRBD_NegativeEnergyBurst(oSkin);
        break;
    case 78:
        MMPMRBD_PhantasmalKiller(oSkin);
        break;
    case 79:
        MMPMRBD_VampiricTouch(oSkin);
        break;
    case 80:
        MMPMRBD_PulseNegative(oSkin);
        break;
    case 81:
        MMPMRBD_PulseDrainSTR(oSkin,d6());
        break;
    case 82:
        MMPF_FeebleMind(oSkin);
        break;
    case 84:
        MMPABB_Slow(oSkin);
        break;
    case 85:
        MMPABB_Blindness(oSkin);
        break;
    case 86:
        MMPABB_Contagion(oSkin);
        break;
    case 87:
        MMPABB_HoldPerson(oSkin);
        break;
    case 88:
        MMPABB_HoldMonster(oSkin);
        break;
    case 89:
        MMPABB_MindBlast(oSkin,d6());
        break;
    case 90:
        MMPABB_MindFog(oSkin,d6());
        break;
    case 91:
        MMPABB_LesserMindBlank(oSkin,d6());
        break;
    case 92:
        MMPABB_BoltDrainCharisma(oSkin,d6());
        break;
    case 93:
        MMPABB_BoltDrainConstitution(oSkin,d6());
        break;
    case 94:
        MMPABB_BoltDrainStrength(oSkin,d6());
        break;
    case 95:
        MMPABB_BoltDrainIntelligence(oSkin,d6());
        break;
    case 96:
        MMPABB_BoltDrainWisdom(oSkin,d6());
        break;
    case 97:
        MMPOOZE_BoltAcid(oSkin,d6());
        break;
    case 98:
        MMPOOZE_BoltDeath(oSkin,d6());
        break;
    case 99:
        MMPOOZE_BoltDisease(oSkin,d6());
        break;
    case 100:
        MMPOOZE_BoltPoison(oSkin,d6());
        break;
    case 101:
        MMPABB_BoltDrainWisdom(oSkin,d6());
        break;
    case 102:
        MMPABB_SonicCone(oSkin,d6());
        break;
    case 103:
        MMPABB_RayOfEnfeeble(oSkin,d6());
        break;
    case 104:
        MMPABB_PulseDrainCHA(oSkin,d6());
        break;
    case 105:
        MMPABB_PulseDrainINT(oSkin,d6());
        break;
    case 106:
        MMPABB_PulseDrainWIS(oSkin,d6());
        break;
    case 107:
        MMPABB_PulseDrainCON(oSkin,d6());
        break;
    case 108:
        MMPABB_PulseDrainDEX(oSkin,d6());
        break;
    case 109:
        MMPABB_PulseDrainSTR(oSkin,d6());
        break;
    case 110:
        MMPOOZE_PulseDisease(oSkin,d6());
        break;
    case 111:
        MMPOOZE_PulseDeath(oSkin,d6());
        break;
    case 112:
        MMPOOZE_PulsePoison(oSkin,d6());
        break;
    case 113:
        MMPOOZE_EvardsBlackTentacles(oSkin);
        break;

    }
}

// All Spells/Levels
//  Cleric, Druid, Wizard, Bard, Paladin, Ranger
//  A;l Abilities
// Number of uses on skin (bHasPower,n)
void TemplateType()
{
    int nPoints= GetHitDice(OBJECT_SELF);
    object oSkin = GetItemInSlot(INVENTORY_SLOT_CARMOUR);
    int i;

    switch(d4())
    {
    // psychic
    case 1:
        nPoints = nPoints + GetAbilityModifier(ABILITY_INTELLIGENCE);
        nPoints = nPoints + GetAbilityModifier(ABILITY_WISDOM);
        nPoints = nPoints + GetAbilityModifier(ABILITY_CHARISMA);
        SetLocalInt(OBJECT_SELF,"nPoints",nPoints);
        break;
    // strange powerrs
    case 2:
        for(i = 0; i < GetHitDice(OBJECT_SELF)/3+1; i++) TEMPLATE_Skin(oSkin);
        break;
    // Morbid
    case 3:
        for(i = 0; i < GetHitDice(OBJECT_SELF)/3+1; i++) MMP_MorbidTemplate(oSkin);
        break;
    // Demonic powers manifest at will
    case 4:
        SetLocalInt(OBJECT_SELF,"nDemonic",1);
        break;
    }
}

void TemplateGenerator()
{
    effect eEffect;

    if(d6() == 1)
    {
        eEffect = EffectAbilityIncrease(ABILITY_STRENGTH,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectAbilityIncrease(ABILITY_DEXTERITY,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }

    if(d6() == 1)
    {
        eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }

    if(d6() == 1)
    {
        eEffect = EffectAbilityIncrease(ABILITY_INTELLIGENCE,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }

    if(d6() == 1)
    {
        eEffect = EffectAbilityIncrease(ABILITY_WISDOM,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }

    if(d6() == 1)
    {
        eEffect = EffectAbilityIncrease(ABILITY_CHARISMA,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }

    if(d6() == 1)
    {
        eEffect = EffectTemporaryHitpoints(d12(d3()));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectACIncrease(d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectAttackIncrease(d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectTemporaryHitpoints(d12(d4()));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectACIncrease(d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectAttackIncrease(d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectConcealment(Random(100));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        int n = 0;
        if(d6() == 1) n |= 1;
        if(d6() == 1) n |= 2;
        if(d6() == 1) n |= 4;
        if(d6() == 1) n |= 8;
        if(d6() == 1) n |= 16;
        if(d6() == 1) n |= 32;
        if(d6() == 1) n |= 64;
        if(d6() == 1) n |= 128;
        if(d6() == 1) n |= 256;
        if(d6() == 1) n |= 512;
        if(d6() == 1) n |= 1024;
        if(d6() == 1) n |= 2048;
        if(d6() == 1) n |= 4096;
        ;
        eEffect = EffectDamageImmunityIncrease(n,Random(100));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {

        int n = 0;
        if(d6() == 1) n |= 1;
        if(d6() == 1) n |= 2;
        if(d6() == 1) n |= 4;
        if(d6() == 1) n |= 8;
        if(d6() == 1) n |= 16;
        if(d6() == 1) n |= 32;
        if(d6() == 1) n |= 64;
        if(d6() == 1) n |= 128;
        if(d6() == 1) n |= 256;
        if(d6() == 1) n |= 512;
        if(d6() == 1) n |= 1024;
        if(d6() == 1) n |= 2048;
        if(d6() == 1) n |= 4096;

        eEffect = EffectDamageIncrease(d4(),n);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        int nAmt = Random(50);
        eEffect = EffectDamageReduction(nAmt, GetHitDice(OBJECT_SELF)/3+1,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        int nAmt = Random(50);
        eEffect = EffectDamageResistance(GetHitDice(OBJECT_SELF)/3+1,nAmt,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        int nAmt = Random(32);
        eEffect = EffectImmunity(nAmt);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectInvisibility(1);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectModifyAttacks(d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectMovementSpeedIncrease(Random(100));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        eEffect = EffectRegenerate(GetHitDice(OBJECT_SELF)/3+1,6.0);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        int nSave = Random(3);
        int nType = Random(19);
        eEffect = EffectSavingThrowIncrease(nSave,nType);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        int nSpell = Random(1000);
        eEffect = EffectSpellImmunity(nSpell);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {
        int nSR = Random(10);
        eEffect = EffectSpellResistanceIncrease(nSR);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {

        eEffect = EffectTrueSeeing();
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1 && GetRacialType(OBJECT_SELF)==RACIAL_TYPE_UNDEAD)
    {
        int nHD = GetHitDice(OBJECT_SELF);
        eEffect = EffectTurnResistanceIncrease(nHD);
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {

        eEffect = EffectUltravision();
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    if(d6() == 1)
    {

        eEffect = EffectSeeInvisible();
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);
    }
    SetLocalString(OBJECT_SELF,"X2_SPECIAL_COMBAT_AI_SCRIPT","x2_ai_template");

    TemplateType();
}


void Upgrade()
{
    int d = GetLocalInt(GetModule(),"diffulty");

    if(  d > 0 || GetLocalInt(OBJECT_SELF,"bForceLvlUp")==1)
        LevelUp();

    if( (d == 0 && d20()==1) || (d == 1 && d10() == 1) || (d==2 && d6()==1) )
        TemplateGenerator();

    if( (d == 0 && d20()==1) || (d==1 && d10()==1) || (d==2 && d6()==1) )
    {
        effect eEffect = EffectAbilityIncrease(ABILITY_STRENGTH,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

        eEffect = EffectAbilityIncrease(ABILITY_DEXTERITY,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

        eEffect = EffectAbilityIncrease(ABILITY_CONSTITUTION,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

        eEffect = EffectAbilityIncrease(ABILITY_INTELLIGENCE,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

        eEffect = EffectAbilityIncrease(ABILITY_WISDOM,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

        eEffect = EffectAbilityIncrease(ABILITY_CHARISMA,d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

        eEffect = EffectTemporaryHitpoints(d12(d3()));
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

        eEffect = EffectACIncrease(d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

        eEffect = EffectAttackIncrease(d4());
        ApplyEffectToObject(DURATION_TYPE_INSTANT,eEffect,OBJECT_SELF);

        if(GetStandardFactionReputation(STANDARD_FACTION_HOSTILE,OBJECT_SELF) > 75)
        {
            if(GetStringLeft(GetName(OBJECT_SELF),8) == "Champion")
                SetName(OBJECT_SELF,"Super " + GetName(OBJECT_SELF));
            else
                SetName(OBJECT_SELF,"Elite " + GetName(OBJECT_SELF));
        }



    }



    /*
    if(d6() == 1)
    {
        if(!IsMagicUser(OBJECT_SELF) )
        {
            int n = GetHitDice(OBJECT_SELF);
            if(n < 3) { SetLocalInt(OBJECT_SELF,"nTemplate",1); }
            else if(n < 7) { SetLocalInt(OBJECT_SELF,"nTemplate",2); }
            else if(n < 12) { SetLocalInt(OBJECT_SELF,"nTemplate",3); }
            else if(n < 15) { SetLocalInt(OBJECT_SELF,"nTemplate",4); }
            else { SetLocalInt(OBJECT_SELF,"nTemplate",5); }
        }

        else
        {
            int n = 6+Random(14);
            SetLocalInt(OBJECT_SELF,"nTemplate",n);
        }
    }
    */
}


void ForceArmor(object o, object oArmor)
{
    // if the object is doing something, have to try and force it to update iut
    if(!GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CHEST)))
    {
       AssignCommand(o,ClearAllActions(TRUE));
       AssignCommand(o,ActionEquipItem(oArmor,INVENTORY_SLOT_CHEST));
       DelayCommand(1.0,ForceArmor(o,oArmor));
    }
}

void main()
{

    object sack = OBJECT_SELF;

    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_SEARCH) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_SEARCH);
    }

    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT_IMMOBILE) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS);
    }

    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_USE_SPAWN_AMBIENT) == TRUE)
    {
        SetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS);
    }




    // * Fire User Defined Event 1001 in the OnHeartbeat
    // *
    // SetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT);

    // * Fire User Defined Event 1002
    // *
    // SetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT);

    // * Fire User Defined Event 1005
    // *
    // SetSpawnInCondition(NW_FLAG_ATTACK_EVENT);

    // * Fire User Defined Event 1006
    // *
    // SetSpawnInCondition(NW_FLAG_DAMAGED_EVENT);

    // * Fire User Defined Event 1008
    // *
    // SetSpawnInCondition(NW_FLAG_DISTURBED_EVENT);

    // * Fire User Defined Event 1003
    // *
    // SetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT);

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
        eConceal = ExtraordinaryEffect(eConceal);
        effect eGhost = EffectCutsceneGhost();
        eGhost = ExtraordinaryEffect(eGhost);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eConceal, OBJECT_SELF);
        ApplyEffectToObject(DURATION_TYPE_PERMANENT, eGhost, OBJECT_SELF);

    }

    // * Give the create a random name.
    // * If you create a script named x3_name_gen in your module, you can
    // * set the value of the variable X3_S_RANDOM_NAME on OBJECT_SELF inside
    // * the script to override the creature's default name.
    if (GetCreatureFlag(OBJECT_SELF, CREATURE_VAR_RANDOMIZE_NAME) == TRUE)
    {
        /*
        ExecuteScript("x3_name_gen",OBJECT_SELF);
        string sName = GetLocalString(OBJECT_SELF,"X3_S_RANDOM_NAME");
        if ( sName == "" )
        {
            sName = RandomName();
        }
        SetName(OBJECT_SELF,sName);
        */
        SetName(OBJECT_SELF,RandomName(NAME_FIRST_HUMAN_MALE));
    }




    if(  GetStandardFactionReputation(STANDARD_FACTION_HOSTILE) > 50 )
    {
        if(GetAbilityScore(OBJECT_SELF,ABILITY_INTELLIGENCE) > 5)
        {
            int class = GetClassByPosition(0,OBJECT_SELF);

            if(class == CLASS_TYPE_ASSASSIN) SetLocalInt(sack,"Assassin",TRUE);
            if(class == CLASS_TYPE_BARD) SetLocalInt(sack,"Bard",1);
            if(class == CLASS_TYPE_CLERIC) SetLocalInt(sack,"Cleric",1);
            if(class == CLASS_TYPE_FIGHTER)  SetLocalInt(sack,"Fighter",1);
            if(class == CLASS_TYPE_GIANT) SetLocalInt(sack,"Giant",1);
            if(class == CLASS_TYPE_ROGUE) SetLocalInt(sack,"Rogue",1);
            if(class == CLASS_TYPE_WIZARD) SetLocalInt(sack,"Wizard",1);
            if(class == CLASS_TYPE_DRUID) SetLocalInt(sack,"Druid",1);
            if(class == CLASS_TYPE_RANGER) SetLocalInt(sack,"Ranger",1);
            if(class == CLASS_TYPE_PALADIN) SetLocalInt(sack,"Paladin",1);
            if(class == CLASS_TYPE_OUTSIDER) SetLocalInt(sack,"Outsider",1);
            if(class == CLASS_TYPE_ABERRATION) SetLocalInt(sack,"Abberation",1);
            if(class == CLASS_TYPE_DRAGON) SetLocalInt(sack,"Dragon",1);
            if(class == CLASS_TYPE_UNDEAD) SetLocalInt(sack,"Undead",1);
            if(class == CLASS_TYPE_MAGICAL_BEAST) SetLocalInt(sack,"MagicalBeast",1);

            if(class != CLASS_TYPE_ANIMAL)
            {
                //SendMessageToPC(GetFirstPC(),"Lutes");
                Lutes(OBJECT_SELF);
            }
        }


        if(GetLocalInt(GetModule(),"difficulty") >= 0 || GetLocalInt(OBJECT_SELF,"bForceLvlUp")==1)
        {
            if(GetLocalInt(OBJECT_SELF,"bNeverLvlUp")==0)
            {
                EnhanceSkin();
                EnhanceItems();
                Upgrade();
            }
        }

        object oArmor = GetItemInSlot(INVENTORY_SLOT_CHEST);
        struct sItemInfo iteminfo;
        if(GetIsObjectValid(oArmor))
        {
            oArmor = ModifyArmor(oArmor);
            if(GetIsObjectValid(oArmor)) {
                ActionEquipItem(oArmor,INVENTORY_SLOT_CHEST);
                DelayCommand(0.1,ForceArmor(OBJECT_SELF,oArmor));
            }
        }
    }
}

