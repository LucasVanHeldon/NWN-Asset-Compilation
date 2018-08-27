int IsGood(struct sEnchantments enchants)
{
        if(enchants.iAlign == EVIL
            || enchants.iSAlign == IP_CONST_ALIGNMENT_CE
            || enchants.iSAlign == IP_CONST_ALIGNMENT_NE
            || enchants.iSAlign == IP_CONST_ALIGNMENT_LE) return TRUE;

        return FALSE;
}

int IsEvil(struct sEnchantments enchants)
{
        if(enchants.iAlign == GOOD
            || enchants.iSAlign == IP_CONST_ALIGNMENT_CG
            || enchants.iSAlign == IP_CONST_ALIGNMENT_NG
            || enchants.iSAlign == IP_CONST_ALIGNMENT_LG) return TRUE;

        return FALSE;
}

int PickAlignment(int iAlignment)
{
    if(iAlignment == EVIL)
    {
        int d = d3();
        if(d == 1) return IP_CONST_ALIGNMENT_CE;
        if(d == 2) return IP_CONST_ALIGNMENT_NE;
        if(d == 3) return IP_CONST_ALIGNMENT_LE;
    }
    if(iAlignment == GOOD)
    {
        int d = d3();
        if(d == 1) return IP_CONST_ALIGNMENT_CG;
        if(d == 2) return IP_CONST_ALIGNMENT_NG;
        if(d == 3) return IP_CONST_ALIGNMENT_LG;
    }
    if(iAlignment == LAW)
    {
        int d = d3();
        if(d == 1) return IP_CONST_ALIGNMENT_LG;
        if(d == 2) return IP_CONST_ALIGNMENT_LN;
        if(d == 3) return IP_CONST_ALIGNMENT_LE;
    }
    if(iAlignment == CHAOS)
    {
        int d = d3();
        if(d == 1) return IP_CONST_ALIGNMENT_CG;
        if(d == 2) return IP_CONST_ALIGNMENT_CN;
        if(d == 3) return IP_CONST_ALIGNMENT_CE;
    }
    return Random(9);
}

int PickRace(int iAlignment)
{
    if(bBiasGood)
    {
        // push towards monsters
        int sr = Random(17)+9;
        return sr;
    }
    else return Random(26);
}

int ClericRace(int iAlignment)
{
    // if it hates evil, strong chance against undead and outsiders
    if(iAlignment == EVIL)
    {
        if(d20() < 10)
            return IP_CONST_RACIALTYPE_UNDEAD;
        if(d20() < 10)
            return IP_CONST_RACIALTYPE_OUTSIDER;
    }
    return -1;
}

int IsClericWeapon(struct sItemInfo info)
{
    if(info.wType == WEAPON_BLUNT) return TRUE;
    return FALSE;
}


