//::///////////////////////////////////////////////
//:: FileName sr_startauto
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/19/2002 7:50:36 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Add the gender restrictions
	if(GetGender(GetPCSpeaker()) != GENDER_BOTH)
		return FALSE;

	return TRUE;
}
