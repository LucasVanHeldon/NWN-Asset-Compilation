//::///////////////////////////////////////////////
//:: Beholder Ray Attacks
//:: x2_s2_beholdray
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Implementation for the new version of the
    beholder rays, using projectiles instead of
    rays
*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-09-16
//:://////////////////////////////////////////////
// Modified by dirtywick and Tony K for NWN2 2008-04-06
// Modified by Tony K for NWN1 2008-07-22

#include "x0_i0_spells"

#include "x2_inc_beholder"

void main()
{
    int     nSpell = GetSpellId();
    object  oTarget = GetSpellTargetObject();

    int nRay;

    switch (nSpell)
    {
        case 776:
            nRay = BEHOLDER_RAY_DEATH;
            break;

        case 777:
            nRay = BEHOLDER_RAY_TK_THRUST;
            break;

        case 778:
            nRay = BEHOLDER_RAY_PETRI;
            break;

        case 779:
            nRay = BEHOLDER_RAY_CHARM_MON;
            break;

        case 780:
            nRay = BEHOLDER_RAY_SLOW;
            break;

        case 783:
            nRay = BEHOLDER_RAY_WOUND;
            break;

        case 784:
            nRay = BEHOLDER_RAY_FEAR;
            break;

        case 785:
            nRay = BEHOLDER_RAY_CHARM_PER;
            break;

        case 786:
            nRay = BEHOLDER_RAY_SLEEP;
            break;

        case 787:
            nRay = BEHOLDER_RAY_DISINTEGRATE;
            break;
    }

    DoBeholderRayAttack(nRay, oTarget, FALSE);
}