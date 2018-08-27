//::///////////////////////////////////////////////
//:: Checks to see if has Guests and Door Locked
//:: pri_con_butopen
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 2, 2002
//:://////////////////////////////////////////////

int StartingConditional()
{

    if(!(GetLocalInt(OBJECT_SELF, "RSA_Guests") == 2))
        return FALSE;

    return TRUE;
}
