//::///////////////////////////////////////////////
//:: FileName sc_sly
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/20/2003 10:24:25 PM
//:://////////////////////////////////////////////
int StartingConditional()
{
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_INTELLIGENCE) == 12))
        return FALSE;
    if(!(GetAbilityScore(GetPCSpeaker(), ABILITY_CHARISMA) == 15))
        return FALSE;

    // Make sure the player has the required skills
    if(!GetHasSkill(SKILL_PERSUADE, GetPCSpeaker()))
        return FALSE;

    return TRUE;
}
