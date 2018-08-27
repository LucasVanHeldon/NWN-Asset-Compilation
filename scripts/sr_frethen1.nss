int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iBarrierState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q2_barrier");

    if (iBarrierState == 11)
        return TRUE;

    return FALSE;
}
