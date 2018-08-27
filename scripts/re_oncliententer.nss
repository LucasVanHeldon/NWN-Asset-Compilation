//::///////////////////////////////////////////////
//:: FileName re_oncliententer.nss
//:://////////////////////////////////////////////
/*
This is part of the BESIE Random Encounter System.
It is intended to be placed in the module
OnClientEnter handler.  Its purpose is to set a
local int on the DM so the he does not produce
random encounters when possessing an NPC.
*/
//:://////////////////////////////////////////////
//:: Created By: Ray Miller
//:: Created On: 10/14/02
//:://////////////////////////////////////////////
void main()
{
object oPC = GetEnteringObject();
int bBESIEWidget;
if(GetIsDM(oPC))
    {
    SetLocalInt(GetModule(), "re_" + GetPCPlayerName(oPC), TRUE);
    object oItem = GetFirstItemInInventory(oPC);
    while(GetIsObjectValid(oItem))
        {
        if(GetTag(oItem) == "BESIEWidget") bBESIEWidget = TRUE;
        oItem = GetNextItemInInventory(oPC);
        }
    if(!bBESIEWidget) CreateItemOnObject("besiewidget", oPC);
    }
else DeleteLocalInt(GetModule(), "re_" + GetName(oPC));
}
