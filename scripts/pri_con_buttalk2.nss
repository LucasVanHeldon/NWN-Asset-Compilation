//::///////////////////////////////////////////////
//:: Check to see if speaker isn't the Renter
//:: pri_con_buttalk2
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
    if(!(GetLocalInt(GetPCSpeaker(), "RSA_BoughtSuite") < 1))
        return FALSE;

    return TRUE;
}
