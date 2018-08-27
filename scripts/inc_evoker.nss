void EVOKER_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    int nDice = d12();
    SendMessageToPC(GetFirstPC(),"Evoker Special");
    switch(nDice)
    {
    case 1: MMP_BurningHands(oTarget); break;
    case 2: MMP_CharmPerson(oTarget); break;
    case 3: MMP_ColorSpray(oTarget); break;
    case 4: MMP_Grease(oTarget); break;
    case 5: MMP_Boom(oTarget); break;
    case 6: MMP_IceDagger(oTarget); break;
    case 7: MMP_MagicMissile(oTarget); break;
    case 8: MMP_NegativeEnergyRay(oTarget); break;
    case 9: MMP_RayOfEnfeeblement(oTarget); break;
    case 10: MMP_Sleep(oTarget); break;
    default:
        PRESTIGATOR_SpecialAttack(oTarget); break;
    }
}

void EVOKER_SpecialDmg(object oTarget = OBJECT_INVALID)
{
    int nDice = d10();
    switch(nDice)
    {
    case 1: MMP_BurningHands(oTarget); break;
    case 2: MMP_Grease(oTarget); break;
    case 3: MMP_Boom(oTarget); break;
    case 4: MMP_IceDagger(oTarget); break;
    case 5: MMP_MagicMissile(oTarget); break;
    case 6: MMP_NegativeEnergyRay(oTarget); break;
    case 7: MMP_RayOfEnfeeblement(oTarget); break;
    case 8: MMP_Sleep(oTarget); break;
    default: PRESTIGATOR_SpecialDmg(oTarget); break;
    }
}



