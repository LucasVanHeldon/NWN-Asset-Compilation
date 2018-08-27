// Enchant (melee) weapons

// ranged and other weapons use lutes_roweapons

struct sEnchantments EnhanceWeapon(struct sEnchantments Enchants, int amount)
{
    int iInitEnhance = amount;
    int p = amount*3;
    int cost   = p;

    Enchants.iEnhance         += iInitEnhance;
    Enchants.iValue   = cost;
    return Enchants;
}


struct sEnchantments WeaponEnchantment(struct sEnchantments Enchants)
{
    int p = Die(6);

    switch(d4())
    {
    // to avoid highly chaotic weapon, force to even 25% distribution
    case 1:
        Enchants = DoImbueAttackBonus(Enchants);
        break;
    case 2:
        Enchants = DoImbueEnhanceBonus(Enchants);
        break;
    case 3:
        Enchants = DoImbueDamageBonus(Enchants);
        break;
    // this can generate unusual stuff.
    case 4:
        switch(p)
        {
        case 1:
            Enchants = ImbueSaveBonus(Enchants);
            break;
        case 2:
            Enchants = ImbueSaveThrowBonus(Enchants);
            break;
        case 3:
            Enchants = ImbueAbility(Enchants);
            break;
        case 4:
            Enchants = ImbueExtraMeleeDamage(Enchants);
            break;
        case 5:
            Enchants = ImbueFreeAction(Enchants);
            break;
        case 6:
            Enchants = ImbueMassiveCritical(Enchants);
            break;
        }
        break;
    }
    return Enchants;
}


struct sEnchantments EnchantManyVirtues(struct sEnchantments Enchants)
{
    int p = Die(5);
    switch(p)
    {
        case 1:
            Enchants = ImbueSaveBonus(Enchants);
            break;
        case 2:
            Enchants = ImbueSaveThrowBonus(Enchants);
            break;
        case 3:
            Enchants = ImbueAbility(Enchants);
            break;
        /*
        case 4:
            Enchants = ImbueBonusSkill(Enchants);
            break;
        case 5:
            Enchants = ImbueBonusFeat(Enchants);
            break;
        */
    }
    return Enchants;
}








struct sEnchantments EnchantWeaponOnHit(struct sEnchantments Enchants, int cost, int type)
{
   if(Enchants.iPoints >= cost*3)
   {
       Enchants = EnhanceWeapon(Enchants,7);
       Enchants.iOnHit   = type;
       Enchants.iOnHitDC = 6;
       cost = cost*3;
   }
   else if(Enchants.iPoints >= cost*2)
   {
       Enchants = EnhanceWeapon(Enchants,5);
       Enchants.iOnHit   = type;
       Enchants.iOnHitDC = 5;
       cost = cost*2;
   }
   else
   {
       Enchants = EnhanceWeapon(Enchants,3);
       Enchants.iOnHit   = type;
       Enchants.iOnHitDC = 4;
   }
   Enchants.iValue  = cost;
   return Enchants;
}

struct sEnchantments EnchantEnhancedWeapon(struct sEnchantments Enchants)
{
   int cost = 9;
   if(Enchants.iPoints >= cost*3)
   {
       Enchants = EnhanceWeapon(Enchants,7);
       cost = cost*3;
   }
   else if(Enchants.iPoints >= cost*2)
   {
       Enchants = EnhanceWeapon(Enchants,5);
       cost = cost*2;
   }
   else
   {
       Enchants = EnhanceWeapon(Enchants,3);
   }
   Enchants.iValue  = cost;
   return Enchants;
}

struct sEnchantments EnchantWeaponOfSleep(struct sEnchantments Enchants)
{
    return EnchantWeaponOnHit(Enchants,9,IP_CONST_ONHIT_SLEEP);
}

struct sEnchantments EnchantWeaponOfStunning(struct sEnchantments Enchants)
{
    return EnchantWeaponOnHit(Enchants,9,IP_CONST_ONHIT_STUN);
}

// this is a special item only useable by a fighter
struct sEnchantments EnchantVorpalWeapon(struct sEnchantments Enchants)
{

   return EnchantWeaponOnHit(Enchants,9,IP_CONST_ONHIT_VORPAL);
}

// this is a special item only useable by a fighter
struct sEnchantments EnchantWoundingWeapon(struct sEnchantments Enchants)
{
   return EnchantWeaponOnHit(Enchants,9,IP_CONST_ONHIT_WOUNDING);
}


// by default, good paladin only
struct sEnchantments EnchantWeaponOfDivineMight(struct sEnchantments Enchants)
{
   int cost          = 9;

