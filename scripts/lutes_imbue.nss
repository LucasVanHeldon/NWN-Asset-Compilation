/********************************************************************************
 *
 * Imbue Enchantments
 *
 ********************************************************************************/

int DetermineSpellLevel()
{
    int level = 1;
    if(iChestLevel < 3)  level = 1;
    if(iChestLevel < 5)  level = 2;
    if(iChestLevel < 7)  level = 3;
    if(iChestLevel < 9) level = 4;
    if(iChestLevel < 12) level = 5;
    if(iChestLevel < 14) level = 6;
    if(iChestLevel < 16) level = 7;
    if(iChestLevel < 18) level = 8;
    if(iChestLevel >= 20) level = 9;
    return level;
}

struct sEnchantments ImbueAttackBonus(struct sEnchantments Enchantments)
{
    int cost   = 1;
    int points = Enchantments.iPoints;

    if( cost <= points )
    {
        Enchantments.iAttackBonus +=1;
        Enchantments.iValue = cost;
    }
    return Enchantments;
}

struct sEnchantments ImbueAttackBonusVsRace(struct sEnchantments Enchantments)
{
    int cost   = 1;
    int points = Enchantments.iPoints;

    if( cost <= points )
    {
        Enchantments.iAttackBonus +=1;
        Enchantments.iValue = cost;
    }
    return Enchantments;
}

struct sEnchantments ImbueAttackBonusVsAlign(struct sEnchantments Enchantments)
{
    int cost   = 1;
    int points = Enchantments.iPoints;

    if( cost <= points )
    {
        Enchantments.iAttackBonus   +=1;
        Enchantments.iValue          =cost;
    }
    return Enchantments;
}

struct sEnchantments ImbueAttackBonusVsSAlign(struct sEnchantments Enchantments)
{
    int cost   = 1;
    int points = Enchantments.iPoints;

    if( cost <= points )
    {
        Enchantments.iAttackBonus    +=1;
        Enchantments.iValue = cost;
    }
    return Enchantments;
}


struct sEnchantments DoImbueAttackBonus(struct sEnchantments Enchantments)
{
    return ImbueAttackBonus(Enchantments);
}



struct sEnchantments ImbueEnhance(struct sEnchantments Enchantments)
{
    int cost   = 3;
    int points = Enchantments.iPoints;

    if( cost <= points )
    {
        Enchantments.iEnhance += 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;

}

struct sEnchantments ImbueEnhanceVsRace(struct sEnchantments Enchantments)
{
    int cost   =  3;
    int points = Enchantments.iPoints;

    if( cost <= points )
    {
        Enchantments.iEnhance += 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;

}

struct sEnchantments ImbueEnhanceVsAlign(struct sEnchantments Enchantments)
{
    int cost   =  3;
    int points = Enchantments.iPoints;

    if( cost <= points )
    {
        Enchantments.iEnhance += 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;

}

struct sEnchantments ImbueEnhanceVsSAlign(struct sEnchantments Enchantments)
{
    int cost   =  3;
    int points = Enchantments.iPoints;

    if( cost <= points )
    {
        Enchantments.iEnhance += 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;

}


struct sEnchantments DoImbueEnhanceBonus(struct sEnchantments Enchantments)
{
    return ImbueEnhance(Enchantments);
}

struct sEnchantments ImbueBonusFeat(struct sEnchantments Enchantments)
{
    // alertness    = 3
    // ambidexterity =3
    // armor=3
    int feat = Random(31);
    int n    = Enchantments.iNumFeats+1;
    int cost     = 4;
    if(cost <= Enchantments.iPoints)
    {
        if(n < 4)
        {
            switch(n)
            {
            case 1: Enchantments.iFeat1 = feat; break;
            case 2: Enchantments.iFeat2 = feat; break;
            case 3: Enchantments.iFeat3 = feat; break;
            case 4: Enchantments.iFeat4 = feat; break;
            }
            Enchantments.iNumFeats = n;
            Enchantments.iValue    = cost;
        }
    }
    return Enchantments;
}

struct sEnchantments ImbueBonusSkill(struct sEnchantments Enchantments)
{
    int skill     = Random(27);
    int cost      = 1;

    if(cost <= Enchantments.iPoints)
    {
        Enchantments.iSkill        = skill;
        Enchantments.iSkillPoints += 1;
        Enchantments.iValue        = cost;
    }
    return Enchantments;
}


int DamageVsGood()
{
    while(1)
    {
        int r = Random(8)+5;
        if( r != IP_CONST_DAMAGETYPE_DIVINE ) return r;
    }
    return Random(8)+5;
}

int DamageVsEvil()
{

    while(1)
    {
        int r = Random(8)+5;
        if( r != IP_CONST_DAMAGETYPE_NEGATIVE ) return r;
    }
    return Random(8)+5;
}

int Damage()
{
    while(1)
    {
        int r = Random(8)+5;
        if( r != IP_CONST_DAMAGETYPE_DIVINE ) return r;
    }
    return Random(8+5);
}

int DamageType(struct sEnchantments Enchantments)
{
    if(Enchantments.iDamageBonus != 0)
    {
        return Enchantments.iDamageBonusType;
    }

    if(Enchantments.iSpecific == T_HOLYMACE) return IP_CONST_DAMAGETYPE_DIVINE;
    else if(Enchantments.iSpecific == T_VAMPIRIC ||
            Enchantments.iSpecific == T_NEGATIVETOUCH) return IP_CONST_DAMAGETYPE_NEGATIVE;
    else if(Enchantments.iAlign == GOOD || Enchantments.iAlign == LAW) return DamageVsGood();
    else if(Enchantments.iAlign == EVIL || Enchantments.iAlign == CHAOS) return DamageVsEvil();
    return Damage();
}

struct sEnchantments ImbueDamageBonus(struct sEnchantments Enchantments)
{
    // the range is not linear and requires some kind of probability distribution
    // for now it increments by a small amount
    int cost       = 2;
    int points     = Enchantments.iPoints;
    int damage     = DamageType(Enchantments);


    if( Enchantments.iDamageBonus >= 5)
    {
        Enchantments.iDamageBonus = 5;
    }
    else if( cost <= points)
    {
        Enchantments.iDamageBonusType = damage;
        Enchantments.iDamageBonus       += 1;
        Enchantments.iValue             = cost;
    }
    return Enchantments;

}

struct sEnchantments ImbueDamageBonusVsRace(struct sEnchantments Enchantments)
{
    int cost   = 2;
    int points = Enchantments.iPoints;
    int damage = DamageType(Enchantments);


    if(Enchantments.iDamageBonus >= 5)
    {
        Enchantments.iDamageBonus = 5;
    }
    if( cost <= points )
    {
        Enchantments.iDamageBonusType     = damage;
        Enchantments.iDamageBonus        += 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;

}

struct sEnchantments ImbueDamageBonusVsAlign(struct sEnchantments Enchantments)
{
    int cost   = 2;
    int damage = DamageType(Enchantments);
    int points = Enchantments.iPoints;


    if(Enchantments.iDamageBonus >= 5)
    {
        Enchantments.iDamageBonus = 5;
    }
    else if( cost <= points )
    {
        Enchantments.iDamageBonusType     = damage;
        Enchantments.iDamageBonus        += 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;

}

struct sEnchantments ImbueDamageBonusVsSAlign(struct sEnchantments Enchantments)
{
    int cost        = 2;
    int points      = Enchantments.iPoints;
    int damage      = DamageType(Enchantments);

    if(Enchantments.iDamageBonus >= 5)
    {
        Enchantments.iDamageBonus = 5;
    }
    else if( cost <= points)
    {
        Enchantments.iDamageBonusType     = damage;
        Enchantments.iDamageBonus += 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;
}

struct sEnchantments DoImbueDamageBonus(struct sEnchantments Enchantments)
{
    return ImbueDamageBonus(Enchantments);
}


struct sEnchantments ImbueAbility(struct sEnchantments Enchantments)
{
    int cost   = 4;
    int points = Enchantments.iPoints;
    int die    = d6();

    if(iAbilityBias != NONE)
    {
        int BiasRoll = d6();
        if(BiasRoll < 5)
        {
            die = iAbilityBias;
        }
    }
    if( cost <= points )
    {

        switch(die)
        {
        case 1: Enchantments.iAbilityStr += 1; break;
        case 2: Enchantments.iAbilityInt += 1; break;
        case 3: Enchantments.iAbilityDex += 1; break;
        case 4: Enchantments.iAbilityCon += 1; break;
        case 5: Enchantments.iAbilityWis += 1; break;
        case 6: Enchantments.iAbilityCha += 1; break;
        }
        Enchantments.iValue = cost;
    }
    return Enchantments;
}


struct sEnchantments ImbueSaveBonus(struct sEnchantments Enchantments)
{
    int cost   = 3;
    int points = Enchantments.iPoints;

