//::///////////////////////////////////////////////
//:: FileName sc_persuade_med
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/16/2003 9:15:48 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Perform skill checks
	if(!(AutoDC(DC_EASY, SKILL_PERSUADE, GetPCSpeaker())))
		return FALSE;

	// Add the randomness
	if(Random(100) >= 25)
		return FALSE;

	return TRUE;
}