   if(Enchants.iPoints > 26)
   {
       Enchants                  = EnhanceWeapon(Enchants,7);
       Enchants.iDamageBonusType = IP_CONST_DAMAGETYPE_DIVINE;
       Enchants.iDamageBonus     = 20;
       Enchants.iOnHit           = IP_CONST_ONHIT_SLAYALIGNMENTGROUP;
       Enchants.iOnHitDC         = 6;
       Enchants.iSpecial         = IP_CONST_ALIGNMENTGROUP_EVIL;
       cost = 27;
   }
   else if(Enchants.iPoints > 17)
   {
       Enchants                  = EnhanceWeapon(Enchants,5);
       Enchants.iDamageBonusType = IP_CONST_DAMAGETYPE_DIVINE;
       Enchants.iDamageBonus     = 18;
       Enchants.iOnHit           = IP_CONST_ONHIT_SLAYALIGNMENTGROUP;
       Enchants.iOnHitDC         = 5;
       Enchants.iSpecial         = IP_CONST_ALIGNMENTGROUP_EVIL;
       cost = 18;
   }
   else
   {
       Enchants                  = EnhanceWeapon(Enchants,3);
       Enchants.iDamageBonusType = IP_CONST_DAMAGETYPE_DIVINE;
       Enchants.iDamageBonus     = 16;
       Enchants.iOnHit           = IP_CONST_ONHIT_SLAYALIGNMENTGROUP;
       Enchants.iOnHitDC         = 4;
       Enchants.iSpecial         = IP_CONST_ALIGNMENTGROUP_EVIL;
   }
   Enchants.iValue  = cost;
   return Enchants;
}

struct sEnchantments EnchantWeaponDragonSlayer(struct sEnchantments Enchants)
{
   int cost          = 9;

   if(Enchants.iPoints > 26)
   {
       Enchants                       = EnhanceWeapon(Enchants,7);
       Enchants.iRace                 = 11;
       Enchants.iBonusSaveThrow       = 10;
       Enchants.iBonusSaveThrowType   = IP_CONST_SAVEVS_UNIVERSAL;
       cost = 27;
   }
   else if(Enchants.iPoints > 17)
   {
       Enchants                       = EnhanceWeapon(Enchants,5);
       Enchants.iRace                 = 11;
       Enchants.iBonusSaveThrow       = 6;
       Enchants.iBonusSaveThrowType   = IP_CONST_SAVEVS_UNIVERSAL;
       cost = 18;
   }
   else
   {
       Enchants                       = EnhanceWeapon(Enchants,3);
       Enchants.iRace                 = 11;
       Enchants.iBonusSaveThrow       = 3;
       Enchants.iBonusSaveThrowType   = IP_CONST_SAVEVS_UNIVERSAL;
   }
   Enchants.iValue  = cost;
   return Enchants;
}

// by default, good cleric only
struct sEnchantments EnchantHolyWeapon(struct sEnchantments Enchants)
{
   int cost          = 9;
   if(Enchants.iPoints > 26)
   {
       Enchants              = EnhanceWeapon(Enchants,7);
       Enchants.iHolyAvenger = 1;
       Enchants.iAbilityWis  = 5+Random(3);
       Enchants.iDamageBonusType = IP_CONST_DAMAGETYPE_DIVINE;
       Enchants.iDamageBonus = 9;
       Enchants.iOnHit       = IP_CONST_ONHIT_STUN;
       Enchants.iOnHitDC     = 6;
       Enchants.iSpecial     = 0;
       cost = 27;
   }
   else if(Enchants.iPoints > 17)
   {
       Enchants              = EnhanceWeapon(Enchants,5);
       Enchants.iHolyAvenger = 1;
       Enchants.iAbilityWis  = 3+Random(3);
       Enchants.iOnHit       = IP_CONST_ONHIT_STUN;
       Enchants.iOnHitDC     = 5;
       Enchants.iDamageBonusType = IP_CONST_DAMAGETYPE_DIVINE;
       Enchants.iDamageBonus     = 6;
       Enchants.iSpecial         = 1;
       cost = 18;
   }
   else
   {
       Enchants                  = EnhanceWeapon(Enchants,3);
       Enchants.iHolyAvenger     = 1;
       Enchants.iAbilityWis      = 1+Random(2);
       Enchants.iOnHit           = IP_CONST_ONHIT_STUN;
       Enchants.iOnHitDC         = 4;
       Enchants.iDamageBonusType = IP_CONST_DAMAGETYPE_DIVINE;
       Enchants.iDamageBonus     = 3;
       Enchants.iSpecial         = 0;
   }
   Enchants.iValue  = cost;
   return Enchants;
}


