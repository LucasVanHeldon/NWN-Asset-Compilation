int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_CURE_SERIOUS_WOUNDS, GetPCSpeaker()));
    return iResult;
}
