//::///////////////////////////////////////////////
//:: General Treasure Spawn Script   HIGH
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Spawns in general purpose treasure, usable
    by all classes.
*/
//:://////////////////////////////////////////////
//:: Created By:   Brent
//:: Created On:   February 26 2001
//:://////////////////////////////////////////////
#include "NW_O2_CONINCLUDE"
#include "inc_treasure"


void Reset(object o)
{
    SetLocalInt(o,"NW_DO_ONCE",0);
    DelayCommand(1000.0,Reset(o));
}

void main()

{
    if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
       return;
    }
    object oLastOpener = GetLastOpener();
    GenerateHighTreasure(oLastOpener, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
    TRS_GenerateHigh();
    DelayCommand(1000.0,Reset(OBJECT_SELF));
    ShoutDisturbed();
}
