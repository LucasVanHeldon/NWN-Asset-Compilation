int Die(int sides)
{
    return Random(sides)+1;
}

int Dice(int sides, int num)
{
    int d = 0;
    int i;
    for(i = 0; i < num; i++)
    {
        d += Die(sides);
    }
    return d;
}

int SpellClass()
{
    switch(d6())
    {
    case 1: return IP_CONST_CLASS_CLERIC;
    case 2: return IP_CONST_CLASS_BARD;
    case 3: return IP_CONST_CLASS_PALADIN;
    case 4: return IP_CONST_CLASS_RANGER;
    case 5: return IP_CONST_CLASS_SORCERER;
    case 6: return IP_CONST_CLASS_WIZARD;
    }
    return IP_CONST_CLASS_CLERIC;
}


/********************************************************************************
 *
 * Apply Enchantments
 *
 *
 ********************************************************************************/

void PrintEnchants(struct sEnchantments Enchants)
{
    PrintString("Enchantments: item="+Enchants.sName);
    if(!GetIsObjectValid(Enchants.oItem) ) PrintString("Item Invalid!");
    PrintString("Align=" + IntToString(Enchants.iAlign));
    PrintString("Race=" + IntToString(Enchants.iRace));
    PrintString("Specific Align=" + IntToString(Enchants.iSAlign));
    PrintString("Attack Bonus=" + IntToString(Enchants.iAttackBonus));
    PrintString("Enhance Bonus=" + IntToString(Enchants.iEnhance));
    PrintString("Damage Bonus=" + IntToString(Enchants.iDamageBonus));
    PrintString("Ability (Str)=" + IntToString(Enchants.iAbilityStr));
    PrintString("Ability (Int)=" + IntToString(Enchants.iAbilityInt));
    PrintString("Ability (Dex)=" + IntToString(Enchants.iAbilityDex));
    PrintString("Ability (Con)=" + IntToString(Enchants.iAbilityCon));
    PrintString("Ability (Wis)=" + IntToString(Enchants.iAbilityWis));
    PrintString("Ability (Cha)=" + IntToString(Enchants.iAbilityCha));
    PrintString("Bonus Saving Throw=" + IntToString(Enchants.iBonusSaveThrow));
    PrintString("Bonus Saving Throw Type=" + IntToString(Enchants.iBonusSaveThrowType));
    PrintString("Bonus Save Fortitude=" + IntToString(Enchants.iBonusSaveF));
    PrintString("Bonus Save Reflex=" + IntToString(Enchants.iBonusSaveR));
    PrintString("Bonus Save Will=" + IntToString(Enchants.iBonusSaveW));
    PrintString("Extra Melee Damage=" + IntToString(Enchants.iExtraMeleeDamage));
    PrintString("Free Action=" + IntToString(Enchants.iFreeAction));
    PrintString("Holy Avenger=" + IntToString(Enchants.iHolyAvenger));
    PrintString("Massive Critical=" + IntToString(Enchants.iMassiveCritical));
    PrintString("Regeneration=" + IntToString(Enchants.iRegeneration));
    PrintString("Vampiric Regeneration=" + IntToString(Enchants.iVampiricRegeneration));
    PrintString("iValue=" + IntToString(Enchants.iValue));
    PrintString("iPoints=" + IntToString(Enchants.iPoints));
    PrintString("iTotalCost=" + IntToString(Enchants.iTotalCost));
    PrintString("iSpecific=" + IntToString(Enchants.iSpecific));
}

