int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iCallingState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q6_calling");

    if (iCallingState == 2)
        return TRUE;

    return FALSE;
}