// Vampiric, by default evil
struct sEnchantments EnchantVampiricWeapon(struct sEnchantments Enchants)
{
   int cost          = 9;
   if(Enchants.iPoints > 26)
   {
       Enchants                       = EnhanceWeapon(Enchants,7);
       Enchants.iVampiricRegeneration = 9+Random(12);
       Enchants.iOnHit                = IP_CONST_ONHIT_LEVELDRAIN;
       Enchants.iOnHitDC              = 6;
       Enchants.iDamageBonusType      = IP_CONST_DAMAGETYPE_NEGATIVE;
       Enchants.iDamageBonus          = 9;
       Enchants.iSpecial              = 3;
       cost = 27;
   }
   else if(Enchants.iPoints > 17)
   {
       Enchants                       = EnhanceWeapon(Enchants,5);
       Enchants.iVampiricRegeneration = 6+Random(6);
       Enchants.iOnHit                = IP_CONST_ONHIT_LEVELDRAIN;
       Enchants.iOnHitDC              = 3;
       Enchants.iDamageBonusType      = IP_CONST_DAMAGETYPE_NEGATIVE;
       Enchants.iDamageBonus          = 5;
       Enchants.iSpecial              = 2;
       cost = 18;
   }
   else
   {
       Enchants                   = EnhanceWeapon(Enchants,3);
       Enchants.iOnHit            = IP_CONST_ONHIT_LEVELDRAIN;
       Enchants.iOnHitDC          = 4;
       Enchants.iVampiricRegeneration = 1 + Random(3);
       Enchants.iDamageBonusType  = IP_CONST_DAMAGETYPE_NEGATIVE;
       Enchants.iDamageBonus      = 3;
       Enchants.iSpecial          = 1;
   }
   Enchants.iValue  = cost;
   return Enchants;
}

// Ability Drain, by default evil
struct sEnchantments EnchantNegativeTouchWeapon(struct sEnchantments Enchants)
{
   int cost          = 9;

   if(Enchants.iPoints > 26)
   {
       Enchants                       = EnhanceWeapon(Enchants,7);
       Enchants.iOnHit                = IP_CONST_ONHIT_ABILITYDRAIN;
       Enchants.iOnHitDC              = 6;
       Enchants.iSpecial              = Random(6);
       Enchants.iDamageBonusType      = IP_CONST_DAMAGETYPE_NEGATIVE;
       Enchants.iDamageBonus          = 20;
       Enchants.iRegeneration         = 6 + Random(3);

       cost = 27;
   }
   else if(Enchants.iPoints > 17)
   {
       Enchants                       = EnhanceWeapon(Enchants,5);
       Enchants.iOnHit                = IP_CONST_ONHIT_ABILITYDRAIN;
       Enchants.iOnHitDC              = 5;
       Enchants.iDamageBonusType      = IP_CONST_DAMAGETYPE_NEGATIVE;
       Enchants.iDamageBonus          = 18;
       Enchants.iSpecial              = Random(6);
       Enchants.iRegeneration         = 6 + Random(3);
       cost = 18;
   }
   else
   {
       Enchants                   = EnhanceWeapon(Enchants,3);
       Enchants.iOnHit            = IP_CONST_ONHIT_ABILITYDRAIN;
       Enchants.iOnHitDC          = 4;
       Enchants.iDamageBonusType  = IP_CONST_DAMAGETYPE_NEGATIVE;
       Enchants.iDamageBonus      = 16;
       Enchants.iSpecial          = Random(6);
       Enchants.iRegeneration         = 6 + Random(3);
   }
   Enchants.iValue  = cost;
   return Enchants;
}

struct sEnchantments EnchantWeaponOfGreatDamage(struct sEnchantments Enchants)
{
   int cost          = 9;
   if( Enchants.iPoints > 26)
   {
       Enchants                  = EnhanceWeapon(Enchants,7);
       Enchants.iDamageBonusType = DamageType(Enchants);
       Enchants.iDamageBonus     = 20;
       Enchants.iExtraMeleeDamage = Enchants.iDamageBonusType;
       cost                      = 27;
   }
   else if( Enchants.iPoints > 18)
   {
       Enchants                  = EnhanceWeapon(Enchants,5);
       Enchants.iDamageBonusType = DamageType(Enchants);
       Enchants.iDamageBonus     = 19;
       Enchants.iExtraMeleeDamage = Enchants.iDamageBonusType;

       cost = 18;
   }
   else
   {
       Enchants                  = EnhanceWeapon(Enchants,3);
       Enchants.iDamageBonusType = DamageType(Enchants);
       Enchants.iDamageBonus     = 18;
       Enchants.iExtraMeleeDamage = Enchants.iDamageBonusType;

   }
   Enchants.iValue           = cost;
   return Enchants;
}

struct sEnchantments EnchantWeaponOfManyVirtues(struct sEnchantments Enchants)
{
   int cost  = 9;
   int i;
   int num;
   int bonus;

   if(Enchants.iPoints > 26)
   {
        num = 5;
        bonus = 5;
        cost = 27;
   }
   else if (Enchants.iPoints > 17)
   {
        num = 4;
        bonus = 4;
        cost = 18;
   }
   else
   {
        num = 3;
        bonus = 3;
   }

   Enchants  = EnhanceWeapon(Enchants,bonus);
   for(i = 0; i < num; i++)
   {
    switch(d6())
    {
    case 1: Enchants.iAbilityStr += 1; break;
    case 2: Enchants.iAbilityInt += 1; break;
    case 3: Enchants.iAbilityDex += 1; break;
    case 4: Enchants.iAbilityWis += 1; break;
    case 5: Enchants.iAbilityCon += 1; break;
    case 6: Enchants.iAbilityCha += 1; break;
    }
   }

