// todo:
// bracers
// gauntlets
// boots
// belts
// cloaks


struct sEnchantments ImbueAmmoDamageBonus(struct sEnchantments Enchants)
{
    int cost;
    int iType;
    int iRange;
    int iDam;
    int iRoll = d12();
    switch (iRoll)
    {
     case 1: iType = IP_CONST_DAMAGETYPE_ACID; break;
     case 2: iType = IP_CONST_DAMAGETYPE_BLUDGEONING; break;
     case 3: iType = IP_CONST_DAMAGETYPE_COLD; break;
     case 4: iType = IP_CONST_DAMAGETYPE_ELECTRICAL; break;
     case 5: iType = IP_CONST_DAMAGETYPE_FIRE; break;
     case 6: iType = IP_CONST_DAMAGETYPE_MAGICAL; break;
     case 7: iType = IP_CONST_DAMAGETYPE_NEGATIVE; break;
     case 8: iType = IP_CONST_DAMAGETYPE_DIVINE; break;
     case 9: iType = IP_CONST_DAMAGETYPE_PIERCING; break;
     case 10: iType = IP_CONST_DAMAGETYPE_POSITIVE; break;
     case 11: iType = IP_CONST_DAMAGETYPE_SLASHING; break;
     case 12: iType = IP_CONST_DAMAGETYPE_SONIC; break;
    }
    iRange = Random(5)+1;
    switch(iRange)
    {
     case 1:cost=1; iDam = IP_CONST_DAMAGEBONUS_1; break;
     case 2: {
            iRoll = d4();
            cost=3;
            if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_1;
            if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_2;
            if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_1d4;
            if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_3;
           }break;
     case 3: {
            iRoll = d6();
            cost=6;
            if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_2;
            if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_3;
            if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_1d4;
            if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d6;
            if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_4;
            if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_5;
           }break;
     case 4: {
            iRoll = d8();
            cost=9;
            if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_3;
            if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d4;
            if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_4;
            if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d6;
            if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_5;
            if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_1d8;
            if (iRoll==7)iDam = IP_CONST_DAMAGEBONUS_6;
            if (iRoll==8)iDam = IP_CONST_DAMAGEBONUS_1d10;
           }break;
     case 5: {
            iRoll = d10();
            cost=15;
            if (iRoll==1)iDam = IP_CONST_DAMAGEBONUS_3;
            if (iRoll==2)iDam = IP_CONST_DAMAGEBONUS_1d4;
            if (iRoll==3)iDam = IP_CONST_DAMAGEBONUS_4;
            if (iRoll==4)iDam = IP_CONST_DAMAGEBONUS_1d6;
            if (iRoll==5)iDam = IP_CONST_DAMAGEBONUS_5;
            if (iRoll==6)iDam = IP_CONST_DAMAGEBONUS_1d8;
            if (iRoll==7)iDam = IP_CONST_DAMAGEBONUS_2d4;
            if (iRoll==8)iDam = IP_CONST_DAMAGEBONUS_6;
            if (iRoll==9)iDam = IP_CONST_DAMAGEBONUS_1d10;
            if (iRoll==10)iDam = IP_CONST_DAMAGEBONUS_7;
           }break;
      }
    if(cost <= Enchants.iPoints)
    {
        Enchants.iValue = cost;
        itemproperty ipAdd = ItemPropertyDamageBonus(iType, iDam);
        IPSafeAddItemProperty(Enchants.oItem, ipAdd);
    }
    return Enchants;
}



