int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iSabineState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYSabinesLoss");

    if (iSabineState < 10)
        return TRUE;

    return FALSE;
}
