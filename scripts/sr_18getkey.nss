//::///////////////////////////////////////////////
//:: FileName sr_18getkey
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/10/2002 12:18:51 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

	// Restrict based on the player's class
	int iPassed = 0;
	if(GetHitDice(GetPCSpeaker()) >= 3)
		iPassed = 1;
	if(iPassed == 0)
		return FALSE;

	return TRUE;
}
