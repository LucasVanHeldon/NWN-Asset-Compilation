int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_HASTE, GetPCSpeaker()));
    return iResult;
}
