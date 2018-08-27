int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iJessState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q1_jess");

    if (iJessState == 8)
        return TRUE;

    return FALSE;
}
