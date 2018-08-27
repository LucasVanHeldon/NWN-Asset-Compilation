int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_BLESS, GetPCSpeaker()));
    return iResult;
}
