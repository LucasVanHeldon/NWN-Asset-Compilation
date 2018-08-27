//::///////////////////////////////////////////////
//:: FileName sr_trielafia11
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/11/2002 8:54:13 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

int StartingConditional()
{

	// Make sure the PC speaker has these items in their inventory
	if(!CheckPartyForItem(GetPCSpeaker(), "PollenMarshRose"))
		return FALSE;
	if(!CheckPartyForItem(GetPCSpeaker(), "SprigMistletoe"))
		return FALSE;

	return TRUE;
}
