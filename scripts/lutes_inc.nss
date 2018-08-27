
/*******************************************************************************
 *
 * Item Data
 *
 *
 ********************************************************************************/


struct sItemInfo
{
    string sBluePrint;
    string sName;
    object oItem;
    int    wType;

    int    bExotic;
    int    bDoubleSided;


};


/********************************************************************************
 *
 * Enchantment Data
 *
 *
 ********************************************************************************/

struct sEnchantments
{
    int iAlign;      // the alignment is what the weapon or item hates
    int iRace;
    int iSAlign;

    int iACBonus;
    int iArcaneSpellFailure;    // Decrease
    int iDamageImmunity;
    int iDamageImmunityType;
    int iDamageReduction;       // the enchanment needed to hit
    int iDamageReductionSoak;   // from 5 to 50 hitpoints reduced
    int iDamageResistance;
    int iDamageResistanceType;
    int iImprovedEvasion;

    int iAttackBonus;
    int iEnhance;
    int iDamageBonus;
    int iDamageBonusType;
    int iAbilityStr;
    int iAbilityInt;
    int iAbilityDex;
    int iAbilityCon;
    int iAbilityWis;
    int iAbilityCha;
    int iBonusSaveThrow;
    int iBonusSaveThrowType;
    int iBonusSaveF;
    int iBonusSaveR;
    int iBonusSaveW;
    int iExtraMeleeDamage;
    int iFreeAction;
    int iHolyAvenger;
    int iMassiveCritical;
    int iRegeneration;
    int iVampiricRegeneration;

    // it is possible for an item to give up to 4 feats but by default it only gives 1
    int iNumFeats;
    int iFeat1;
    int iFeat2;
    int iFeat3;
    int iFeat4;

    int iSkillPoints;
    int iSkill;

    int iBonusSpellSlot;
    int iBonusSpellClass;
    int iSpellResistance;

    int iOnHit;
    int iOnHitDC;
    int iOnHitCastSpell;
    int iOnHitCastSpellLevel;
    int iSpecial;

    // up to 10 spells
    int iNumCastSpells;
    // spell and use (single, 1 charge etc)
    int iCastSpell1;
    int iCastSpellUse1;
    int iCastSpell2;
    int iCastSpellUse2;
    int iCastSpell3;
    int iCastSpellUse3;
    int iCastSpell4;
    int iCastSpellUse4;
    int iCastSpell5;
    int iCastSpellUse5;
    int iCastSpell6;
    int iCastSpellUse6;
    int iCastSpell7;
    int iCastSpellUse7;
    int iCastSpell8;
    int iCastSpellUse8;
    int iCastSpell9;
    int iCastSpellUse9;
    int iCastSpell10;
    int iCastSpellUse10;


    int iValue;
    int iPoints;
    int iTotalCost;
    int iSpecific;

    object oItem;
    string sName;
};

// where most enchantments are added to the item.
void ApplyEnchantments(struct sEnchantments Enchants);

