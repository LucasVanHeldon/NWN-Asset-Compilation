int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_CURE_CRITICAL_WOUNDS, GetPCSpeaker()));
    return iResult;
}
