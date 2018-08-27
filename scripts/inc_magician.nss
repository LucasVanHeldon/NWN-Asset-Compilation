void MAGICIAN_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    __TurnCombatRoundOn(TRUE);

    switch(d8(2))
    {
    case 1: MMP_BestowCurse(oTarget); break;
    case 2: MMP_CharmMonster(oTarget); break;
    case 3: MMP_Confusion(oTarget); break;
    case 4: MMP_Contagion(oTarget); break;
    case 5: MMP_Enervation(oTarget); break;
    case 6: MMP_EvardsBlackTentacles(oTarget); break;
    case 7: MMP_Fear(oTarget); break;
    case 8: MMP_IceStorm(oTarget); break;
    case 9: MMP_IsaacsLesserMissileStorm(oTarget); break;
    case 10: MMP_PhantasmalKiller(oTarget); break;
    case 11: MMP_WallOfFire(oTarget); break;
    default: THEURGIST_SpecialAttack(oTarget); break;
    }
    __TurnCombatRoundOn(FALSE);

}


