int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iUnionState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q2_garfoss");

    if (iUnionState == 5)
        return TRUE;

    return FALSE;
}
