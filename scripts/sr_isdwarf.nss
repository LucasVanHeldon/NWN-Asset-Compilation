int StartingConditional()
{
    if(GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_DWARF)
        return TRUE;
    return FALSE;
}