void EnchantAmmo(struct sItemInfo ItemInfo)
{
    int    iTotalCost=0;
    int    iPoints=iChestLevel;
    struct sEnchantments Enchants;
    int    ticker = 0;
    int    tier=1;

    int level =  iChestLevel;

    // don't generate magical items of obscene proportions
    if(level > 40) iChestLevel = 40;

    if(iChestLevel <= 3) tier=1;
    else if(iChestLevel > 3 && iChestLevel < 7)   tier=2;
    else if(iChestLevel > 6 && iChestLevel < 10)  tier=3;
    else if(iChestLevel > 9 && iChestLevel < 13)  tier=4;
    else if(iChestLevel > 12 && iChestLevel < 16) tier=5;
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



        if(d100() > 95)
            iPoints += d4(tier);


        int cost   = iTotalCost;
        int points = iPoints;
        Enchants.iPoints = iPoints;
        while(points > 0)
        {
            Enchants.iValue = 0;
            switch(d3())
            {
            case 1:
                Enchants = ImbueAmmoDamageBonus(Enchants);
                break;
            case 2: Enchants = ImbueOnHitCastSpell(Enchants);break;
            case 3: Enchants = ImbueOnHit(Enchants);break;
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

void EnchantRangedWeapon(struct sItemInfo ItemInfo)
{
    int    iTotalCost=0;
    int    iPoints=iChestLevel;
    struct sEnchantments Enchants;
    int    ticker = 0;
    int    tier=1;

    int level =  iChestLevel;

    // don't generate magical items of obscene proportions
    if(level > 40) iChestLevel = 40;

    if(iChestLevel <= 3) tier=1;
    else if(iChestLevel > 3 && iChestLevel < 7)   tier=2;
    else if(iChestLevel > 6 && iChestLevel < 10)  tier=3;
    else if(iChestLevel > 9 && iChestLevel < 13)  tier=4;
    else if(iChestLevel > 12 && iChestLevel < 16) tier=5;
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

        if(d100() > 95)
            iPoints += d4(tier);

        int cost   = iTotalCost;
        int points = iPoints;
        Enchants.iPoints = iPoints;
        while(points > 0)
        {
            Enchants.iValue = 0;
            int iRoll = Die(7);
            //PrintString("Roll="+IntToString(iRoll));

            if(points == 1) Enchants = DoImbueAttackBonus(Enchants);
            else
            {
                switch(iRoll)
                {
                case 0: Enchants = ImbueAbility(Enchants);break;
                case 1: Enchants  = DoImbueAttackBonus(Enchants);  break;
                case 2: Enchants  = ImbueSaveThrowBonus(Enchants);  break;
                case 3: Enchants  = ImbueFreeAction(Enchants);  break;
                case 4: Enchants  = ImbueRegeneration(Enchants); break;
                case 5: Enchants = ImbueSpellResistance(Enchants);break;
                case 6: Enchants = ImbueSaveBonus(Enchants);break;

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

string GenerateLongbow()
{
    return "lutes_longbow";
}

string GenerateShortbow()
{
    return "lutes_shortbow";
}

string GenerateSling()
{
    return "lutes_sling";
}

string GenerateLightCrossbow()
{
    return "lutes_lcrossbow";
}

string GenerateHeavyCrossbow()
{
    return "lutes_hcrossbow";
}


void GenerateAmmo()
{
    string bp;
    string name;
    struct sItemInfo ItemInfo;
    switch(Random(5))
    {
    case 0: bp="lutes_arrows"; name="Arrows"; break;
    case 1: bp="lutes_bolts"; name="Bolts"; break;
    case 2: bp="lutes_bullets"; name="Bullets"; break;
    }

    object oitem = CreateItemOnObject(bp,OBJECT_SELF,Random(100));
    ItemInfo.sName = name;
    ItemInfo.oItem = oitem;

    EnchantAmmo(ItemInfo);
}

void GenerateRangedWeapon()
{
    string bp;
    string name;
    struct sItemInfo ItemInfo;
    switch(Random(5))
    {
    case 0: bp=GenerateHeavyCrossbow(); name="Heavy Crossbow"; break;
    case 1: bp=GenerateLongbow(); name="Longbow"; break;
    case 2: bp=GenerateShortbow(); name="Shortbow"; break;
    case 3: bp=GenerateSling(); name="Sling"; break;
    case 4: bp=GenerateLightCrossbow(); name="Light Crossbow"; break;
    }


    object oitem = CreateItemOnObject(bp,OBJECT_SELF,1);
    ItemInfo.sName = name;
    ItemInfo.oItem = oitem;

    EnchantRangedWeapon(ItemInfo);
}

void PlaceRangedWeapon(int n)
{
    int i;
    for(i = 0; i < n; i++)
        GenerateRangedWeapon();
}

void PlaceAmmo(int n)
{
    int i;
    for(i =0 ; i < n; i++)
        GenerateAmmo();
}

void EnchantGrenade(struct sItemInfo ItemInfo)
{
    int    iTotalCost=0;
    int    iPoints=iChestLevel;
    struct sEnchantments Enchants;
    int    ticker = 0;
    int    tier=1;

    int level =  iChestLevel;

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

    int bonus = 0;

    if(d100() > 95) bonus = 1;

    int base = (tier-1);
    if( base < 0 ) base = 0;

    iTotalCost += base*3;
    iPoints    -= base*3;

    if(d100() > 95)
        iPoints += d4(tier);

    int cost   = iTotalCost;
    int points = iPoints;
    Enchants.iPoints = iPoints;
    while(points > 0)
    {
        Enchants.iValue = 0;
        int iRoll = Die(12);
        //PrintString("Roll="+IntToString(iRoll));

        Enchants = ImbueCastSpell(Enchants);


        //PrintString("Enchants.iValue="+IntToString(Enchants.iValue));
        // fix the watchdog to avoid infinite loops
        if(Enchants.iValue > 0) ticker = 999;
        else ticker = ticker +1;

        points -= Enchants.iValue;
        cost   += Enchants.iValue;

        if(ticker > 20) break;
    }
    iTotalCost = cost;

    if(iTotalCost > 0)
    {
        Enchants.iTotalCost = iTotalCost;
        ApplyEnchantments(Enchants);
        //SetWeaponName(Enchants);
        SetName(Enchants.oItem, "Enchanted " + ItemInfo.sName);
    }
    iChestLevel = level;
}

void GenerateGrenade()
{
    struct sItemInfo info;
    info.sBluePrint = "lutes_flask";
    info.oItem = CreateItemOnObject("lutes_flask",oObject);
    EnchantGrenade(info);
    SetName(info.oItem,"Magic Grenade");
    SetItemCharges(info.oItem,1);
}

void PlaceGrenades(int n)
{
    int i;
    for(i = 0; i < n; i++) GenerateGrenade();
}



