//::///////////////////////////////////////////////
//:: FileName sr_hasironkey
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/22/2002 2:24:27 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "h9_key"))
		return FALSE;

	return TRUE;
}
