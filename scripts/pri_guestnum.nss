//::///////////////////////////////////////////////
//:: How many Guest?
//:: pri_guestnum
//:: Copyright (c) 2002 Shepherd Software Inc.
//:://////////////////////////////////////////////
/*

This script is used on the Suite Butler by the DM
to tell how many guests are currently in the Suite.
Useful for error fixing if guests logout, etc.

*/
//:://////////////////////////////////////////////
//:: Created By: Russell S. Ahlstrom
//:: Created On: July 11, 2002
//:://////////////////////////////////////////////

void main()
{
object oPC = GetPCSpeaker();
object oTrigger = GetNearestObjectByTag("SuiteAutoDoor");
int iNGuests = GetLocalInt(oTrigger, "RSA_NGuests");
SendMessageToPC(oPC, "There are currently "+IntToString(iNGuests)+" guest(s) in this suite.");
}
