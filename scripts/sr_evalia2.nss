int StartingConditional()
{
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_CHARISMA) > 13))
        return FALSE;

    return TRUE;
}
