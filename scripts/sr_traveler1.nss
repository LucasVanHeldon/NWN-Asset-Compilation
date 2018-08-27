int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iSilksState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q5_silks");

    if (iSilksState == 0)
        return TRUE;

    return FALSE;
}
