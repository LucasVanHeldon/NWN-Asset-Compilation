int StartingConditional()
{
    object oPC = GetPCSpeaker();
    int iCelestialState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q3_celestial");

    if (iCelestialState == 2)
        return TRUE;

    return FALSE;
}
