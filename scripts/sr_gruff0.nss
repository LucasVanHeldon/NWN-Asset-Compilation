//::///////////////////////////////////////////////
//:: FileName sr_gruff0
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/27/2002 11:48:06 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "grufftalk") == 0))
		return FALSE;

	return TRUE;
}