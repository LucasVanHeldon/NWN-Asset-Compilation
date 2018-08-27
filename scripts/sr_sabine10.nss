int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iUnionState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q1_union");
    int iBarrierState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q2_barrier");

    if ((iUnionState == 8 || iUnionState == 9) && iBarrierState == 0)
        return TRUE;

    return FALSE;
}