   Enchants.iValue  = cost;
   return Enchants;
}


/********************************************************************************
 *
 * Enchant Melee Weapons
 *
 *
 ********************************************************************************/


void SetWeaponName(struct sEnchantments Enchants)
{
    object oItem = Enchants.oItem;

    // cleric only holy mace
    if(Enchants.iSpecific == T_HOLYMACE)
    {
        if(Enchants.iTotalCost < 10)
        {
            SetName(oItem,"Cleric's " + Enchants.sName);
        }
        else if(Enchants.iTotalCost > 9 && Enchants.iTotalCost < 19)
        {
            SetName(oItem,"Cleric's " + Enchants.sName + " of Power");
        }
        else if(Enchants.iTotalCost > 18 && Enchants.iTotalCost < 28)
        {
            if(IsGood(Enchants))
                SetName(oItem,"Great " + Enchants.sName + " of Holy Power");
            else if(IsEvil(Enchants))
                SetName(oItem,"Great " + Enchants.sName + " of Liberation");
        }
        else if(Enchants.iTotalCost > 27)
        {
            if(IsGood(Enchants))
                SetName(oItem,"Devout " + Enchants.sName + " of Divine Might");
            else if(IsEvil(Enchants))
                SetName(oItem,"Dedicated " + Enchants.sName + " of Enlightenment");
        }

        int iItemVisual=ITEM_VISUAL_HOLY;
        if(IsEvil(Enchants)) iItemVisual = ITEM_VISUAL_EVIL;

        itemproperty ipAdd = ItemPropertyVisualEffect(iItemVisual);
        IPSafeAddItemProperty(oItem, ipAdd);

        ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_CLERIC);
        IPSafeAddItemProperty(oItem, ipAdd);

    }
    // only useable by paladin, possibly the most powerful melee weapon generated
    else if(Enchants.iSpecific == T_DIVINEMIGHT)
    {
        if(Enchants.iTotalCost > 9 && Enchants.iTotalCost < 19)
            SetName(oItem, Enchants.sName + " of Divine Might");
        else if(Enchants.iTotalCost > 18 && Enchants.iTotalCost < 28)
            SetName(oItem, "Disciplined " + Enchants.sName + " of Divine Might");
        else if(Enchants.iTotalCost > 27)
            SetName(oItem, "Devout " + Enchants.sName+ " of Divine Might");

        itemproperty ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_PALADIN);
        IPSafeAddItemProperty(oItem, ipAdd);

        int iItemVisual=ITEM_VISUAL_HOLY;
        ipAdd = ItemPropertyVisualEffect(iItemVisual);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    // evil only
    else if(Enchants.iSpecific == T_VAMPIRIC)
    {
        SetName(oItem, "Vampiric " + Enchants.sName);

        itemproperty ipAdd = ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_EVIL);
        IPSafeAddItemProperty(oItem, ipAdd);

        int iItemVisual=ITEM_VISUAL_EVIL;

        ipAdd = ItemPropertyVisualEffect(iItemVisual);
        IPSafeAddItemProperty(oItem, ipAdd);

    }
    else if(Enchants.iSpecific == T_REGENERATION)
    {
        if(Enchants.iRegeneration > 0)
        {
            if(Enchants.iTotalCost < 10)
                SetName(oItem,"Lesser " + Enchants.sName + " of Regeneration");
            else if(Enchants.iTotalCost > 9 && Enchants.iTotalCost < 19)
                SetName(oItem,Enchants.sName + " of Regeneration");
            else if(Enchants.iTotalCost > 18 && Enchants.iTotalCost < 28)
                SetName(oItem, "Greater " + Enchants.sName + " of Regeneration" );
            else if(Enchants.iTotalCost > 27)
                SetName(oItem, "Legendary " + Enchants.sName + " of Regeneration");
        }
    }
    // All
    else if(Enchants.iSpecific == T_MANY_VIRTUES)
    {
        SetName(oItem,"Minor " + Enchants.sName + " of Virtues");
    }
    // Fighter only
    else if(Enchants.iSpecific == T_GREAT_DAMAGE)
    {
        SetName(oItem,Enchants.sName + " of Damage Focus");
        itemproperty ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_FIGHTER);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    // only useable by fighter or barbarian
    else if(Enchants.iSpecific == T_WOUNDING)
    {
        if(Enchants.iTotalCost < 9)
            SetName(oItem,"Lesser " + Enchants.sName + " of Wounding");
        else if(Enchants.iTotalCost > 9 && Enchants.iTotalCost < 19)
            SetName(oItem,Enchants.sName + " of Wounding");
        else if(Enchants.iTotalCost > 18 && Enchants.iTotalCost < 29)
            SetName(oItem,"Greater " + Enchants.sName + " of Slaughter");
        else if(Enchants.iTotalCost > 27)
            SetName(oItem,"Legendary " + Enchants.sName + " of Great Carnage");

        itemproperty ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_FIGHTER);
        IPSafeAddItemProperty(oItem, ipAdd);
        ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_BARBARIAN);
        IPSafeAddItemProperty(oItem, ipAdd);

    }
    // only useable by fighter
    else if(Enchants.iSpecific == T_VORPAL)
    {
        if(Enchants.iTotalCost > 8 && Enchants.iTotalCost < 19)
            SetName(oItem,"Vorpal " + Enchants.sName);
        else if(Enchants.iTotalCost > 18 && Enchants.iTotalCost < 29)
            SetName(oItem,"Great Vorpal " + Enchants.sName);
        else if(Enchants.iTotalCost > 27)
            SetName(oItem,"Legendary " + Enchants.sName + " of Vorpal Sharpness");

        itemproperty ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_FIGHTER);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    // fighter only
    else if(Enchants.iSpecific == T_DRAGONSLAYER)
    {
            SetName(oItem,"Dragon Slayer");
            itemproperty ipAdd = ItemPropertyBonusSavingThrowVsX(IP_CONST_SAVEVS_UNIVERSAL, Enchants.iBonusSaveThrow);
            IPSafeAddItemProperty(oItem, ipAdd);
    }
    // only useable by rogue and monk
    else if(Enchants.iSpecific == T_STUNNING)
    {
        SetName(oItem,Enchants.sName + " of Stunning");
        itemproperty ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_ROGUE);
        IPSafeAddItemProperty(oItem, ipAdd);

        ipAdd = ItemPropertyLimitUseByClass(IP_CONST_CLASS_MONK);
        IPSafeAddItemProperty(oItem, ipAdd);

    }
    // Nightmares
    else if(Enchants.iSpecific == T_DEADLYSLEEP)
    {
        if(Enchants.iTotalCost > 8 && Enchants.iTotalCost < 19)
            SetName(oItem,Enchants.sName + " of Nightmares");
        else if(Enchants.iTotalCost > 18 && Enchants.iTotalCost < 29)
            SetName(oItem,"Greater " + Enchants.sName+ " of Nightmares");
        else if(Enchants.iTotalCost > 27) SetName(oItem,"Legendary " + Enchants.sName +  " of Nightmares");

    }
    // evil only, greater negative damage and draining
    // also called Sinister Weapon
    else if(Enchants.iSpecific == T_NEGATIVETOUCH)
    {
        SetName(oItem,"Sinister " + Enchants.sName);

        itemproperty ipAdd = ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_EVIL);
        IPSafeAddItemProperty(oItem, ipAdd);

        int iItemVisual=ITEM_VISUAL_EVIL;

        ipAdd = ItemPropertyVisualEffect(iItemVisual);
        IPSafeAddItemProperty(oItem, ipAdd);
    }
    else
    {
        string sName = "Enchanted " + Enchants.sName;
        if(Enchants.iEnhance > 3)
            sName = "Greatly " + sName;
        else if(Enchants.iEnhance > 6)
            sName = "Powerfully " + sName;
        else if(Enchants.iEnhance > 9)
            sName = "Mightily " + sName;

        if(Enchants.iAlign == LAW)
        {
                itemproperty ipAdd = ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_CHAOTIC);
                IPSafeAddItemProperty(oItem, ipAdd);
                sName = sName + " of Chaotic Alignment";
        }
        else if(Enchants.iAlign == CHAOS)
        {
            itemproperty ipAdd = ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_LAWFUL);
            IPSafeAddItemProperty(oItem, ipAdd);
            sName = sName + " of Lawful Alignment";
        }
        else if(Enchants.iAlign == GOOD)
        {
            itemproperty ipAdd = ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_EVIL);
            IPSafeAddItemProperty(oItem, ipAdd);

            sName = sName + " of Evil Alignment";
        }
        else if(Enchants.iAlign == EVIL)
        {
            itemproperty ipAdd = ItemPropertyLimitUseByAlign(IP_CONST_ALIGNMENTGROUP_GOOD);
            IPSafeAddItemProperty(oItem, ipAdd);
            sName = sName + " of Good Alignment";
        }
        else if(Enchants.iRace != -1)
        {

            switch(Enchants.iRace)
            {
            case IP_CONST_RACIALTYPE_HUMANOID_GOBLINOID: sName = sName + " (Goblin Foe)"; break;
            case IP_CONST_RACIALTYPE_HUMANOID_ORC:       sName = sName + " (Orc Foe)"; break;
            case IP_CONST_RACIALTYPE_GIANT:             sName = sName + " (Giant Foe)"; break;
            case IP_CONST_RACIALTYPE_BEAST:             sName = sName + " (Beast Foe)"; break;
            case IP_CONST_RACIALTYPE_ABERRATION:        sName = sName + " (Aberration Foe)"; break;
            case IP_CONST_RACIALTYPE_MAGICAL_BEAST:      sName = sName + " (Magical Beast Foe)"; break;
            case IP_CONST_RACIALTYPE_ELF:               sName = sName + " (Elf Foe)"; break;
            case IP_CONST_RACIALTYPE_DWARF:             sName = sName + " (Dwarf Foe)"; break;
            case IP_CONST_RACIALTYPE_CONSTRUCT:         sName = sName + " (Construct Foe)"; break;
            case IP_CONST_RACIALTYPE_FEY:               sName = sName + " (Fey Foe)"; break;
            case IP_CONST_RACIALTYPE_OUTSIDER:          sName = sName + " (Outsider Foe)"; break;
            }
       }

        SetName(oItem,sName);
    }
}






