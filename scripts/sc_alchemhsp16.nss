int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_LESSER_RESTORATION, GetPCSpeaker()));
    return iResult;
}
