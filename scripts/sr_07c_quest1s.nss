int StartingConditional()
{

    object oPC = GetPCSpeaker();
    int iDubricusState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q4_dubricus");

    if (iDubricusState == 1)
        return TRUE;

    return FALSE;
}
