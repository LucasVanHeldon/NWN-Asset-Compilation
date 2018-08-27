//::///////////////////////////////////////////////
//:: FileName magic_rock_rand
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 26/08/2002 7:58:19 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Inspect local variables
	if(!(GetLocalInt(GetPCSpeaker(), "used_rock") == 0))
		return FALSE;

	// Add the randomness
	if(Random(20) >= 1)
		return FALSE;

	return TRUE;
}
