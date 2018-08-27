int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_INVISIBILITY, GetPCSpeaker()));
    return iResult;
}