struct sEnchantments EnchantWeaponFocus(struct sEnchantments Enchants)
{
    int iSpecific = NONE;
    // there is a 50% chance items have alignment and are restricted to use
    if(d100() <= ALIGNMENT_FOCUS)
    {
        switch(d4())
        {
        // Lawful only
        case 1:
            PrintString("Weapon: Lawful");
            iSpecific        = T_LAWFUL;
            Enchants.iAlign  = CHAOS;
            Enchants.iSAlign = PickAlignment(CHAOS);
            break;

        // chaotic only
        case 2:
            PrintString("Weapon: Chaotic");
            iSpecific        = T_CHAOTIC;
            Enchants.iAlign  = LAW;
            Enchants.iSAlign = PickAlignment(LAW);
            break;

        // good only
        case 3:
            PrintString("Weapon: Good");
            iSpecific        = T_GOOD;
            Enchants.iAlign  = EVIL;
            Enchants.iSAlign = PickAlignment(EVIL);
            break;

        // evil only
        case 4:
            PrintString("Weapon: Evil");
            iSpecific = T_EVIL;
            Enchants.iAlign  = GOOD;
            Enchants.iSAlign = PickAlignment(GOOD);
            break;

        }
    }
    // There is a 10% chance a weapon is Race Focused
    else if(d100() <= RACE_FOCUS)
    {
        PrintString("Weapon: Race Focus");
        Enchants.iAlign  = ALL;
        Enchants.iSAlign = -1;
        iSpecific        = T_RACE;
        Enchants.iRace   = PickRace(EVIL);
    }
    Enchants.iSpecific = iSpecific;
    return Enchants;
}

