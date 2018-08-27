//::///////////////////////////////////////////////
//:: Checks to see if player has not invited guests yet
//:: pri_con_butguest
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
    if(!(GetLocalInt(OBJECT_SELF, "RSA_Guests") < 1))
        return FALSE;

    return TRUE;
}
