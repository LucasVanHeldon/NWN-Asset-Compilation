int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iSilksState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q5_silks");

    if (iSilksState == 2 || iSilksState == 1)
        return TRUE;

    return FALSE;
}