struct sEnchantments EnchantSpecialWeapon(struct sEnchantments Enchants)
{
    int iSpecific = NONE;
    int c = Die(10);
    struct sItemInfo ItemInfo;
    object o;

    ItemInfo.oItem = Enchants.oItem;
    ItemInfo.sName = Enchants.sName;

    switch(c)
    {
    // any
    case 1:
         PrintString("Weapon: Great Damage");
         Enchants  = EnchantWeaponOfGreatDamage(Enchants);
         iSpecific = T_GREAT_DAMAGE;
         break;

    // any
    case 2:
         PrintString("Weapon: Many Virtues");
         Enchants  = EnchantWeaponOfManyVirtues(Enchants);
         iSpecific = T_MANY_VIRTUES;
         break;

    // evil only
    case 3:
        PrintString("Weapon: Vampiric");
        Enchants = EnchantVampiricWeapon(Enchants);
        iSpecific        = T_VAMPIRIC;
        Enchants.iAlign  = GOOD;
        Enchants.iSAlign = PickAlignment(GOOD);
        break;

    // evil only
    case 4:
        PrintString("Weapon: Negative Touch");
        iSpecific        = T_NEGATIVETOUCH;
        Enchants         = EnchantNegativeTouchWeapon(Enchants);
        Enchants.iAlign  = GOOD;
        Enchants.iSAlign = PickAlignment(GOOD);
        break;

    // cleric mace
    case 5:

        PrintString("Weapon: Cleric");
        // although possible, clerics traditionally only use blunt weapons
        // force the weapon to blunt.
        if( !IsClericWeapon(ItemInfo) )
        {

            o = ItemInfo.oItem;
            ItemInfo = MaceBP();
            ItemInfo.oItem = CreateItemOnObject(ItemInfo.sBluePrint,oObject);

            if( !GetIsObjectValid(ItemInfo.oItem) )
            {
                PrintString("Create Cleric object failed");
                break;
            }

            DestroyObject(o);

            int a = GOOD;
            if(d100() > 39) a = EVIL;
            iSpecific = T_HOLYMACE;
            Enchants.iAlign   = a;
            Enchants.iSAlign  = PickAlignment(a);
            Enchants.iRace    = ClericRace(a);
            Enchants  = EnchantHolyWeapon(Enchants);

        }
        break;

    // fighters only
    case 6:

        PrintString("Weapon : Vorpal");

        o = ItemInfo.oItem;
        ItemInfo = GenerateSword();
        ItemInfo.oItem    = CreateItemOnObject(ItemInfo.sBluePrint,oObject);

        if( !GetIsObjectValid(ItemInfo.oItem) )
        {
            PrintString("Create Cleric object failed");
            break;
        }
        DestroyObject(o);
        Enchants  = EnchantVorpalWeapon(Enchants);
        iSpecific = T_VORPAL;
        break;

    // fighters and barbarians
    case 7:

        PrintString("Weapon : Wounding");
        // wounding weapons must be slash or axes
        if( ItemInfo.wType != WEAPON_SLASH)
        {
            o = ItemInfo.oItem;
            ItemInfo = GenerateAxe();
            ItemInfo.oItem    = CreateItemOnObject(ItemInfo.sBluePrint,oObject);

            if( !GetIsObjectValid(ItemInfo.oItem) )
            {
                PrintString("Create Cleric object failed");
                break;
            }

            DestroyObject(o);
        }
        Enchants  = EnchantWoundingWeapon(Enchants);
        iSpecific = T_WOUNDING;
        if(Enchants.iPoints >= 27) Enchants.iSpecial = 5;
        else if(Enchants.iPoints >= 18) Enchants.iSpecial = 4;
        else Enchants.iSpecial = 3;
        break;

    // only rogues or monks
    case 8:

        PrintString("Weapon : Stunning");
        o = ItemInfo.oItem;
        ItemInfo = ClubBP();
        ItemInfo.oItem    = CreateItemOnObject(ItemInfo.sBluePrint,oObject);
        if( !GetIsObjectValid(ItemInfo.oItem) )
        {
            PrintString("Create Club of Stunning object failed");
            break;
        }

        DestroyObject(o);
        Enchants  = EnchantWeaponOfStunning(Enchants);
        iSpecific = T_STUNNING;
        break;

    // Divine Might - Paladins Only
    // This is the only melee weapon that can slay on hit (evil)
    case 9:

        PrintString("Weapon : Divine Might");

        o = ItemInfo.oItem;
        ItemInfo = GreatSwordBP();
        ItemInfo.oItem    = CreateItemOnObject(ItemInfo.sBluePrint,oObject);

        if( !GetIsObjectValid(ItemInfo.oItem) )
        {
            PrintString("Create Cleric object failed");
            break;
        }

        DestroyObject(o);

        iSpecific         = T_DIVINEMIGHT;

        Enchants          = EnchantWeaponOfDivineMight(Enchants);
        Enchants.iAlign   = EVIL;
        break;

    // DragonSlayer - enchanted long sword vs Dragons with save throw bonuses
    // fighters only
    case 10:

        // it is always a noble long sword
        PrintString("Weapon : Dragon Slayer");
        o = ItemInfo.oItem;
        ItemInfo = LongSwordBP();

        ItemInfo.oItem    = CreateItemOnObject(ItemInfo.sBluePrint,oObject);

        if( !GetIsObjectValid(ItemInfo.oItem) )
        {
            PrintString("Create Cleric object failed");
            break;
        }

        DestroyObject(o);

        Enchants  = EnchantWeaponDragonSlayer(Enchants);
        iSpecific = T_DRAGONSLAYER;
        break;
    }
    Enchants.iSpecific = iSpecific;
    Enchants.oItem     = ItemInfo.oItem;
    Enchants.sName     = ItemInfo.sName;

