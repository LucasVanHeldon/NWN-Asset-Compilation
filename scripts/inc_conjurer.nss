void CONJURER_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    switch(d12())
    {
    case 1: MMP_BalagornsIronHorn(oTarget); break;
    case 2: MMP_BlindnessDeafness(oTarget); break;
    case 3: MMP_CloudOfBewilderment(oTarget); break;
    case 4: MMP_Combust(oTarget); break;
    case 5: MMP_Darkness(oTarget); break;
    case 6: MMP_GedleesElectricLoop(oTarget); break;
    case 7: MMP_MelfsAcidArrow(oTarget); break;
    case 8: MMP_TashasHideousLaughter(oTarget); break;
    case 9: MMP_Web(oTarget); break;
    default:
        EVOKER_SpecialAttack();
    }


}

