int StartingConditional()
{
    int iChance = 3 + GetHitDice(GetPCSpeaker());
    if (GetLevelByClass(CLASS_TYPE_CLERIC, GetPCSpeaker()))
        iChance += GetHitDice(GetPCSpeaker());

    // Add the randomness
    if(Random(100) >= iChance)
        return FALSE;

    return TRUE;
}
