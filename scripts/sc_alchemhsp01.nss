int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_BARKSKIN, GetPCSpeaker()));
    return iResult;
}
