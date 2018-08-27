int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iBearState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q6_bear");

    if (iBearState == 2)
        return TRUE;

    return FALSE;
}
