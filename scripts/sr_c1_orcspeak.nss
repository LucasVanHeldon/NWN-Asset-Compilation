//::///////////////////////////////////////////////
//:: FileName sr_c1_orcspeak
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/7/2002 8:18:46 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    if((GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE) > 13))
        return TRUE;

    // Reject player races
    if(GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_DWARF)
        return TRUE;
    if(GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_GNOME)
        return TRUE;
    if(GetRacialType(GetPCSpeaker()) == RACIAL_TYPE_HALFORC)
        return TRUE;

    return FALSE;
}
