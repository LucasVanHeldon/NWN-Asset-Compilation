int StartingConditional()
{
    int iResult;

    iResult = (GetHasSpell(SPELL_AID, GetPCSpeaker()));
    return iResult;
}