    if(Enchantments.iBonusSaveR >= 20) Enchantments.iBonusSaveR = 20;
    else if( Enchantments.iBonusSaveF >= 20) Enchantments.iBonusSaveF = 20;
    else if( Enchantments.iBonusSaveW >= 20) Enchantments.iBonusSaveW = 20;
    else if( cost <= points )
    {
        int die = d3();
        switch(die)
        {
        case 1: Enchantments.iBonusSaveR += 1; break;
        case 2: Enchantments.iBonusSaveF += 1; break;
        case 3: Enchantments.iBonusSaveW += 1; break;
        }
        Enchantments.iValue = cost;
    }
    return Enchantments;
}


struct sEnchantments ImbueSaveThrowBonus(struct sEnchantments Enchantments)
{
    int cost   = 3;
    int points = Enchantments.iPoints;

    if(Enchantments.iBonusSaveThrow >= 20)
    {
        Enchantments.iBonusSaveThrow = 20;
    }
    else if( cost <= points )
    {
        Enchantments.iBonusSaveThrow    += 1;
        Enchantments.iBonusSaveThrowType = Random(16);
        Enchantments.iValue = cost;
    }
    return Enchantments;
}


struct sEnchantments ImbueExtraMeleeDamage(struct sEnchantments Enchantments)
{
    if( Enchantments.iPoints > 4 && Enchantments.iDamageBonus > 0)
    {
        Enchantments.iExtraMeleeDamage = Damage();
        Enchantments.iValue = 4;
    }
    return Enchantments;
}


struct sEnchantments ImbueFreeAction(struct sEnchantments Enchantments)
{
    int cost   = 7;
    int points = Enchantments.iPoints;


    if( cost <= points && Enchantments.iFreeAction == 0)
    {
        Enchantments.iFreeAction = 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;
}


struct sEnchantments ImbueHolyAvenger(struct sEnchantments Enchantments)
{
    int cost   = 8;
    int points = Enchantments.iPoints;

    if( cost <= points && Enchantments.iHolyAvenger == 0)
    {
        Enchantments.iHolyAvenger = 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;
}



struct sEnchantments ImbueMassiveCritical(struct sEnchantments Enchantments)
{
    int cost   = 4;
    int points = Enchantments.iPoints;

    if(Enchantments.iMassiveCritical >= 20)
    {
        Enchantments.iMassiveCritical = 20;
    }
    else if( cost <= points )
    {
        Enchantments.iMassiveCritical += 1;
        Enchantments.iValue  = cost;
    }
    return Enchantments;
}



struct sEnchantments ImbueRegeneration(struct sEnchantments Enchantments)
{
    int cost   = 7;
    int points = Enchantments.iPoints;

    if( Enchantments.iRegeneration >= 20)
    {
               Enchantments.iRegeneration = 20;
    }
    else if( cost <= points)
    {
        Enchantments.iRegeneration += 1;
        Enchantments.iValue = cost;
    }
    return Enchantments;
}



struct sEnchantments ImbueVampiricRegeneration(struct sEnchantments Enchantments)
{
    int base   = d3();
    int cost   = 6;
    int points = Enchantments.iPoints;

    if(Enchantments.iAlign == EVIL)
    {
        if( Enchantments.iVampiricRegeneration >= 20)
        {
            Enchantments.iVampiricRegeneration = 20;
        }
        else if( cost <= points)
        {
            Enchantments.iVampiricRegeneration += base;
            Enchantments.iValue = cost;
        }
    }
    return Enchantments;
}



struct sEnchantments ImbueOnHit(struct sEnchantments Enchantments)
{
    int cost   = 10;
    int points = Enchantments.iPoints;

    if( cost <= points && Enchantments.iOnHitDC == 0)
    {
        Enchantments.iOnHit   = Random(10);
        Enchantments.iOnHitDC = Random(10);
        cost += Enchantments.iOnHitDC;
        Enchantments.iValue = cost;
    }
    return Enchantments;
}

struct sEnchantments ImbueOnHitCastSpell(struct sEnchantments Enchantments)
{
    int cost   = 10;
    int level  = d20();
    cost += level;
    int points = Enchantments.iPoints;

    if( cost <= points && Enchantments.iOnHitDC == 0)
    {
        Enchantments.iOnHitCastSpell   = Random(140);
        Enchantments.iOnHitCastSpellLevel = level;
        cost += Enchantments.iOnHitDC;
        Enchantments.iValue = cost;
    }
    return Enchantments;
}


struct sEnchantments ImbueBonusSpellSlot(struct sEnchantments Enchantments)
{
    int level = DetermineSpellLevel();
    int cost  = level;

    if( Enchantments.iBonusSpellSlot == 0 && cost <= Enchantments.iPoints)
    {
        Enchantments.iBonusSpellSlot  = level;
        Enchantments.iBonusSpellClass = SpellClass();
        Enchantments.iValue           = cost;
    }
    return Enchantments;
}

struct sEnchantments ImbueSpellResistance(struct sEnchantments Enchantments)
{
    int cost  = 5;

    if( Enchantments.iSpellResistance >= 12)
    {
        Enchantments.iSpellResistance = 12;
    }
    cost += Enchantments.iSpellResistance+1;
    if( cost <= Enchantments.iPoints)
    {
        Enchantments.iSpellResistance += 1;
        Enchantments.iValue            = cost;
    }
    return Enchantments;
}


struct sEnchantments ImbueACBonus(struct sEnchantments Enchantments)
{
    int cost = 3;
    if(cost <= Enchantments.iPoints)
    {
        Enchantments.iACBonus += 1;
        Enchantments.iValue    = 3;
    }
    return Enchantments;
}


struct sEnchantments ImbueDamageImmunity(struct sEnchantments Enchantments)
{
    int cost = 8;
    if( Enchantments.iDamageImmunity > 7)
    {
        Enchantments.iDamageImmunity = 7;
    }
    cost += Enchantments.iDamageImmunity+1;
    if(cost <= Enchantments.iPoints)
    {
        Enchantments.iDamageImmunity += 1;

        int dt = Random(8);
        int type;
        if(dt == 0) type = IP_CONST_DAMAGETYPE_ACID;
        else if(dt == 1) type = IP_CONST_DAMAGETYPE_BLUDGEONING;
        else if(dt == 2) type = IP_CONST_DAMAGETYPE_COLD;
        else if(dt == 3) type = IP_CONST_DAMAGETYPE_ELECTRICAL;
        else if(dt == 4) type = IP_CONST_DAMAGETYPE_FIRE;
        else if(dt == 5) type = IP_CONST_DAMAGETYPE_PIERCING;
        else if(dt == 6) type = IP_CONST_DAMAGETYPE_SLASHING;
        else if(dt == 7) type = IP_CONST_DAMAGETYPE_SONIC;

        Enchantments.iDamageImmunityType = type;
        Enchantments.iValue              = cost;
    }
    return Enchantments;
}

// this only places a +1 enhancement
struct sEnchantments ImbueDamageReduction(struct sEnchantments Enchantments)
{
    int cost  = 6;

    if(Enchantments.iDamageReduction == 0)


    if(Enchantments.iDamageReduction >= 10)
    {
        Enchantments.iDamageReduction = 10;
    }
    cost += Enchantments.iDamageReduction+1;

    if(cost <= Enchantments.iPoints)
    {
        if(Enchantments.iDamageReductionSoak >= 10)
        {
            Enchantments.iDamageReduction      += 1;
            Enchantments.iDamageReductionSoak  = 0;
        }
        Enchantments.iDamageReductionSoak += 1;
        Enchantments.iValue    = 1;
    }
    return Enchantments;
}

// this only places a +1 enhancement
struct sEnchantments ImbueDamageResistance(struct sEnchantments Enchantments)
{
    int cost = 6;

    if(Enchantments.iDamageResistance >= 10)
    {
        Enchantments.iDamageResistance = 10;
    }
    cost += Enchantments.iDamageResistance+1;