    return Enchants;
}

// tier 1 = 1-3
// tier 2 = 4-6
// tier 3 = 7-9
// tier 4 = 9-12
// tier 5 = 12-18
// tier 6 = 18+

void EnchantWeapon(struct sItemInfo ItemInfo)
{
    int    iTotalCost=0;
    int    iPoints=iChestLevel;
    struct sEnchantments Enchants;
    int    ticker = 0;
    int    tier=1;

    int level =  iChestLevel;
    if(d6() == 1) iPoints += d4();
    if(d20() == 1) iPoints += d4(2);

    // don't generate magical items of obscene proportions
    if(level > 40) iChestLevel = 40;

    if(iChestLevel <= 3) tier=1;
    else if(iChestLevel > 3 && iChestLevel < 10)   tier=2;
    else if(iChestLevel > 10 && iChestLevel < 20)  tier=3;
    else if(iChestLevel > 20 && iChestLevel < 30)  tier=4;
    else if(iChestLevel > 30 && iChestLevel < 40) tier=5;
    else tier=6;


    Enchants.oItem      = ItemInfo.oItem;
    Enchants.sName      = ItemInfo.sName;


    Enchants.iAlign = ALL;
    Enchants.iRace = -1;
    Enchants.iOnHitDC=-1;
    Enchants.iSpellResistance=-1;

    if(tier > 3 && d100() >= SPECIAL)
    {
        Enchants.iPoints = iPoints;
        Enchants         = EnchantSpecialWeapon(Enchants);
        iTotalCost       = Enchants.iValue;
    }
    else
    {
        int bonus = 0;

        if(d100() > 95)
        {
            bonus = 1;
        }

        if(bonus == 1 || tier > 1)
        {
            int base   = (tier-1);
            if(base < 0) base = 0;
            Enchants   = EnhanceWeapon(Enchants,base+bonus);
            Enchants   = EnchantWeaponFocus(Enchants);

            iTotalCost += base*3;
            iPoints    -= base*3;
        }

        if(d100() > 95)
            iPoints += d4(tier);

        PrintString("Enchant Weapon: Points="+IntToString(iPoints));

        int cost   = iTotalCost;
        int points = iPoints;
        Enchants.iPoints = iPoints;
        while(points > 0)
        {
            Enchants.iValue = 0;
            int iRoll = Die(16);
            //PrintString("Roll="+IntToString(iRoll));

            if(points == 1) Enchants  = DoImbueAttackBonus(Enchants);
            if(points == 2) Enchants  = DoImbueDamageBonus(Enchants);
            else
            {
                switch(iRoll)
                {

                case 1: Enchants  = DoImbueAttackBonus(Enchants);  break;
                case 2: Enchants  = DoImbueDamageBonus(Enchants);  break;
                case 3: Enchants  = DoImbueEnhanceBonus(Enchants); break;
                case 4: Enchants  = ImbueSaveThrowBonus(Enchants);  break;
                case 5: Enchants  = ImbueExtraMeleeDamage(Enchants);  break;
                case 6: Enchants  = ImbueFreeAction(Enchants);  break;
                case 7: Enchants  = ImbueHolyAvenger(Enchants); break;
                case 8: Enchants  = ImbueMassiveCritical(Enchants); break;
                case 9: Enchants  = ImbueRegeneration(Enchants); break;
                case 10: Enchants = ImbueVampiricRegeneration(Enchants);break;
                case 11: Enchants = ImbueBonusSpellSlot(Enchants); break;
                case 12: Enchants = ImbueSpellResistance(Enchants);break;
                case 13: Enchants = ImbueSaveBonus(Enchants);break;
                case 14: Enchants = ImbueAbility(Enchants);break;
                case 15: Enchants = ImbueOnHit(Enchants); break;
                case 16: Enchants = ImbueOnHitCastSpell(Enchants); break;
                }
            }
            //PrintString("Enchants.iValue="+IntToString(Enchants.iValue));
            // fix the watchdog to avoid infinite loops
            if(Enchants.iValue > 0) ticker = 0;
            else ticker = ticker +1;

            points -= Enchants.iValue;
            cost   += Enchants.iValue;

            if(ticker > 20) break;
        }
        iTotalCost = cost;
    }
    if(iTotalCost > 0)
    {
        Enchants.iTotalCost = iTotalCost;
        ApplyEnchantments(Enchants);
        SetWeaponName(Enchants);

    }
    iChestLevel = level;

}


