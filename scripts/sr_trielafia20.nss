void main()
{
    ActionPauseConversation();
    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "bottlefoulsewer");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    // Give the speaker the items
    ActionCastFakeSpellAtObject(SPELL_BLESS, OBJECT_SELF);
    CreateItemOnObject("bottlepuresewer", GetPCSpeaker(), 1);
    ActionResumeConversation();
}
