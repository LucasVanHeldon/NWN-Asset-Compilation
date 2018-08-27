//::///////////////////////////////////////////////
//:: FileName sr_ran10female
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/27/2002 10:44:45 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Add the gender restrictions
	if(GetGender(GetPCSpeaker()) != GENDER_FEMALE)
		return FALSE;

	// Add the randomness
	if(Random(100) >= 10)
		return FALSE;

	return TRUE;
}
