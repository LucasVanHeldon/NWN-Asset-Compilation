//::///////////////////////////////////////////////
//:: FileName np_slime_torch
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 23/08/2002 4:39:08 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "NW_IT_TORCH001"))
		return FALSE;

	return TRUE;
}
