int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iBarrierState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q1_union");

    if (iBarrierState >= 8)
        return TRUE;

    return FALSE;
}
