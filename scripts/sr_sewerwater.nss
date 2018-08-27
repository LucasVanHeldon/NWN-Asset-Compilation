void main()
{
    // Give the speaker the items
    CreateItemOnObject("bottlefoulsewer", GetPCSpeaker(), 1);


    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "emptybottle");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
