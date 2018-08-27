//::///////////////////////////////////////////////
//:: FileName at_templekey02
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 6/10/2004 11:37:14 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("templegatekey", GetPCSpeaker(), 1);


    // Remove some gold from the player
    TakeGoldFromCreature(500, GetPCSpeaker(), FALSE);
    // Set the variables
    SetLocalInt(GetPCSpeaker(), "FalseMerchantPlot", 1);

}
