//::///////////////////////////////////////////////
//:: FileName sr_trielafia14
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/24/2002 7:06:56 PM
//:://////////////////////////////////////////////
void main()
{

    // Remove items from the player's inventory
    ActionPauseConversation();
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "wmephsoulstone");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "minotaurhorn");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "ashlanternarchon");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "historyofthebarr");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
    ActionCastFakeSpellAtObject(SPELL_HOLY_AURA, OBJECT_SELF);
    ActionResumeConversation();
}
