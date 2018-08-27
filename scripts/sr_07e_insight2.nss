//::///////////////////////////////////////////////
//:: FileName sr_07e_insight2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/23/2002 10:54:59 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

    // Perform skill checks
    if(!(AutoDC(DC_EASY, SKILL_PERSUADE, GetPCSpeaker())
            && GetAlignmentGoodEvil(GetPCSpeaker())== ALIGNMENT_GOOD))
        return FALSE;

    return TRUE;
}
