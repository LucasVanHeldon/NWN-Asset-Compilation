int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iUnionState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q2_barrier");

    if (iUnionState == 10)
        return TRUE;

    return FALSE;
}
