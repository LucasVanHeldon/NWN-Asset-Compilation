//::///////////////////////////////////////////////
//:: FileName sr_trielafia1
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/9/2002 8:33:49 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    if (GetAlignmentGoodEvil(GetPCSpeaker()) == ALIGNMENT_EVIL)
        return TRUE;

    return FALSE;
}
