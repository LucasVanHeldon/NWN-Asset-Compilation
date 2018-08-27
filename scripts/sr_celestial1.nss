int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iCelestialState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q3_celestial");

    if (iCelestialState == 0)
        return TRUE;

    return FALSE;
}
