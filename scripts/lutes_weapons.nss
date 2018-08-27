// additional weapons (custom)
// exotic weapons
// double-sided
// other weapons not yet added

struct sItemInfo DaggerBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WSWDG001";
    wi.sName     ="Dagger";
    wi.wType     = WEAPON_DAGGER;
    return wi;
}

struct sItemInfo ShortSwordBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WSWSS001";
    wi.sName = "Short Sword";
    wi.wType = WEAPON_SLASH;
    return wi;
}

struct sItemInfo LongSwordBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WSWLS001";
    wi.sName = "Long Sword";
    wi.wType = WEAPON_SLASH;
    return wi;
}

struct sItemInfo GreatSwordBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WSWGS001";
    wi.sName = "Great Sword";
    wi.wType = WEAPON_SLASH;
    return wi;

}

struct sItemInfo BastardSwordBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WSWBS001";
    wi.sName = "Bastard Sword";
    wi.wType = WEAPON_SLASH;
    return wi;

}

struct sItemInfo HandAxeBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="lutes_haxe";
    wi.sName = "Hand Axe";
    wi.wType = WEAPON_SLASH;
    return wi;

}

struct sItemInfo BattleAxeBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WAXBT001";
    wi.sName = "Battle Axe";
    wi.wType = WEAPON_SLASH;
    return wi;

}

struct sItemInfo DwarvenAxeBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="X2_WDWRAXE001";
    wi.sName = "Dwarven Axe";
    wi.wType = WEAPON_SLASH;
    return wi;

}

struct sItemInfo GreatAxeBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WAXGR001";
    wi.sName = "Great Axe";
    wi.wType = WEAPON_SLASH;
    return wi;

}

struct sItemInfo MaceBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WBLML001";
    wi.sName = "Mace";
    wi.wType = WEAPON_BLUNT;
    return wi;

}

struct sItemInfo MorningStarBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WBLMS001";
    wi.sName = "Morning Star";
    wi.wType = WEAPON_BLUNT;

    return wi;


}

struct sItemInfo ClubBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WBLCL001";
    wi.sName = "Club";
    wi.wType = WEAPON_BLUNT;

    return wi;

}


struct sItemInfo LightHammerBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WBLHL001";
    wi.sName = "Light Hammer";
    wi.wType = WEAPON_BLUNT;

    return wi;

}


struct sItemInfo WarHammerBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WBLHW001";
    wi.sName = "War Hammer";
    wi.wType = WEAPON_BLUNT;

    return wi;
}


struct sItemInfo LightFlailBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WBLLF001";
    wi.sName = "Light Flail";
    wi.wType = WEAPON_BLUNT;

    return wi;

}

struct sItemInfo HeavyFlailBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WBLHF001";
    wi.sName = "Heavy Flail";
    wi.wType = WEAPON_BLUNT;

    return wi;
}


struct sItemInfo HalberdBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WPLHB001";
    wi.sName = "Halberd";
    wi.wType = WEAPON_SLASH;

    return wi;

}


struct sItemInfo SpearBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WPLSS001";
    wi.sName = "Spear";
    wi.wType = WEAPON_PIERCE;
    return wi;
}

struct sItemInfo ScytheBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="NW_WPLSC001";
    wi.sName = "Scythe";
    wi.wType = WEAPON_SLASH;

    return wi;

}

struct sItemInfo TridentBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="nw_wpltr001";
    wi.sName = "Trident";
    wi.wType = WEAPON_SLASH;

    return wi;
}

struct sItemInfo FlachionBP()
{
    struct sItemInfo wi;
    wi.sBluePrint= d4() < 3? "falchion":"flachion001";
    wi.sName = "Falchion";
    wi.wType = WEAPON_SLASH;

    return wi;
}

struct sItemInfo DartBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="dart";
    wi.sName = "Dart";
    wi.wType = WEAPON_PIERCE;

    return wi;
}

struct sItemInfo GoadBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="goad";
    wi.sName = "Goad";
    wi.wType = WEAPON_PIERCE;

    return wi;
}

struct sItemInfo HeavyMaceBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="heavymace";
    wi.sName = "Heavy Mace";
    wi.wType = WEAPON_BLUNT;

    return wi;
}


struct sItemInfo KatarBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="katar";
    wi.sName = "Katar";
    wi.wType = WEAPON_SLASH;

    return wi;
}

struct sItemInfo KukriBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="kukri";
    wi.sName = "Kukri";
    wi.wType = WEAPON_SLASH;

    return wi;
}

struct sItemInfo LightPickBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="lightpick";
    wi.sName = "Light Pick";
    wi.wType = WEAPON_PIERCE;

    return wi;
}

struct sItemInfo MaulBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="maul";
    wi.sName = "Maul";
    wi.wType = WEAPON_PIERCE;

    return wi;
}

struct sItemInfo Mace2BP()
{
    struct sItemInfo wi;
    wi.sBluePrint="mace";
    wi.sName = "mace";
    wi.wType = WEAPON_BLUNT;

    return wi;
}

struct sItemInfo MercGreatSwordBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="mercurialgreatsw";
    wi.sName = "Mercurial Greatsword";
    wi.wType = WEAPON_SLASH;

    return wi;
}

