int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_ENDURANCE, GetPCSpeaker()));
    return iResult;
}
