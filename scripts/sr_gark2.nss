//::///////////////////////////////////////////////
//:: FileName sr_gark2
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/9/2002 3:38:05 PM
//:://////////////////////////////////////////////
void main()
{
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "hwildboarpelt");
    if(GetIsObjectValid(oItemToTake) != 0) {
        DestroyObject(oItemToTake);
        // Give the speaker some gold
        GiveGoldToCreature(GetPCSpeaker(), 300);
    }
}
