//::///////////////////////////////////////////////
//:: Checks to see if Player is the Renter
//:: pri_con_butrent
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
    if(!(GetLocalInt(GetPCSpeaker(), "RSA_BoughtSuite") > 0))
        return FALSE;

    return TRUE;
}
