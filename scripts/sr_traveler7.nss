//::///////////////////////////////////////////////
//:: FileName sr_traveler4
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/15/2002 3:55:37 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 150);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ArfluvanSilk");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
