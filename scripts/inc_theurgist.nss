void THEURGIST_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    switch(d12())
    {
    case 1: MMP_Fireball(oTarget); break;
    case 2: MMP_FlameArrow(oTarget); break;
    case 3: MMP_HoldPerson(oTarget); break;
    case 4: MMP_LightningBolt(oTarget); break;
    case 5: MMP_MestilsAcidBreath(oTarget); break;
    case 6: MMP_NegativeEnergyBurst(oTarget); break;
    case 7: MMP_Slow(oTarget); break;
    case 8: MMP_StinkingCloud(oTarget); break;
    case 9: MMP_VampiricTouch(oTarget); break;
    default: CONJURER_SpecialAttack(oTarget); break;
    }
}

