int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_CATS_GRACE, GetPCSpeaker()));
    return iResult;
}
