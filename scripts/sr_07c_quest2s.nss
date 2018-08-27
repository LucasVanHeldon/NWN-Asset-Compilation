#include "nw_i0_plot"
int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iDubricusState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q4_dubricus");

    if (iDubricusState == 2 || HasItem(GetPCSpeaker(), "HobGobChiefHead"))
        return TRUE;

    return FALSE;
}
