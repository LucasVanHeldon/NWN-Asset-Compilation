//::///////////////////////////////////////////////
//:: Checks to see if Player has told all guests to leave
//:: pri_con_butleave
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 1, 2002
//:://////////////////////////////////////////////

int StartingConditional()
{
    if(!(GetLocalInt(OBJECT_SELF, "RSA_Guests") == 3))
        return FALSE;

    return TRUE;
}
