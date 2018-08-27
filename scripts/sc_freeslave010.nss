//::///////////////////////////////////////////////
//:: FileName sc_freeslave010
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 1/18/03 10:46:38 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "SlaveKey"))
		return FALSE;

	return TRUE;
}
