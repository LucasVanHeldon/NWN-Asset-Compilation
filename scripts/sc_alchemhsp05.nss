int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_CLARITY, GetPCSpeaker()));
    return iResult;
}
