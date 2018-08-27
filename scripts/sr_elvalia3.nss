int StartingConditional()
{
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE) > 11))
        return FALSE;

    return TRUE;
}
