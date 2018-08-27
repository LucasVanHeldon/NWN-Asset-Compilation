// Aberration Template
#include "inc_ai"
#include "inc_ai"
#include "inc_magic"
#include "inc_mmpspells"
#include "inc_mmpspells2"
#include "inc_mmpcast"

int EARTH_SpecialAttack(object oTarget = OBJECT_INVALID)
{

    int nHD = GetHitDice(OBJECT_SELF);


    if(nHD > 15)
        if(d6() < 3)
        {
            MMP_HorridWilting(oTarget);
            return 1;
        }


    if(nHD > 12)
        if(d6() < 3)
        {
            MMP_Bombardment(oTarget);
            return 1;
        }

    if(nHD > 10)
        if(d6() < 3)
        {
            MMP_Earthquake(oTarget);
            return 1;
        }

    if(nHD > 10)
        if(d6() < 3)
        {
            MMP_ElementalSwarm(oTarget);
            return 1;
        }

    if(nHD > 9)
        if(d6() < 3)
        {
            MMP_BreathPetrify(oTarget);
            return 1;
        }
    if(nHD > 9)
        if(d6() < 3)
        {
            MMP_GazePetrify(oTarget);
            return 1;
        }
    if(nHD > 8)
        if(d6() < 3)
        {
            MMP_NatureBalance(oTarget);
            return 1;
        }
    if(nHD > 3)
        if(d6() < 3)
        {
            MMP_Slow(oTarget);
            return 1;
        }

    if(nHD > 3)
        if(d6() < 3)
        {
            MMP_FleshToStone(oTarget);
            return 1;
        }

    if(nHD > 3)
        if(d6() < 3)
        {
            MMP_TouchPetrify(oTarget);
            return 1;
        }
    if(nHD > 3)
        if(d6() < 3)
        {
            MMP_BoltKnockdown(oTarget);
            return 1;
        }
    if(nHD > 3)
        if(d6() < 3)
        {
            MMP_BoltStun(oTarget);
            return 1;
        }
     if(nHD > 3)
        if(d6() < 3)
        {
            MMP_ElementalShield(OBJECT_SELF);
            return 1;
        }
    return 0;

}


void main()
{
     int nPowers = GetLocalInt(OBJECT_SELF,"nPowers");

    if( nPowers < (GetHitDice(OBJECT_SELF)))
    {
        __TurnCombatRoundOn(TRUE);
        if(EARTH_SpecialAttack()==1)
        {
            SetLocalInt(OBJECT_SELF,"nPowers",nPowers+1);
        }
        __TurnCombatRoundOn(TRUE);

    }

}
