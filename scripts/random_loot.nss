//::///////////////////////////////////////////////
//:: XP2 General Treasure Spawn Script
//:: Copyright (c) 2003 Bioware Corp.
//:: FileNameNew: "treasure_chest"
//:://////////////////////////////////////////////
/*
    Spawns in general purpose treasure and gold
    usable by all classes.
    ***Now is truly "random" in treasure generation, yet still uses
    the default treasure scripts... change the OnDeath, and OnOpened,
    of your treasure-container, to this script!
*/
//:://////////////////////////////////////////////
//:: Created By:   Georg Zoeller
//:: Created On:   2003-06-04
//:: Modified By:  Karmana
//:: Modified On:  01MAR05
//:://////////////////////////////////////////////
#include "x2_inc_treasure"
#include "nw_o2_coninclude"
#include "x2_inc_compon"
void main()
{
    if(d6()==1) ExecuteScript("nw_o2_generalhig",OBJECT_SELF);
    else ExecuteScript("nw_o2_generalmed",OBJECT_SELF);
}
