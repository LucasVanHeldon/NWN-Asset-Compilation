int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iPrisonersState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcaveh_prisoners");

    if (iPrisonersState == 3)
        return TRUE;

    return FALSE;
}
