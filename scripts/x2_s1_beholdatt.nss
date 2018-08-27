//::///////////////////////////////////////////////
//:: x2_s1_beholdatt
//:: Beholder Attack Spell Logic
//:: Copyright (c) 2003 Bioware Corp.
//:://////////////////////////////////////////////
/*

    This spellscript is the core of the beholder's
    attack logic.

*/
//:://////////////////////////////////////////////
//:: Created By: Georg Zoeller
//:: Created On: 2003-08-28
//:://////////////////////////////////////////////
// Modified by Tony K for NWN2 2008-05-18 - only left
// for backward compatability
// Modified by Tony K for NWN1 2008-07-22


#include "x2_inc_behai"


void main()
{
//  Jug_Debug(GetName(OBJECT_SELF) + " running special beholder ray AI");
    object oTarget = GetSpellTargetObject();

    RunBeholderEyeAttacks(oTarget, TRUE);
}