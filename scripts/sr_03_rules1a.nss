//::///////////////////////////////////////////////
//:: FileName sr_03_rules1a
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/22/2002 11:43:10 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "sr_03_rules") == 1 && FALSE))
    {

        return FALSE;
    }

    return TRUE;
}