//::///////////////////////////////////////////////
//:: FileName at_013
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/2/2004 9:51:50 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker some XP
    RewardPartyXP(100, GetPCSpeaker());

    object oPC = GetPCSpeaker();

    object oTarget;
    oTarget = OBJECT_SELF;

    DestroyObject(oTarget, 0.0);

}
