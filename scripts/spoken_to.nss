//::///////////////////////////////////////////////
//:: FileName spoken_to
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/19/2002 8:45:21 PM
//:://////////////////////////////////////////////
int StartingConditional()
{

    // Inspect local variables
    if(!(GetLocalInt(GetPCSpeaker(), "spoken_to") == 0))
        return FALSE;

    int bCondition = GetLocalInt(OBJECT_SELF,"NW_L_TALKTIMES") == 0;

    return bCondition;
}
