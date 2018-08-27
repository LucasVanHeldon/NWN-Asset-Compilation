//::///////////////////////////////////////////////
//:: Checks to see if player has guests but door is open
//:: pri_con_butlock
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
    if(!(GetLocalInt(OBJECT_SELF, "RSA_Guests") == 1))
        return FALSE;

    return TRUE;
}
