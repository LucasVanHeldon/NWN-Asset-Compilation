int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iGarfossState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q2_garfoss");

    if (iGarfossState == 5)
        return TRUE;

    return FALSE;
}
