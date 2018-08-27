//::///////////////////////////////////////////////
//:: FileName sr_goodonly
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/25/2002 1:35:58 AM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Restrict based on the player's class
    int iPassed = 0;
    if(GetAlignmentGoodEvil(GetPCSpeaker()) == ALIGNMENT_GOOD)
        iPassed = 1;
    if(iPassed == 0)
        return FALSE;

    return TRUE;
}
