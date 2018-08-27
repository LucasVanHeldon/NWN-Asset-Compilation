//::///////////////////////////////////////////////
//:: FileName sr_lorack_hasp8
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/9/2002 1:31:23 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "coc_q1_plot8"))
		return FALSE;

	return TRUE;
}
