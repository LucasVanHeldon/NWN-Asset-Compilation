//::///////////////////////////////////////////////
//:: Checks to see if player has invited guests over
//:: pri_con_butslpov
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

    if(GetLocalInt(OBJECT_SELF, "RSA_Guests") > 0 && GetLocalInt(OBJECT_SELF, "RSA_SleepOver") > 0
        && GetLocalInt(OBJECT_SELF, "RSA_HadSleepOver") == 0)
        return TRUE;

    return FALSE;
}