/********************************************************************************
 *
 * Melee Weapons
 *
 *
 ********************************************************************************/
int W_SWORD=1;
int W_DAGGER=2;
int W_AXE=3;
int W_BLUNT=4;
int W_POLEARM=5;

void GenerateMeleeWeapon(int type = -1)
{
    struct sItemInfo ItemInfo;

    int iRoll = Random(5)+1;
    if(type != -1) iRoll = type;
    if( iRoll == 1 ) ItemInfo=GenerateSword();
    if( iRoll == 2 ) ItemInfo=GenerateDagger();
    if( iRoll == 3 ) ItemInfo=GenerateAxe();
    if( iRoll == 4 ) ItemInfo=GenerateBluntWeapon();
    if( iRoll == 5 ) ItemInfo=GeneratePoleArm();



    ItemInfo.oItem = CreateObject(OBJECT_TYPE_ITEM,ItemInfo.sBluePrint,GetLocation(GetObjectByTag("DUMMYCHEST")));
    if( !GetIsObjectValid(ItemInfo.oItem) )
    {
        PrintString("Create Weapon " + ItemInfo.sName + " bp="+ItemInfo.sBluePrint+" failed.");
        return;
    }

    ItemInfo.oItem=    IPGetModifiedWeapon(ItemInfo.oItem,ITEM_APPR_WEAPON_COLOR_BOTTOM,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedWeapon(ItemInfo.oItem,ITEM_APPR_WEAPON_COLOR_TOP,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedWeapon(ItemInfo.oItem,ITEM_APPR_WEAPON_MODEL_BOTTOM,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedWeapon(ItemInfo.oItem,ITEM_APPR_WEAPON_MODEL_MIDDLE,X2_IP_ARMORTYPE_RANDOM,TRUE);
    ItemInfo.oItem=    IPGetModifiedWeapon(ItemInfo.oItem,ITEM_APPR_WEAPON_MODEL_TOP,X2_IP_ARMORTYPE_RANDOM,TRUE);

    object o = CopyItem(ItemInfo.oItem,oObject);
    DestroyObject(ItemInfo.oItem);
    ItemInfo.oItem = o;

    EnchantWeapon(ItemInfo);
}


