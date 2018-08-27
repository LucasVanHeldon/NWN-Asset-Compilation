int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_CURE_MODERATE_WOUNDS, GetPCSpeaker()));
    return iResult;
}
