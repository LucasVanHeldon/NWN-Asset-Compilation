// Aberration Template
#include "x0_i0_spawncond"
#include "inc_ai"
#include "inc_magic"
#include "inc_mmpspells"
#include "inc_mmpspells2"
#include "inc_mmpcast"
#include "inc_demons"


int HALFFIEND_SpecialAttack(object oTarget = OBJECT_INVALID)
{
    int nHD = GetHitDice(OBJECT_SELF);

    if(nHD > 20)
        if(d6() < 3)
        {
            MMP_Harm(oTarget);
            return 1;
        }
    if(nHD > 16)
        if(d6() < 3)
        {
            MMP_SummonIX(oTarget);
            return 1;
        }

    if(nHD > 14)
        if(d6() < 3)
        {
            MMP_HorridWilting(oTarget);
            return 1;
        }
    if(nHD > 11)
        if(d6() < 3)
        {
            MMP_BladeBarrier(oTarget);
            return 1;
        }

    if(nHD > 10)
        if(d6() < 3)
        {
            DEMON_Blasphemy();
            return 1;
        }
    if(nHD > 8)
        if(d6() < 3)
        {
            MMP_Contagion(oTarget);
            return 1;
        }
     if(nHD > 6)
        if(d6() < 3)
        {
            MMP_Poison(oTarget);
            return 1;
        }

    if(nHD > 5)
        if(d6() < 3)
        {
            MMP_BestowCurse(oTarget);
            return 1;
        }

    if(nHD > 5)
        if(d6() < 3)
        {
            DEMON_CastUnholyBlight();
            return 1;
        }
    if(nHD > 2)
        if(d6() < 3)
        {
            MMP_Doom(oTarget);
            return 1;
        }

    if(nHD > 2)
        if(d6() < 3)
        {
            MMP_Bane(oTarget);
            return 1;
        }

    if(nHD > 1)
        if(d6() < 3)
        {
            MMP_FeebleMind(oTarget);
            return 1;
        }
    if(nHD > 1)
        if(d6() < 3)
        {
            MMP_Darkness(oTarget);
            return 1;
        }


    return 0;

}



void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    int nPowers = GetLocalInt(OBJECT_SELF,"nPowers");

    // enter desired behaviour here
    switch(nCalledBy)
    {
    default:
        if(GetCurrentAction() == ACTION_CASTSPELL) break;
        if( nPowers < (GetHitDice(OBJECT_SELF)/3+1))
        {
            if(HALFFIEND_SpecialAttack()==1)
                SetLocalInt(OBJECT_SELF,"nPowers",nPowers+1);
        }

        break;
    }
}
