//::///////////////////////////////////////////////
//:: FileName sr_after8am
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/23/2002 7:39:47 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "GetLocalHour()") > 8))
		return FALSE;

	return TRUE;
}
