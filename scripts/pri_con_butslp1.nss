//::///////////////////////////////////////////////
//:: Checks to see how many guests allowed in suite
//:: pri_con_butslp1
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 1, 2002
//:://////////////////////////////////////////////

#include "pri_inc"

int StartingConditional()
{
    GetInnArea(OBJECT_SELF);

    if(GetLocalInt(OBJECT_SELF, "RSA_SleepOver") > 0)
        return TRUE;

    return FALSE;
}
