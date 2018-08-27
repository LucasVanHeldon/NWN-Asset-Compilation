void PRESTIGATOR_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    int nDice = d6();
    switch(nDice)
    {
    case 1: MMP_AcidSplash(oTarget); break;
    case 2: MMP_Daze(oTarget); break;
    case 3: MMP_Flare(oTarget); break;
    case 4: MMP_ElectricJolt(oTarget); break;
    case 5:
    default:
        MMP_RayOfFrost(oTarget); break;
    }
}

void PRESTIGATOR_SpecialDmg(object oTarget = OBJECT_INVALID)
{
    int nDice = d4();
    switch(nDice)
    {
    case 1: MMP_AcidSplash(oTarget); break;
    case 2: MMP_Flare(oTarget); break;
    case 3: MMP_ElectricJolt(oTarget); break;
    case 4: MMP_RayOfFrost(oTarget); break;
    }
}

int IsActive(object oC)
{
    if(GetHasEffect(EFFECT_TYPE_DAZED,oC)) return 0;
    if(GetHasEffect(EFFECT_TYPE_SLEEP,oC)) return 0;
    if(GetHasEffect(EFFECT_TYPE_CHARMED,oC)) return 0;
    if(GetHasEffect(EFFECT_TYPE_CONFUSED,oC)) return 0;
    if(GetHasEffect(EFFECT_TYPE_FRIGHTENED,oC)) return 0;

    return 1;
}

