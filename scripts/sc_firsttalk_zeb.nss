//::///////////////////////////////////////////////
//:: FileName sc_firsttalk_zeb
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 11/21/2004 5:22:07 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "zebtalk") == 0))
		return FALSE;

	return TRUE;
}
