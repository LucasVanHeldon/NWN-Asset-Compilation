int StartingConditional()
{

    object oPC = GetPCSpeaker();
    int iDubricusState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q4_dubricus");

    if (iDubricusState == 0)
        return TRUE;

    return FALSE;
}
