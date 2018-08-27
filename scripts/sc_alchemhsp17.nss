int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_LEGEND_LORE, GetPCSpeaker()) || GetHasSpell(SPELL_IDENTIFY, GetPCSpeaker()));
    return iResult;
}
