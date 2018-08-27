int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_OWLS_WISDOM, GetPCSpeaker()));
    return iResult;
}
