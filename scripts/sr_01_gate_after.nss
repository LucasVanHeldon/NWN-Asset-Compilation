//::///////////////////////////////////////////////
//:: FileName sr_01_gate_after
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/22/2002 11:38:48 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "sr_01_gatetaken") > 0))
		return FALSE;

	return TRUE;
}