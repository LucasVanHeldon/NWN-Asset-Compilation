void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 400);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "hwildboarpelt");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
