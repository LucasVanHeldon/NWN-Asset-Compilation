// Aberration Template
#include "x0_i0_spawncond"
#include "inc_ai"
#include "inc_ai"
#include "inc_magic"
#include "inc_mmpspells"
#include "inc_mmpspells2"
#include "inc_mmpcast"




int WATER_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    int nHD = GetHitDice(OBJECT_SELF);

    if(nHD > 20)
        if(d6() < 3)
        {
            MMP_HorridWilting(oTarget);
            return 1;
        }

    if(nHD > 11)
        if(d6() < 3)
        {
            MMP_AcidFog(oTarget);
            return 1;
        }

    if(nHD > 10)
        if(d6() < 3)
        {
            MMP_MestilsAcidBreath(oTarget);
            return 1;
        }


    if(nHD > 9)
        if(d6() < 3)
        {
            MMP_AuraCold(OBJECT_SELF);
            return 1;
        }

    if(nHD > 8)
        if(d6() < 3)
        {
            MMP_MestilsAcidSheath(OBJECT_SELF);
            return 1;
        }


    if(nHD > 7)
        if(d6() < 3)
        {
            MMP_Drown(oTarget);
            return 1;
        }

    if(nHD > 7)
        if(d6() < 3)
        {
            MMP_ConeOfAcid(oTarget);
            return 1;
        }

    if(nHD > 7)
        if(d6() < 3)
        {
            MMP_ConeOfCold(oTarget);
            return 1;
        }

    if(nHD > 7)
        if(d6() < 3)
        {
            MMP_PulseCold(oTarget);
            return 1;
        }

    if(nHD > 6)
        if(d6() < 3)
        {
            MMP_PulseDrown(oTarget);
            return 1;
        }

    if(nHD > 3)
        if(d6() < 3)
        {
            MMP_MephitSaltBreath(oTarget);
            return 1;
        }

    if(nHD > 3)
        if(d6() < 3)
        {
            MMP_MephitSteamBreath(oTarget);
            return 1;
        }

    if(nHD > 4)
        if(d6() < 3)
        {
            MMP_MelfsAcidArrow(oTarget);
            return 1;
        }


    if(nHD > 3)
        if(d6() < 3)
        {
            MMP_BoltAcid(oTarget);
            return 1;
        }

    if(nHD > 3)
        if(d6() < 3)
        {
            MMP_BoltCold(oTarget);
            return 1;
        }

    if(d6() < 3)
    {
        MMP_AcidSplash(oTarget);
        return 1;
    }
    return 0;

}

void main()
{
    int nPowers = GetLocalInt(OBJECT_SELF,"nPowers");

    if( nPowers < (GetHitDice(OBJECT_SELF)) && d6() < 3)
    {
        __TurnCombatRoundOn(TRUE);

        if(WATER_SpecialAttack()==1)
            SetLocalInt(OBJECT_SELF,"nPowers",nPowers+1);

        __TurnCombatRoundOn(FALSE);

    }


}