    if(cost <= Enchantments.iPoints)
    {
        int dt = Random(8);
        int type;
        if(dt == 0) type = IP_CONST_DAMAGETYPE_ACID;
        else if(dt == 1) type = IP_CONST_DAMAGETYPE_BLUDGEONING;
        else if(dt == 2) type = IP_CONST_DAMAGETYPE_COLD;
        else if(dt == 3) type = IP_CONST_DAMAGETYPE_ELECTRICAL;
        else if(dt == 4) type = IP_CONST_DAMAGETYPE_FIRE;
        else if(dt == 5) type = IP_CONST_DAMAGETYPE_PIERCING;
        else if(dt == 6) type = IP_CONST_DAMAGETYPE_SLASHING;
        else if(dt == 7) type = IP_CONST_DAMAGETYPE_SONIC;

        Enchantments.iDamageResistanceType  = dt;
        Enchantments.iDamageResistance     += 1;
        Enchantments.iValue    = 1;
    }
    return Enchantments;
}

struct sEnchantments ImbueImprovedEvasion(struct sEnchantments Enchantments)
{
    int cost = 7;
    if(cost <= Enchantments.iPoints && Enchantments.iImprovedEvasion == 0)
    {
        Enchantments.iImprovedEvasion = 1;
        Enchantments.iValue           = cost;
    }
    return Enchantments;
}

// it only allows for up to 10% off
struct sEnchantments ImbueArcaneSpellFailureDecrease(struct sEnchantments Enchantments)
{
    int cost = 7;
    if(cost <= Enchantments.iPoints && Enchantments.iArcaneSpellFailure != 8)
    {
        Enchantments.iArcaneSpellFailure  = 8;
        Enchantments.iValue               = 4;
    }
    return Enchantments;
}



void ApplyEnchantments(struct sEnchantments Enchants)
{
    object oItem = Enchants.oItem;

    //PrintEnchants(Enchants);

    if(Enchants.iAttackBonus > 0)
    {
        if(Enchants.iRace != -1)
        {
            itemproperty ipAdd = ItemPropertyAttackBonusVsRace(Enchants.iRace,Enchants.iAttackBonus);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        else if(Enchants.iAlign != ALL)
        {
            itemproperty ipAdd = ItemPropertyAttackBonusVsAlign(Enchants.iAlign,Enchants.iAttackBonus);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        /*
        itemproperty ipAdd = ItemPropertyAttackBonusVsSAlign(Enchants.iSAlign,Enchants.iAttackBonusVsSAlign);
        IPSafeAddItemProperty(oItem, ipAdd);
        */
        else
        {
            itemproperty ipAdd = ItemPropertyAttackBonus(Enchants.iAttackBonus);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
    }

    if(Enchants.iEnhance > 0)
    {
        if(Enchants.iRace != -1)
        {
            itemproperty ipAdd = ItemPropertyEnhancementBonusVsRace(Enchants.iRace,Enchants.iEnhance);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        /*
        else if(Enchants.iSAlign != -1)
        {
            itemproperty ipAdd = ItemPropertyEnhancementBonusVsSAlign(Enchants.iSAlign,Enchants.iEnhanceVsSAlign);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        */
        else if(Enchants.iAlign != ALL)
        {
            itemproperty ipAdd = ItemPropertyEnhancementBonusVsAlign(Enchants.iAlign,Enchants.iEnhance);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        else
        {
            itemproperty ipAdd = ItemPropertyEnhancementBonus(Enchants.iEnhance);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
    }

    if(Enchants.iDamageBonus > 0)
    {

        if(Enchants.iRace != -1)
        {
            itemproperty ipAdd = ItemPropertyDamageBonusVsRace(Enchants.iRace,Enchants.iDamageBonusType,Enchants.iDamageBonus);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        else if(Enchants.iAlign != ALL)
        {
            itemproperty ipAdd = ItemPropertyDamageBonusVsAlign(Enchants.iAlign,Enchants.iDamageBonusType,Enchants.iDamageBonus);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        /*
        itemproperty ipAdd = ItemPropertyDamageBonusVsSAlign(Enchants.iSAlign,Enchants.iDamageBonusType,Enchants.iDamageBonusVsSAlign);
        IPSafeAddItemProperty(oItem, ipAdd);
        */
        else
        {
            itemproperty ipAdd = ItemPropertyDamageBonus(Enchants.iDamageBonusType,Enchants.iDamageBonus);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
    }

    if(Enchants.iAbilityStr > 0)
    {
        itemproperty ipAdd = ItemPropertyAbilityBonus(IP_CONST_ABILITY_STR,Enchants.iAbilityStr);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iAbilityInt > 0)
    {
        itemproperty ipAdd = ItemPropertyAbilityBonus(IP_CONST_ABILITY_INT,Enchants.iAbilityInt);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iAbilityDex > 0)
    {
        itemproperty ipAdd = ItemPropertyAbilityBonus(IP_CONST_ABILITY_DEX,Enchants.iAbilityDex);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iAbilityCon > 0)
    {
        itemproperty ipAdd = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CON,Enchants.iAbilityCon);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iAbilityWis > 0)
    {
        itemproperty ipAdd = ItemPropertyAbilityBonus(IP_CONST_ABILITY_WIS,Enchants.iAbilityWis);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iAbilityCha > 0)
    {
        itemproperty ipAdd = ItemPropertyAbilityBonus(IP_CONST_ABILITY_CHA,Enchants.iAbilityCha);
        IPSafeAddItemProperty(oItem, ipAdd);
    }

        if(Enchants.iBonusSaveF)
        {
            itemproperty ipAdd = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_FORTITUDE, Enchants.iBonusSaveF);
            IPSafeAddItemProperty(oItem, ipAdd);
        }

    if(Enchants.iBonusSaveR)
        {
            itemproperty ipAdd = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_REFLEX, Enchants.iBonusSaveR);
            IPSafeAddItemProperty(oItem, ipAdd);
        }

    if(Enchants.iBonusSaveW)
        {
            itemproperty ipAdd = ItemPropertyBonusSavingThrow(IP_CONST_SAVEBASETYPE_WILL, Enchants.iBonusSaveW);
            IPSafeAddItemProperty(oItem, ipAdd);
        }

    if(Enchants.iBonusSaveThrow)
        {
            itemproperty ipAdd = ItemPropertyBonusSavingThrowVsX(Enchants.iBonusSaveThrowType, Enchants.iBonusSaveThrow);
            IPSafeAddItemProperty(oItem, ipAdd);
        }

    if(Enchants.iExtraMeleeDamage)
        {
            itemproperty ipAdd = ItemPropertyExtraMeleeDamageType(Enchants.iExtraMeleeDamage);
            IPSafeAddItemProperty(oItem, ipAdd);
        }

    if(Enchants.iFreeAction)
        {
            itemproperty ipAdd = ItemPropertyFreeAction();
            IPSafeAddItemProperty(oItem, ipAdd);
        }


    if(Enchants.iHolyAvenger)
        {
            itemproperty ipAdd = ItemPropertyHolyAvenger();
            IPSafeAddItemProperty(oItem, ipAdd);
        }

    if(Enchants.iMassiveCritical)
        {
            itemproperty ipAdd = ItemPropertyMassiveCritical(Enchants.iMassiveCritical);
            IPSafeAddItemProperty(oItem, ipAdd);
        }

    if(Enchants.iRegeneration)
        {
            itemproperty ipAdd = ItemPropertyRegeneration(Enchants.iRegeneration);
            IPSafeAddItemProperty(oItem, ipAdd);
        }

    if(Enchants.iVampiricRegeneration)
        {
            itemproperty ipAdd = ItemPropertyVampiricRegeneration(Enchants.iVampiricRegeneration);
            IPSafeAddItemProperty(oItem, ipAdd);
        }

    if(Enchants.iNumFeats > 0)
    {
        if(Enchants.iNumFeats >= 1)
        {
            itemproperty ipAdd = ItemPropertyBonusFeat(Enchants.iFeat1);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        if(Enchants.iNumFeats >= 2)
        {
            itemproperty ipAdd = ItemPropertyBonusFeat(Enchants.iFeat2);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        if(Enchants.iNumFeats >= 3)
        {
            itemproperty ipAdd = ItemPropertyBonusFeat(Enchants.iFeat3);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
        if(Enchants.iNumFeats >= 4)
        {
            itemproperty ipAdd = ItemPropertyBonusFeat(Enchants.iFeat4);
            IPSafeAddItemProperty(oItem, ipAdd);
        }
    }

    if(Enchants.iSkillPoints > 0)
    {
        itemproperty ipAdd = ItemPropertySkillBonus(Enchants.iSkill, Enchants.iSkillPoints);
        IPSafeAddItemProperty(oItem, ipAdd);
    }

    if(Enchants.iSpellResistance > 0)
    {
        itemproperty ipAdd = ItemPropertyBonusSpellResistance(Enchants.iSpellResistance);
        IPSafeAddItemProperty(oItem, ipAdd);
    }

    if(Enchants.iOnHitDC > 0)
    {
        itemproperty ipAdd = ItemPropertyOnHitProps(Enchants.iOnHit,Enchants.iOnHitDC,Enchants.iSpecial);
        IPSafeAddItemProperty(oItem, ipAdd);
    }

    if(Enchants.iOnHitCastSpellLevel > 0)
    {
        itemproperty ipAdd = ItemPropertyOnHitCastSpell(Enchants.iOnHitCastSpell,Enchants.iOnHitCastSpellLevel);
        IPSafeAddItemProperty(oItem, ipAdd);
    }



    if(Enchants.iACBonus > 0)
    {
        itemproperty ipAdd = ItemPropertyACBonus(Enchants.iACBonus);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iArcaneSpellFailure > 0)
    {
        itemproperty ipAdd = ItemPropertyArcaneSpellFailure(Enchants.iArcaneSpellFailure);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iDamageImmunity > 0)
    {
        itemproperty ipAdd = ItemPropertyDamageImmunity(Enchants.iDamageImmunityType,Enchants.iDamageImmunity);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iDamageReduction > 0)
    {
        itemproperty ipAdd = ItemPropertyDamageReduction(Enchants.iDamageReduction,Enchants.iDamageReductionSoak);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iDamageResistance > 0)
    {
        itemproperty ipAdd = ItemPropertyDamageResistance(Enchants.iDamageResistanceType,Enchants.iDamageResistance);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    if(Enchants.iImprovedEvasion > 0)
    {
        itemproperty ipAdd = ItemPropertyImprovedEvasion();
        IPSafeAddItemProperty(oItem, ipAdd);
    }


    if(Enchants.iTotalCost > 10)
    {
        int iItemVisual=ITEM_VISUAL_HOLY;
        if(Enchants.iAlign == EVIL) iItemVisual = ITEM_VISUAL_HOLY;
        else if(Enchants.iAlign == GOOD) iItemVisual = ITEM_VISUAL_EVIL;
        else if(Enchants.iDamageBonusType == IP_CONST_DAMAGETYPE_ACID)
            iItemVisual = ITEM_VISUAL_ACID;
        else if(Enchants.iDamageBonusType == IP_CONST_DAMAGETYPE_ELECTRICAL)
            iItemVisual = ITEM_VISUAL_ELECTRICAL;
        else if(Enchants.iDamageBonusType == IP_CONST_DAMAGETYPE_COLD)
            iItemVisual = ITEM_VISUAL_COLD;
        else if(Enchants.iDamageBonusType == IP_CONST_DAMAGETYPE_FIRE)
            iItemVisual = ITEM_VISUAL_FIRE;
        else if(Enchants.iDamageBonusType == IP_CONST_DAMAGETYPE_SONIC)
            iItemVisual = ITEM_VISUAL_SONIC;

        itemproperty ipAdd = ItemPropertyVisualEffect(iItemVisual);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
}


// 1 point per skill point
// imbues skill point directly to object
struct sEnchantments ImbueSkill(struct sEnchantments Enchants)
{
    int cost = 1;
    int skill = Random(27);

    if( cost <= Enchants.iPoints)
    {
        itemproperty ipAdd = ItemPropertySkillBonus(skill,1);
        IPSafeAddItemProperty(Enchants.oItem, ipAdd);
        Enchants.iValue = cost;
    }
    return Enchants;
}

// 3 points per feat, does not check (yet) if already applied or makes logical sense
struct sEnchantments ImbueFeat(struct sEnchantments Enchants)
{
    int cost = 3;
    int feat = Random(31);
    if(cost <= Enchants.iPoints)
    {
        // need to check if feat alread added
        itemproperty ipAdd = ItemPropertyBonusFeat(feat);
        IPSafeAddItemProperty(Enchants.oItem, ipAdd);
        Enchants.iValue = cost;
    }
    return Enchants;
}


int ImbueCastSpell1()
{
    int spell;
    int cost;

    switch( Die(8) )
    {
    case 1:
        spell=IP_CONST_CASTSPELL_ACID_SPLASH_1;
        break;
    case 2:
        spell=IP_CONST_CASTSPELL_DAZE_1;
        cost=1;
        break;

    case 3:
        spell=IP_CONST_CASTSPELL_ELECTRIC_JOLT_1;
        cost=1;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_VIRTUE_1;
        cost=1;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_FLARE_1;
        cost=1;
        break;

    case 6:
        spell=IP_CONST_CASTSPELL_INFLICT_MINOR_WOUNDS_1;
        cost=1;
        break;

    case 7:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_1;
        cost=1;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_RAY_OF_FROST_1;
        cost=1;
        break;
    }


    return spell;
}


int ImbueCastSpell2()
{
    int spell;
    int cost;
    switch(Die(18))
    {
    case 1:
        spell=IP_CONST_CASTSPELL_BLESS_2;
        break;
    case 2:
        spell=IP_CONST_CASTSPELL_BURNING_HANDS_2;
        cost=2;
        break;
    case 3:
        spell=IP_CONST_CASTSPELL_GREASE_2;
        cost=2;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_COLOR_SPRAY_2;
        cost=2;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_CHARM_PERSON_2;
        cost=2;
        break;

    case 6:
        spell=IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_2;
        cost=2;
        break;

    case 7:
        spell=IP_CONST_CASTSPELL_DOOM_2;
        cost=2;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_ENDURE_ELEMENTS_2;
        cost=2;
        break;

    case 9:
        spell=IP_CONST_CASTSPELL_ENTANGLE_2;
        cost=2;
        break;

    case 19:
        spell=IP_CONST_CASTSPELL_MAGE_ARMOR_2;
        cost=2;
        break;

    case 11:
        spell=IP_CONST_CASTSPELL_PROTECTION_FROM_ALIGNMENT_2;
        cost=2;
        break;

    case 12:
        spell=IP_CONST_CASTSPELL_RAY_OF_ENFEEBLEMENT_2;
        cost=2;
        break;

    case 13:
        spell=IP_CONST_CASTSPELL_RESISTANCE_2;
        cost=2;
        break;

    case 14:
        spell=IP_CONST_CASTSPELL_SANCTUARY_2;
        cost=2;
        break;
    case 15:
        spell=IP_CONST_CASTSPELL_SCARE_2;
        cost=2;
        break;
    case 16:
        spell=IP_CONST_CASTSPELL_SLEEP_2;
        cost=2;
        break;

    case 17:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_I_2;
        cost=2;
        break;

    case 18:
        spell=IP_CONST_CASTSPELL_REMOVE_FEAR_2;
        cost=2;
        break;
    }


    return spell;
}

int ImbueCastSpell3()
{
    int spell;
    int cost;
    switch(Die(37))
    {

    case 1:
        spell=IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
    case 2:
        spell=IP_CONST_CASTSPELL_BLINDNESS_DEAFNESS_3;
        cost=3;
        break;
    case 3:
        spell=IP_CONST_CASTSPELL_AID_3;
        cost=3;
        break;
    case 4:
        spell=IP_CONST_CASTSPELL_BARKSKIN_3;
        cost=3;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_BULLS_STRENGTH_3;
        cost=3;
        break;

   case 6:
        spell=IP_CONST_CASTSPELL_CATS_GRACE_3;
        cost=3;
        break;

    case 7:
        spell=IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_3;
        cost=3;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_CLARITY_3;
        cost=3;
        break;

    case 9:
        spell=IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_3;
        cost=3;
        break;

    case 10:
        spell=IP_CONST_CASTSPELL_DARKNESS_3;
        cost=3;
        break;
    case 11:
        spell=IP_CONST_CASTSPELL_DARKVISION_3;
        cost=3;
        break;


    case 12:
        spell=IP_CONST_CASTSPELL_ENDURANCE_3;
        cost=3;
        break;


    case 13:
        spell=IP_CONST_CASTSPELL_GHOSTLY_VISAGE_3;
        cost=3;
        break;

    case 14:
        spell=IP_CONST_CASTSPELL_GHOUL_TOUCH_3;
        cost=3;
        break;

    case 15:
        spell=IP_CONST_CASTSPELL_HOLD_ANIMAL_3;
        cost=3;
        break;

    case 16:
        spell=IP_CONST_CASTSPELL_HOLD_PERSON_3;
        cost=3;
        break;

    case 17:
        spell=IP_CONST_CASTSPELL_HOLD_ANIMAL_3;
        cost=3;
        break;


    case 18:
        spell=IP_CONST_CASTSPELL_IDENTIFY_3;
        cost=3;
        break;

    case 19:
        spell=IP_CONST_CASTSPELL_INVISIBILITY_3;
        cost=3;
        break;


    case 20:
        spell=IP_CONST_CASTSPELL_FIND_TRAPS_3;
        cost=3;
        break;


    case 21:
        spell=IP_CONST_CASTSPELL_FLAME_LASH_3;
        cost=3;
        break;

    case 22:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_II_3;
        cost=3;
        break;

    case 23:
        spell=IP_CONST_CASTSPELL_FOXS_CUNNING_3;
        cost=3;
        break;

    case 24:
        spell=IP_CONST_CASTSPELL_EAGLE_SPLEDOR_3;
        cost=3;
        break;

    case 25:
        spell=IP_CONST_CASTSPELL_KNOCK_3;
        cost=3;
        break;

    case 26:
        spell=IP_CONST_CASTSPELL_LESSER_RESTORATION_3;
        cost=3;
        break;


    case 27:
        spell=IP_CONST_CASTSPELL_MAGIC_MISSILE_3;
        cost=3;
        break;

    case 28:
        spell=IP_CONST_CASTSPELL_MELFS_ACID_ARROW_3;
        cost=3;
        break;

    case 29:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_3;
        cost=3;
        break;

    case 30:
        spell=IP_CONST_CASTSPELL_OWLS_WISDOM_3;
        cost=3;
        break;

    case 31:
        spell=IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_3;
        cost=3;
        break;

    case 32:
        spell=IP_CONST_CASTSPELL_REMOVE_PARALYSIS_3;
        cost=3;
        break;
    case 33:
        spell=IP_CONST_CASTSPELL_RESIST_ELEMENTS_3;
        cost=3;
        break;

    case 34:
        spell=IP_CONST_CASTSPELL_ROGUES_CUNNING_3;
        cost=3;
        break;
    case 35:
        spell=IP_CONST_CASTSPELL_SILENCE_3;
        cost=3;
        break;
    case 36:
        spell=IP_CONST_CASTSPELL_SEE_INVISIBILITY_3;
        cost=3;
        break;

    case 37:
        spell=IP_CONST_CASTSPELL_WEB_3;
        cost=3;
        break;
    }
    return spell;
}

int ImbueCastSpell5()
{
    int spell;

    int cost;
    switch(Die(60))
    {

    case 1:
        spell=IP_CONST_CASTSPELL_ENTROPIC_SHIELD_5;
        cost=5;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_EXPEDITIOUS_RETREAT_5;
        cost=5;
        break;

    case 3:
        spell=IP_CONST_CASTSPELL_FEAR_5;
        cost=5;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_FIREBALL_5;
        cost=5;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_FLAME_ARROW_5;
        cost=5;
        break;

    case 6:
        spell=IP_CONST_CASTSPELL_FLESH_TO_STONE_5;
        cost=5;
        break;

    case 7:
        spell=IP_CONST_CASTSPELL_HASTE_5;
        cost=5;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_INFLICT_LIGHT_WOUNDS_5;
        cost=5;
        break;

    case 9:
        spell=IP_CONST_CASTSPELL_INVISIBILITY_PURGE_5;
        cost=5;
        break;
    case 10:
        spell=IP_CONST_CASTSPELL_INVISIBILITY_SPHERE_5;
        cost=5;
        break;

    case 11:
        spell=IP_CONST_CASTSPELL_MAGIC_CIRCLE_AGAINST_ALIGNMENT_5;
        cost=5;
        break;
    case 12:
        spell=IP_CONST_CASTSPELL_POISON_5;
        cost=5;
        break;
     case 13:
        spell=IP_CONST_CASTSPELL_PROTECTION_FROM_ALIGNMENT_5;
        cost=5;
        break;

    case 14:
        spell=IP_CONST_CASTSPELL_LEGEND_LORE_5;
        cost=5;
        break;
    case 15:
        spell=IP_CONST_CASTSPELL_LESSER_DISPEL_5;
        cost=5;
        break;


    case 16:
        spell=IP_CONST_CASTSPELL_LESSER_DISPEL_3;
        cost=3;
        break;

    case 17:
        spell=IP_CONST_CASTSPELL_LIGHT_5;
        cost=5;
        break;
    case 18:
        spell=IP_CONST_CASTSPELL_LIGHTNING_BOLT_5;
        cost=5;
        break;

    case 19:
        spell=IP_CONST_CASTSPELL_MAGIC_FANG_5;
        cost=5;
        break;

    case 20:
        spell=IP_CONST_CASTSPELL_MAGIC_MISSILE_5;
        cost=5;
        break;

    case 21:
        spell=IP_CONST_CASTSPELL_BURNING_HANDS_5;
        cost=5;
        break;
    case 22:
        spell=IP_CONST_CASTSPELL_CALL_LIGHTNING_5;
        cost=5;
        break;

    case 23:
        spell=IP_CONST_CASTSPELL_CAMOFLAGE_5;
        cost=5;
        break;

    case 24:
        spell=IP_CONST_CASTSPELL_BANE_5;
        cost=5;
        break;

    case 25:
        spell=IP_CONST_CASTSPELL_AMPLIFY_5;
        cost=5;
        break;
    case 26:
        spell=IP_CONST_CASTSPELL_ANIMATE_DEAD_5;
        cost=5;
        break;
    case 27:
        spell=IP_CONST_CASTSPELL_BESTOW_CURSE_5;
        cost=5;
        break;
    case 28:
        spell=IP_CONST_CASTSPELL_CHARM_MONSTER_5;
        cost=5;
        break;

    case 29:
        spell=IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_5;
        cost=5;
        break;
    case 30:
        spell=IP_CONST_CASTSPELL_CONTAGION_5;
        cost=5;
        break;

    case 31:
        spell=IP_CONST_CASTSPELL_CURE_LIGHT_WOUNDS_5;
        cost=5;
        break;

    case 32:
        spell=IP_CONST_CASTSPELL_DISPEL_MAGIC_5;
        cost=5;
        break;

    case 33:
        spell=IP_CONST_CASTSPELL_DIVINE_FAVOR_5;
        cost=5;
        break;

    case 34:
        spell=IP_CONST_CASTSPELL_DIVINE_MIGHT_5;
        cost=5;
        break;

    case 35:
        spell=IP_CONST_CASTSPELL_DIVINE_SHIELD_5;
        cost=5;
        break;
    case 36:
        spell=IP_CONST_CASTSPELL_DOMINATE_ANIMAL_5;
        cost=5;
        break;

    case 37:
        spell=IP_CONST_CASTSPELL_PRAYER_5;
        cost=5;
        break;

    case 38:
        spell=IP_CONST_CASTSPELL_REMOVE_BLINDNESS_DEAFNESS_5;
        cost=5;
        break;
    case 39:
        spell=IP_CONST_CASTSPELL_REMOVE_CURSE_5;
        cost=5;
        break;
    case 40:
        spell=IP_CONST_CASTSPELL_REMOVE_DISEASE_5;
        cost=5;
        break;
    case 41:
        spell=IP_CONST_CASTSPELL_SEARING_LIGHT_5;
        cost=5;
        break;
    case 42:
        spell=IP_CONST_CASTSPELL_SHIELD_5;
        cost=5;
        break;
    case 43:
        spell=IP_CONST_CASTSPELL_SHIELD_OF_FAITH_5;
        cost=5;
        break;
    case 44:
        spell=IP_CONST_CASTSPELL_SLAY_LIVING_9;
        cost=9;
    case 45:
        spell=IP_CONST_CASTSPELL_SLEEP_5;
        cost=5;
        break;

    case 46:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_I_5;
        cost=5;
        break;

    case 47:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_III_5;
        cost=5;
        break;

    case 48:
        spell=IP_CONST_CASTSPELL_TRUE_STRIKE_5;
        cost=5;
        break;


    case 49:
        spell=IP_CONST_CASTSPELL_VAMPIRIC_TOUCH_5;
        cost=5;
        break;

    case 50:
        spell=IP_CONST_CASTSPELL_STINKING_CLOUD_5;
        cost=5;
        break;
    case 51:
        spell=IP_CONST_CASTSPELL_STONE_TO_FLESH_5;
        cost=5;
        break;


    case 52:
        spell=IP_CONST_CASTSPELL_SLOW_5;
        cost=5;
        break;

    case 53:
        spell=IP_CONST_CASTSPELL_RESISTANCE_5;
        cost=5;
        break;


    case 54:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_5;
        cost=5;
        break;

    case 55:
        spell=IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_5;
        cost=5;
        break;

    case 56:
        spell=IP_CONST_CASTSPELL_ENTANGLE_5;
        cost=5;
        break;

    case 57:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_5;
        cost=5;
        break;

    case 58:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_5;
        cost=5;
        break;
    case 59:
        spell=IP_CONST_CASTSPELL_NEUTRALIZE_POISON_5;
        cost=5;
        break;
    case 60:
        spell=IP_CONST_CASTSPELL_RESISTANCE_5;
        cost=5;
        break;
    }
    return spell;
}

int ImbueCastSpell6()
{
    int spell;
    int cost;
    switch(Die(3))
    {

    case 1:
        spell=IP_CONST_CASTSPELL_BARKSKIN_6;
        cost=6;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_6;
        cost=6;
        break;

    case 3:
        spell=IP_CONST_CASTSPELL_MELFS_ACID_ARROW_6;
        cost=6;
        break;

    }
    return spell;
}

int ImbueCastSpell7()
{
    int spell;

    int cost;
    switch(Die(28))
    {

    case 1:
        spell=IP_CONST_CASTSPELL_BLOOD_FRENZY_7;
        break;
    case 2:
        spell=IP_CONST_CASTSPELL_AURAOFGLORY_7;
        cost=7;
        break;

    case 3:
        spell=IP_CONST_CASTSPELL_BALAGARNSIRONHORN_7;
        cost=7;
        break;
    case 4:
        spell=IP_CONST_CASTSPELL_DEATH_WARD_7;
        cost=7;
        break;


    case 5:
        spell=IP_CONST_CASTSPELL_CONTINUAL_FLAME_7;
        cost=7;
        break;


    case 6:
        spell=IP_CONST_CASTSPELL_DISMISSAL_7;
        cost=7;
        break;


    case 7:
        spell=IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_7;
        cost=7;
        break;


     case 8:
        spell=IP_CONST_CASTSPELL_INFLICT_MODERATE_WOUNDS_7;
        cost=7;
        break;
    case 9:
        spell=IP_CONST_CASTSPELL_LESSER_SPELL_BREACH_7;
        cost=7;
        break;

    case 10:
        spell=IP_CONST_CASTSPELL_MINOR_GLOBE_OF_INVULNERABILITY_7;
        cost=7;
        break;

    case 11:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_7;
        cost=7;
        break;

    case 12:
        spell=IP_CONST_CASTSPELL_ONE_WITH_THE_LAND_7;
        cost=7;
        break;

    case 13:
        spell=IP_CONST_CASTSPELL_PHANTASMAL_KILLER_7;
        cost=7;
        break;

    case 14:
        spell=IP_CONST_CASTSPELL_POLYMORPH_SELF_7;
        cost=7;
        break;


    case 16:
        spell=IP_CONST_CASTSPELL_SHADOW_CONJURATION_7;
        cost=7;
        break;

    case 17:
        spell=IP_CONST_CASTSPELL_STONESKIN_7;
        cost=7;
        break;



    case 18:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_IV_7;
        cost=7;
        break;

    case 19:
        spell=IP_CONST_CASTSPELL_TASHAS_HIDEOUS_LAUGHTER_7;
        cost=7;
        break;

    case 20:
        spell=IP_CONST_CASTSPELL_ELEMENTAL_SHIELD_7;
        cost=7;
        break;

    case 21:
        spell=IP_CONST_CASTSPELL_ENERVATION_7;
        cost=7;
        break;

    case 22:
        spell=IP_CONST_CASTSPELL_FLAME_STRIKE_7;
        cost=7;
        break;

    case 23:
        spell=IP_CONST_CASTSPELL_FREEDOM_OF_MOVEMENT_7;
        cost=7;
        break;

    case 24:
        spell=IP_CONST_CASTSPELL_GREATER_DISPELLING_7;
        cost=7;
        break;

    case 25:
        spell=IP_CONST_CASTSPELL_HOLD_MONSTER_7;
        cost=7;
        break;

    case 26:
        spell=IP_CONST_CASTSPELL_IMPROVED_INVISIBILITY_7;
        cost=7;
        break;

    case 27:
        spell=IP_CONST_CASTSPELL_WAR_CRY_7;
        cost=7;
        break;

    case 28:
        spell=IP_CONST_CASTSPELL_HAMMER_OF_THE_GODS_7;
        cost=7;
        break;
    }


    return spell;
}

int ImbueCastSpell9()
{
    int spell;
    int cost;
    switch(Die(25))
    {
    case 1:
        spell=IP_CONST_CASTSPELL_QUILLFIRE_8;
        cost=8;
        break;



    case 2:
        spell=IP_CONST_CASTSPELL_AWAKEN_9;
        cost=9;
        break;

    case 3:
        spell=IP_CONST_CASTSPELL_GREATER_MAGIC_FANG_9;
        cost=9;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_HEALING_CIRCLE_9;
        cost=9;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_ETHEREAL_VISAGE_9;
        cost=9;
        break;

    case 6:
        spell=IP_CONST_CASTSPELL_FEEBLEMIND_9;
        cost=9;
        break;

    case 7:
        spell=IP_CONST_CASTSPELL_GHOSTLY_VISAGE_9;
        cost=9;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_GREATER_SHADOW_CONJURATION_9;
        cost=9;
        break;


    case 9:
        spell=IP_CONST_CASTSPELL_LESSER_MIND_BLANK_9;
        cost=9;
        break;
    case 10:
        spell=IP_CONST_CASTSPELL_LESSER_PLANAR_BINDING_9;
        cost=9;
        break;




    case 11:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_V_9;
        cost=9;
        break;
    case 12:
        spell=IP_CONST_CASTSPELL_TRUE_SEEING_9;
        cost=9;
        break;
    case 13:
        spell=IP_CONST_CASTSPELL_WALL_OF_FIRE_9;
        cost=9;
        break;




    case 14:
        spell=IP_CONST_CASTSPELL_SPELL_RESISTANCE_9;
        cost=9;
        break;

    case 15:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_9;
        cost=9;
        break;

    case 16:
        spell=IP_CONST_CASTSPELL_SPIKE_GROWTH_9;
        cost=9;
        break;


    case 17:
        spell=IP_CONST_CASTSPELL_WOUNDING_WHISPERS_9;
        cost=9;
        break;

    case 18:
        spell=IP_CONST_CASTSPELL_ICE_STORM_9;
        cost=9;
        break;

    case 19:
        spell=IP_CONST_CASTSPELL_INFLICT_SERIOUS_WOUNDS_9;
        cost=9;
        break;

    case 20:
        spell=IP_CONST_CASTSPELL_MIND_FOG_9;
        cost=9;
        break;

    case 21:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_RAY_9;
        cost=9;
        break;


    case 22:
        spell=IP_CONST_CASTSPELL_LESSER_SPELL_MANTLE_9;
        cost=9;
        break;

    case 23:
        spell=IP_CONST_CASTSPELL_LIGHT_1;
        cost=1;
        break;


    case 24:
        spell=IP_CONST_CASTSPELL_MAGIC_MISSILE_9;
        cost=9;
        break;


    case 25:
        spell=IP_CONST_CASTSPELL_MELFS_ACID_ARROW_9;
        cost=9;
        break;
    }

    return spell;
}

int ImbueCastSpell10()
{
    int spell;
    int cost;
    switch(Die(35))
    {

    case 1:
        spell=IP_CONST_CASTSPELL_LIGHTNING_BOLT_10;
        cost=10;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_BURST_10;
        cost=10;
        break;

    case 3:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_10;
        cost=10;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_OWLS_WISDOM_10;
        cost=10;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_PROTECTION_FROM_ELEMENTS_10;
        cost=10;
        break;

    case 6:
        spell=IP_CONST_CASTSPELL_RESIST_ELEMENTS_10;
        cost=10;
        break;

    case 7:
        spell=IP_CONST_CASTSPELL_ANIMATE_DEAD_10;
        cost=10;
        break;
    case 8:
        spell=IP_CONST_CASTSPELL_BULLS_STRENGTH_10;
        cost=10;
        break;
    case 9:
        spell=IP_CONST_CASTSPELL_CALL_LIGHTNING_10;
        cost=10;
        break;
    case 10:
        spell=IP_CONST_CASTSPELL_CATS_GRACE_10;
        cost=10;
        break;

    case 11:
        spell=IP_CONST_CASTSPELL_CHARM_MONSTER_10;
        cost=10;
        break;

    case 12:
        spell=IP_CONST_CASTSPELL_CHARM_PERSON_10;
        cost=10;
        break;

    case 13:
        spell=IP_CONST_CASTSPELL_CHARM_PERSON_OR_ANIMAL_10;
        cost=10;
        break;

    case 14:
        spell=IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_10;
        cost=10;
        break;

    case 15:
        spell=IP_CONST_CASTSPELL_CONFUSION_10;
        cost=10;
        break;

    case 16:
        spell=IP_CONST_CASTSPELL_CURE_MODERATE_WOUNDS_10;
        cost=10;
        break;

    case 17:
        spell=IP_CONST_CASTSPELL_CURE_SERIOUS_WOUNDS_10;
        cost=10;
        break;


    case 18:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_ACID_10;
        cost=10;
        break;
    case 19:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_COLD_10;
        cost=10;
        break;
    case 20:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_FEAR_10;
        cost=10;
        break;
    case 21:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_FIRE_10;
        cost=10;
        break;
    case 22:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_GAS_10;
        cost=10;
        break;
    case 23:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_LIGHTNING_10;
        cost=10;
        break;
    case 24:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_PARALYZE_10;
        cost=10;
        break;
    case 25:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_SLEEP_10;
        cost=10;
        break;
    case 26:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_SLOW_10;
        cost=10;
        break;
    case 27:
        spell=IP_CONST_CASTSPELL_DRAGON_BREATH_WEAKEN_10;
        cost=10;
        break;

    case 28:
        spell=IP_CONST_CASTSPELL_ENDURANCE_10;
        cost=10;
        break;
    case 29:
        spell=IP_CONST_CASTSPELL_DISPEL_MAGIC_10;
        cost=10;
        break;
    case 30:
        spell=IP_CONST_CASTSPELL_EAGLE_SPLEDOR_10;
        cost=10;
        break;

    case 31:
        spell=IP_CONST_CASTSPELL_FIREBALL_10;
        cost=10;
        break;


    case 32:
        spell=IP_CONST_CASTSPELL_FLAME_LASH_10;
        cost=10;
        break;

    case 33:
        spell=IP_CONST_CASTSPELL_FOXS_CUNNING_10;
        cost=10;
        break;

    case 34:
        spell=IP_CONST_CASTSPELL_GUST_OF_WIND_10;
        cost=10;
        break;

    case 35:
        spell=IP_CONST_CASTSPELL_HASTE_10;
        cost=10;
        break;

    }
    return spell;
}


int ImbueCastSpell11()
{
    int spell;
    int cost;
    switch(Die(19))
    {

    case 1:
        spell=IP_CONST_CASTSPELL_BLADE_BARRIER_11;
        cost=11;

        case 41:
        spell=IP_CONST_CASTSPELL_CHAIN_LIGHTNING_11;
        cost=11;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_11;
        cost=11;
        break;

    case 3:
        spell=IP_CONST_CASTSPELL_CREATE_UNDEAD_11;
        cost=11;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_ENERGY_BUFFER_11;
        cost=11;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_GLOBE_OF_INVULNERABILITY_11;
        cost=11;
        break;
    case 6:
        spell=IP_CONST_CASTSPELL_GREATER_OWLS_WISDOM_11;
        cost=11;
        break;
    case 7:
        spell=IP_CONST_CASTSPELL_GREATER_BULLS_STRENGTH_11;
        cost=11;
        break;
    case 8:
        spell=IP_CONST_CASTSPELL_GREATER_CATS_GRACE_11;
        cost=11;
        break;

    case 9:
        spell=IP_CONST_CASTSPELL_GREATER_EAGLES_SPLENDOR_11;
        cost=11;
        break;
    case 10:
        spell=IP_CONST_CASTSPELL_GREATER_ENDURANCE_11;
        cost=11;
        break;
    case 11:
        spell=IP_CONST_CASTSPELL_GREATER_FOXS_CUNNING_11;
        cost=11;
        break;

    case 12:
        spell=IP_CONST_CASTSPELL_GREATER_SPELL_BREACH_11;
        cost=11;
        break;
    case 13:
        spell=IP_CONST_CASTSPELL_GREATER_STONESKIN_11;
        cost=11;
        break;



    case 14:
        spell=IP_CONST_CASTSPELL_HEAL_11;
        cost=11;
        break;

    case 15:
        spell=IP_CONST_CASTSPELL_MASS_HASTE_11;
        cost=11;
        break;

    case 16:
        spell=IP_CONST_CASTSPELL_SHADES_11;
        cost=11;
        break;


    case 17:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_VI_11;
        cost=11;
        break;


    case 18:
        spell=IP_CONST_CASTSPELL_TENSERS_TRANSFORMATION_11;
        cost=11;
        break;

    case 19:
        spell=IP_CONST_CASTSPELL_HARM_11;
        cost=11;
        break;

    }

    return spell;
}

int ImbueCastSpell12()
{
    int spell;
    int cost;
    switch(Die(8))
    {

    case 1:
        spell=IP_CONST_CASTSPELL_BARKSKIN_12;
        cost=12;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_12;
        cost=12;
        break;
    case 3:
        spell=IP_CONST_CASTSPELL_DISMISSAL_12;
        cost=12;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_INFLICT_CRITICAL_WOUNDS_12;
        cost=12;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_ELEMENTAL_SHIELD_12;
        cost=12;
        break;
    case 6:
        spell=IP_CONST_CASTSPELL_FLAME_ARROW_12;
        cost=12;
        break;
    case 7:
        spell=IP_CONST_CASTSPELL_FLAME_STRIKE_12;
        cost=12;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_HAMMER_OF_THE_GODS_12;
        cost=10;
        break;

    }

    return spell;
}


int ImbueCastSpell13()
{
    int spell;
    int cost;
    switch(Die(22))
    {
    case 1:
        spell=IP_CONST_CASTSPELL_AURA_OF_VITALITY_13;
        cost=13;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_POWER_WORD_STUN_13;
        cost=13;
        break;

    case 3:
        spell=IP_CONST_CASTSPELL_PRISMATIC_SPRAY_13;
        cost=13;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_13;
        cost=13;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_WORD_OF_FAITH_13;
        cost=13;
        break;

    case 6:
        spell=IP_CONST_CASTSPELL_SUNBEAM_13;
        cost=13;
        break;


    case 7:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_VII_13;
        cost=5;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_SPELL_MANTLE_13;
        cost=13;
        break;

    case 9:
        spell=IP_CONST_CASTSPELL_SHADOW_SHIELD_13;
        cost=13;
        break;

    case 10:
        spell=IP_CONST_CASTSPELL_RESURRECTION_13;
        cost=13;
        break;

    case 11:
        spell=IP_CONST_CASTSPELL_REGENERATE_13;
        cost=13;
        break;

    case 12:
        spell=IP_CONST_CASTSPELL_MORDENKAINENS_SWORD_13;
        cost=13;
        break;


    case 13:
        spell=IP_CONST_CASTSPELL_MASS_CAMOFLAGE_13;
        cost=13;
        break;


    case 14:
        spell=IP_CONST_CASTSPELL_FINGER_OF_DEATH_13;
        cost=13;
        break;


    case 15:
        spell=IP_CONST_CASTSPELL_FIRE_STORM_13;
        cost=13;
        break;


    case 16:
        spell=IP_CONST_CASTSPELL_GREATER_RESTORATION_13;
        cost=13;
        break;

    case 17:
        spell=IP_CONST_CASTSPELL_ISAACS_LESSER_MISSILE_STORM_13;
        cost=13;
        break;


    case 18:
        spell=IP_CONST_CASTSPELL_CONTROL_UNDEAD_13;
        cost=13;
        break;
    case 19:
        spell=IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_13;
        cost=13;
        break;

    case 20:
        spell=IP_CONST_CASTSPELL_DESTRUCTION_13;
        cost=13;
        break;


    case 21:
        spell=IP_CONST_CASTSPELL_CREEPING_DOOM_13;
        cost=13;
        break;
    case 22:
        return IP_CONST_CASTSPELL_CREATE_UNDEAD_14;

    }
    return spell;
}








int ImbueCastSpell15()
{
    int spell;
    int cost;
    switch(Die(45))
    {

    case 1:
        spell=IP_CONST_CASTSPELL_BULLS_STRENGTH_15;
        cost=15;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_ANIMATE_DEAD_15;
        cost=15;
        break;
    case 3:
        spell=IP_CONST_CASTSPELL_AURA_VERSUS_ALIGNMENT_15;
        cost=15;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_BIGBYS_INTERPOSING_HAND_15;
        cost=15;
        break;
        break;
    case 5:
        spell=IP_CONST_CASTSPELL_BLADE_BARRIER_15;
        cost=15;
        break;
    case 6:
        spell=IP_CONST_CASTSPELL_BANISHMENT_15;
        cost=15;
        break;

    case 7:
        spell=IP_CONST_CASTSPELL_BIGBYS_FORCEFUL_HAND_15;
        cost=15;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_CATS_GRACE_15;
        cost=15;
        break;

    case 9:
        spell=IP_CONST_CASTSPELL_CHAIN_LIGHTNING_15;
        cost=15;
        break;

    case 10:
        spell=IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_15;
        cost=15;
        break;

    case 11:
        spell=IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_15;
        cost=15;
        break;

    case 12:
        spell=IP_CONST_CASTSPELL_CLAIRAUDIENCE_CLAIRVOYANCE_15;
        cost=15;
        break;

    case 13:
        spell=IP_CONST_CASTSPELL_CONE_OF_COLD_15;
        cost=15;
        break;

    case 14:
        spell=IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_15;
        cost=15;
        break;

    case 15:
        spell=IP_CONST_CASTSPELL_CURE_CRITICAL_WOUNDS_15;
        cost=15;
        break;

    case 16:
        spell=IP_CONST_CASTSPELL_SPELL_RESISTANCE_15;
        cost=15;
        break;



    case 17:
        spell=IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_15;
        cost=15;
        break;

    case 18:
        spell=IP_CONST_CASTSPELL_GHOSTLY_VISAGE_15;
        cost=15;
        break;

    case 19:
        spell=IP_CONST_CASTSPELL_FOXS_CUNNING_15;
        cost=15;
        break;
    case 20:
        spell=IP_CONST_CASTSPELL_FIREBRAND_15;
        cost=15;
        break;
    case 21:
        spell=IP_CONST_CASTSPELL_EVARDS_BLACK_TENTACLES_15;
        cost=15;
        break;
    case 22:
        spell=IP_CONST_CASTSPELL_ETHEREAL_VISAGE_15;
        cost=15;
        break;
    case 23:
        spell=IP_CONST_CASTSPELL_DROWN_15;
        cost=15;
        break;

    case 24:
        spell=IP_CONST_CASTSPELL_EAGLE_SPLEDOR_15;
        cost=15;
        break;

    case 25:
        spell=IP_CONST_CASTSPELL_ENERGY_BUFFER_15;
        cost=15;
        break;



    case 26:
        spell=IP_CONST_CASTSPELL_GREATER_DISPELLING_15;
        cost=15;
        break;


    case 27:
        spell=IP_CONST_CASTSPELL_HORRID_WILTING_15;
        cost=15;
        break;

    case 28:
        spell=IP_CONST_CASTSPELL_INCENDIARY_CLOUD_15;
        cost=15;
        break;

    case 29:
        spell=IP_CONST_CASTSPELL_INFERNO_15;
        cost=15;
        break;

    case 30:
        spell=IP_CONST_CASTSPELL_ISAACS_GREATER_MISSILE_STORM_15;
        cost=15;
        break;




    case 31:
        spell=IP_CONST_CASTSPELL_DIRGE_15;
        cost=15;
        break;

    case 32:
        spell=IP_CONST_CASTSPELL_ENDURANCE_15;
        cost=15;
        break;

    case 33:
        spell=IP_CONST_CASTSPELL_MASS_BLINDNESS_DEAFNESS_15;
        cost=15;
        break;


    case 34:
        spell=IP_CONST_CASTSPELL_MASS_CHARM_15;
        cost=15;
        break;

    case 35:
        spell=IP_CONST_CASTSPELL_MASS_HEAL_15;
        cost=15;
        break;

    case 36:
        spell=IP_CONST_CASTSPELL_MIND_BLANK_15;
        cost=15;
        break;

    case 37:
        spell=IP_CONST_CASTSPELL_PREMONITION_15;
        cost=15;
        break;


    case 38:
        spell=IP_CONST_CASTSPELL_MINOR_GLOBE_OF_INVULNERABILITY_15;
        cost=15;
        break;

    case 39:
        spell=IP_CONST_CASTSPELL_NEGATIVE_ENERGY_PROTECTION_15;
        cost=15;
        break;


    case 40:
        spell=IP_CONST_CASTSPELL_OWLS_INSIGHT_15;
        cost=15;
        break;

    case 41:
        spell=IP_CONST_CASTSPELL_OWLS_WISDOM_15;
        cost=15;
        break;

    case 42:
        spell=IP_CONST_CASTSPELL_PLANAR_ALLY_15;
        cost=15;
        break;

    case 43:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_VIII_15;
        cost=7;
        break;


    case 44:
        spell=IP_CONST_CASTSPELL_GREATER_PLANAR_BINDING_15;
        cost=11;
        break;




    case 45:
        spell=IP_CONST_CASTSPELL_SPELL_RESISTANCE_15;
        cost=15;
        break;

    }

    return spell;
}

int ImbueCastSpell16()
{
    int spell;

    int cost;
    switch(Die(14))
    {
    case 1:
        spell=IP_CONST_CASTSPELL_CREATE_UNDEAD_16;
        cost=16;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_16;
        cost=16;
        break;


    case 3:
        spell=IP_CONST_CASTSPELL_HEALING_CIRCLE_16;
        cost=16;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_HEALING_CIRCLE_16;
        cost=16;
        break;
    }

    return spell;
}

int ImbueCastSpell17()
{
    int spell;
    int cost;
    switch(Die(14))
    {
    case 1:
        spell=IP_CONST_CASTSPELL_SHAPECHANGE_17;
        cost=17;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_DOMINATE_MONSTER_17;
        cost=17;
        break;
    case 3:
        spell=IP_CONST_CASTSPELL_DOMINATE_MONSTER_17;
        cost=17;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_ENERGY_DRAIN_17;
        cost=17;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_GREATER_SPELL_MANTLE_17;
        cost=17;
        break;


    case 6:
        spell=IP_CONST_CASTSPELL_MORDENKAINENS_DISJUNCTION_17;
        cost=17;
        break;



    case 7:
        spell=IP_CONST_CASTSPELL_POWER_WORD_KILL_17;
        cost=17;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_STORM_OF_VENGEANCE_17;
        cost=17;
        break;
    case 9:
        spell=IP_CONST_CASTSPELL_SUMMON_CREATURE_IX_17;
        cost=17;
        break;

    case 10:
        spell=IP_CONST_CASTSPELL_TIME_STOP_17;
        cost=17;
        break;

    case 11:
        spell=IP_CONST_CASTSPELL_WAIL_OF_THE_BANSHEE_17;
        cost=17;
        break;


    case 12:
        spell=IP_CONST_CASTSPELL_BIGBYS_GRASPING_HAND_17;
        cost=17;
        break;

    case 13:
        spell=IP_CONST_CASTSPELL_WEIRD_17;
        cost=17;
        break;

    case 14:
        spell=IP_CONST_CASTSPELL_METEOR_SWARM_17;
        cost=17;
        break;

    case 15:
        spell=IP_CONST_CASTSPELL_GATE_17;
        cost=17;
        break;


    case 16:
        spell=IP_CONST_CASTSPELL_ELEMENTAL_SWARM_17;
        cost=17;
        break;
    case 17:
        spell=IP_CONST_CASTSPELL_IMPLOSION_17;
        cost=17;
        break;

    }
    return spell;
}



int ImbueCastSpell18()
{
    int spell;

    int cost;
    switch(Die(7))
    {
    case 1:
        spell=IP_CONST_CASTSPELL_CREATE_GREATER_UNDEAD_18;
        cost=18;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_FLAME_ARROW_18;
        cost=18;
        break;

    case 3:
        spell=IP_CONST_CASTSPELL_FLAME_STRIKE_18;
        cost=18;
        break;

    case 4:
        spell=IP_CONST_CASTSPELL_DISMISSAL_18;
        cost=18;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_ETHEREALNESS_18;
        cost=18;
        break;

    case 6:
        spell=IP_CONST_CASTSPELL_FIRE_STORM_18;
        cost=18;
        break;
    case 7:
        spell=IP_CONST_CASTSPELL_MORDENKAINENS_SWORD_18;
        cost=18;
        break;

    }
    return spell;


}

int ImbueCastSpell20()
{
    int spell;
    int cost;
    switch(Die(14))
    {
    case 1:
        spell=IP_CONST_CASTSPELL_BOMBARDMENT_20;
        cost=20;
        break;

    case 2:
        spell=IP_CONST_CASTSPELL_BIGBYS_CLENCHED_FIST_20;
        cost=20;
        break;
    case 3:
        spell=IP_CONST_CASTSPELL_BIGBYS_CRUSHING_HAND_20;
        cost=20;
        break;

   case 4:
        spell=IP_CONST_CASTSPELL_CONTROL_UNDEAD_20;
        cost=20;
        break;

    case 5:
        spell=IP_CONST_CASTSPELL_CHAIN_LIGHTNING_20;
        cost=20;
        break;

    case 6:
        spell=IP_CONST_CASTSPELL_CIRCLE_OF_DEATH_20;
        cost=20;
        break;

    case 7:
        spell=IP_CONST_CASTSPELL_CIRCLE_OF_DOOM_20;
        cost=20;
        break;

    case 8:
        spell=IP_CONST_CASTSPELL_DELAYED_BLAST_FIREBALL_20;
        cost=20;
        break;

    case 9:
        spell=IP_CONST_CASTSPELL_ENERGY_BUFFER_20;
        cost=20;
        break;

    case 10:
        spell=IP_CONST_CASTSPELL_PROTECTION_FROM_SPELLS_20;
        cost=20;
        break;

    case 11:
        spell=IP_CONST_CASTSPELL_SUNBURST_20;
        cost=20;
        break;

    case 12:
        spell=IP_CONST_CASTSPELL_UNDEATHS_ETERNAL_FOE_20;
        cost=20;
        break;

    case 13:
        spell=IP_CONST_CASTSPELL_EARTHQUAKE_20;
        cost=20;
        break;

    case 14:
        spell=IP_CONST_CASTSPELL_HORRID_WILTING_20;
        cost=20;
        break;
    }
    return spell;
}


// the cost is 1 point per level of spell
// this can be adjusted below
struct sEnchantments ImbueCastSpell(struct sEnchantments Enchants, int nUse=-1)
{
    int cost=0;
    int use = Random(13)+1;

    switch(GetBaseItemType(Enchants.oItem))
    {
    case BASE_ITEM_BOOK:
        use = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        cost += 1;
        break;
    case BASE_ITEM_HELMET:
    case BASE_ITEM_BOOTS:
    case BASE_ITEM_CLOAK:
    case BASE_ITEM_BRACER:
    case BASE_ITEM_GLOVES:
    case BASE_ITEM_BELT:
        use = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        cost += 1;
        break;
    case BASE_ITEM_ARMOR:
        use = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        cost += 2;
        break;
    case BASE_ITEM_SMALLSHIELD:
    case BASE_ITEM_LARGESHIELD:
    case BASE_ITEM_TOWERSHIELD:
        use = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        //cost += 6;
        cost += 2;
        break;
    case BASE_ITEM_RING:
        use = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        cost += 2;
        break;
    case BASE_ITEM_AMULET:
        use = IP_CONST_CASTSPELL_NUMUSES_1_USE_PER_DAY;
        cost += 2;
        break;
    }



    int nCost=cost;
    if(use == 7) nCost += 5;
    else if(use > 7) nCost += use-7;

    int spell;
    if(Enchants.iPoints > 0)
    {

        if     ((Enchants.iPoints+nCost) >= 32) { nCost=32; spell=ImbueCastSpell20(); }
        else if((Enchants.iPoints+nCost) >= 30) { nCost=30; spell=ImbueCastSpell18(); }
        else if((Enchants.iPoints+nCost) >= 28) { nCost=28; spell=ImbueCastSpell17(); }
        else if((Enchants.iPoints+nCost) >= 26) { nCost=26; spell=ImbueCastSpell16(); }
        else if((Enchants.iPoints+nCost) >= 24) { nCost=24; spell=ImbueCastSpell15(); }
        else if((Enchants.iPoints+nCost) >= 22) { nCost=22; spell=ImbueCastSpell13(); }
        else if((Enchants.iPoints+nCost) >= 20) { nCost=20; spell=ImbueCastSpell12(); }
        else if((Enchants.iPoints+nCost) >= 18) { nCost=18; spell=ImbueCastSpell11(); }
        else if((Enchants.iPoints+nCost) >= 16) { nCost=16; spell=ImbueCastSpell10(); }
        else if((Enchants.iPoints+nCost) >= 14) { nCost=14; spell=ImbueCastSpell9(); }
        else if((Enchants.iPoints+nCost) >= 9) {  nCost=9; spell=ImbueCastSpell7(); }
        else if((Enchants.iPoints+nCost) >= 7) {  nCost=7; spell=ImbueCastSpell6(); }
        else if((Enchants.iPoints+nCost) >= 5) {  nCost=5; spell=ImbueCastSpell5(); }
        else if((Enchants.iPoints+nCost) >= 3) {  nCost=3; spell=ImbueCastSpell3(); }
        else if((Enchants.iPoints+nCost) >= 2) {  nCost=2; spell=ImbueCastSpell2(); }
        else if((Enchants.iPoints+nCost) >= 1) {  nCost=1; spell=ImbueCastSpell1(); }
        else nCost=0;
    }


   //SendMessageToPC(GetFirstPC(),"points="+IntToString(Enchants.iPoints)+" cost="+IntToString(nCost));
   if( nCost > 0 )
   {
        // there is a bug with acid fog
        if(spell == 0)
        {
            if(iChestLevel < 11) return Enchants;
        }
        itemproperty ipAdd = ItemPropertyCastSpell(spell,use);
        IPSafeAddItemProperty(Enchants.oItem,ipAdd);
        SetItemCharges(Enchants.oItem, Random(20)+Random(30));
        Enchants.iValue = nCost;
   }
   return Enchants;
}

