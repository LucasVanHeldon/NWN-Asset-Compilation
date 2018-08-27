int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_HEAL, GetPCSpeaker()));
    return iResult;
}
