int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iUnionState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q1_union");

    if (iUnionState == 9)
        return TRUE;

    return FALSE;
}
