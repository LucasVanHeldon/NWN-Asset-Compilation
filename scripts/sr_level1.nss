//::///////////////////////////////////////////////
//:: FileName sr_level2plus
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/2/2002 5:46:10 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetHitDice(GetPCSpeaker()) < 2)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
