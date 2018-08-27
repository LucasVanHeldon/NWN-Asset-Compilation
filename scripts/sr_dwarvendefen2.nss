int StartingConditional()
{
    // Already has something in the creature item slot?
    if (GetIsObjectValid(GetItemInSlot(INVENTORY_SLOT_CARMOUR, GetPCSpeaker())))
        return FALSE;

    // Make sure the player has the required feats
    if(!GetHasFeat(FEAT_DODGE, GetPCSpeaker()))
        return FALSE;
    if(!GetHasFeat(FEAT_GREAT_FORTITUDE, GetPCSpeaker()))
        return FALSE;
    if(!GetHasFeat(FEAT_TOUGHNESS, GetPCSpeaker()))
        return FALSE;

    // Reject lower than 7 levels of warrior classes
    int iWarriors = GetLevelByClass(CLASS_TYPE_BARBARIAN, GetPCSpeaker()) +
            GetLevelByClass(CLASS_TYPE_FIGHTER, GetPCSpeaker()) +
            GetLevelByClass(CLASS_TYPE_PALADIN, GetPCSpeaker()) +
            GetLevelByClass(CLASS_TYPE_RANGER, GetPCSpeaker());
    if (iWarriors < 7)
        return FALSE;

    // Take Dwarves
    if(GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_DWARF)
        return TRUE;

    return FALSE;
}
