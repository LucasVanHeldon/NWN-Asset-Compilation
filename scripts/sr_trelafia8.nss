//::///////////////////////////////////////////////
//:: FileName sr_trelafia8
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/9/2002 9:16:33 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    // Look for Dead PCs
    object oPC = GetFirstFactionMember(GetPCSpeaker());
    object oHalls = GetObjectByTag("HallsGuardian");

    while (GetIsObjectValid(oPC)) {
        if (GetArea(oPC) == GetArea(oHalls))
            return TRUE;
        oPC = GetNextFactionMember(GetPCSpeaker());
    }

    return FALSE;
}
