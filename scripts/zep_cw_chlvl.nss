//::///////////////////////////////////////////////
//:: CEP Creature Wizard
//:: Community Expansion Pack
//:://////////////////////////////////////////////
/*
    Set level to be changed
*/
//:://////////////////////////////////////////////
//:: Created By:   420
//:: Created On:   April 20, 2009
//:://////////////////////////////////////////////

void main()
{
SetLocalString(OBJECT_SELF, "CW_Change", "level");
ExecuteScript("zep_cw_con_tlist", OBJECT_SELF);
}
