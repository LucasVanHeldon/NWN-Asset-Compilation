#include "nw_i0_tool"

void main()
{
    ActionPauseConversation();
    // Give the speaker some XP
    RewardPartyXP(100, GetPCSpeaker());

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "bottlepuresewer");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
//    AssignCommand(GetPCSpeaker(),
//        ActionCastFakeSpellAtObject(SPELL_BLESS, GetObjectByTag("SewerWell")));
    ActionResumeConversation();
}
