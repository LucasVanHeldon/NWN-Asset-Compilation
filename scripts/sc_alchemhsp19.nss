int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_STONESKIN, GetPCSpeaker()));
    return iResult;
}