struct sItemInfo MercLongSwordBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="mercuriallongswo";
    wi.sName = "Mercurial Longsword";
    wi.wType = WEAPON_SLASH;

    return wi;
}

struct sItemInfo NunchakuBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="nunchaku";
    wi.sName = "Nunchaku";
    wi.wType = WEAPON_BLUNT;

    return wi;
}


struct sItemInfo SaiBP()
{
    struct sItemInfo wi;
    wi.sBluePrint="sai";
    wi.sName = "Sai";
    wi.wType = WEAPON_BLUNT;

    return wi;
}


struct sItemInfo OtherBP()
{
    struct sItemInfo wi;
    switch(Random(11))
    {
    case 0: wi.sBluePrint="NW_WDBMA001";
            wi.sName = "Dire Mace";
            wi.wType = WEAPON_BLUNT;
            break;
    case 1: wi.sBluePrint="NW_WDBAX001";
            wi.sName = "Double Axe";
            wi.wType = WEAPON_SLASH;
            break;
    case 2: wi.sBluePrint="NW_WDBQS001";
            wi.sName = "Quarterstaff";
            wi.wType = WEAPON_BLUNT;
            break;
    case 3: wi.sBluePrint="NW_WDBSW001";
            wi.sName = "Two Bladed Sword";
            wi.wType = WEAPON_SLASH;
            break;

    case 4: wi.sBluePrint="NW_WSPKA001";
            wi.sName = "Kama";
            wi.wType = WEAPON_SLASH;
            break;

    case 5: wi.sBluePrint="NW_WSPKU001";
            wi.sName = "Kukri";
            wi.wType = WEAPON_SLASH;
            break;

    case 6: wi.sBluePrint="NW_WSPSC001";
            wi.sName = "Sickle";
            wi.wType = WEAPON_SLASH;
            break;

    case 7: wi.sBluePrint="X2_IT_WPWHIP";
            wi.sName = "Whip";
            wi.wType = WEAPON_SLASH;
            break;

    case 8: wi.sBluePrint="NW_WPLHB001";
            wi.sName = "Halberd";
            wi.wType = WEAPON_SLASH;
            break;


    case 9: wi.sBluePrint="NW_WPLSC001";
            wi.sName = "Scythe";
            wi.wType = WEAPON_SLASH;
            break;

    case 10: wi.sBluePrint="NW_WPLSS001";
            wi.sName = "Spear";
            wi.wType = WEAPON_PIERCE;
            break;

    case 11: wi.sBluePrint="nw_wpltr001";
            wi.sName = "Trident";
            wi.wType = WEAPON_PIERCE;
            break;
    }
    return wi;
}

struct sItemInfo GenerateSword()
{
    int iRoll = d12();
    switch(iRoll)
    {
    case 1: { return ShortSwordBP(); }
    case 2: { return LongSwordBP(); }
    case 3: { return GreatSwordBP(); }
    case 4: { return BastardSwordBP(); }
    case 5: { return FlachionBP(); }
    case 6: { return MercGreatSwordBP(); }
    case 7: { return MercLongSwordBP(); }
    case 8: { return KukriBP(); }
    case 9: { return KatarBP(); }
    case 10: { return SaiBP(); }
    default: return OtherBP();
    }
    return LongSwordBP();
}

struct sItemInfo GenerateDagger()
{
    return DaggerBP();
}


struct sItemInfo GenerateAxe()
{
    int iRoll = d4();
    switch(iRoll)
    {
    case 1: { return HandAxeBP(); }
    case 2: { return BattleAxeBP(); }
    case 3: { return GreatAxeBP(); }
    case 4: { return LightPickBP(); }
    }
    return LongSwordBP();
}

struct sItemInfo GenerateBluntWeapon()
{
    int iRoll = d10();
    switch(iRoll)
    {
    case 1: { return ClubBP(); }
    case 2: { return MaceBP(); }
    case 3: { return LightFlailBP(); }
    case 4: { return HeavyFlailBP(); }
    case 5: { return LightHammerBP(); }
    case 6: { return WarHammerBP(); }
    case 7: { return Mace2BP(); }
    case 8: { return MaulBP(); }
    case 9: { return NunchakuBP(); }
    case 10: { return HeavyMaceBP(); }
    }

    return LongSwordBP();
}

struct sItemInfo GeneratePoleArm()
{
    int iRoll = d4();
    switch(iRoll)
    {
    case 1: { return SpearBP();   }
    case 2: { return HalberdBP(); }
    case 3: { return TridentBP(); }
    case 4: { return GoadBP(); }
    }
    return LongSwordBP();
}


void GenerateMeleeWeapon(int type = -1);


/*
 * Create<item> - Creates a standard game item
 * Generate<item> - Generates a unique item
 */
void CreateWeapon(int num, int type=-1)
{
    int i;
    for(i = 0; i < num; i++)
    {
        GenerateMeleeWeapon(type);
    }

}

// These functions chose from standard or generated (or custom)
// for now it just generates items
void PlaceWeapon(int num)
{
    int i;
    for(i = 0; i < num; i++)
        GenerateMeleeWeapon();
}



