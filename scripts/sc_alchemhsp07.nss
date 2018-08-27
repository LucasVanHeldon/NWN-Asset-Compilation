int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_CURE_LIGHT_WOUNDS, GetPCSpeaker()));
    return iResult;
}
