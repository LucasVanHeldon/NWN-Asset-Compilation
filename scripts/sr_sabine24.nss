#include "nw_i0_tool"

void main()
{
    // Give the speaker some XP
    RewardPartyXP(250, GetPCSpeaker());
    object oPC = GetFirstFactionMember(GetPCSpeaker(), TRUE);
    while (GetIsObjectValid(oPC)) {
        AdjustAlignment(oPC, ALIGNMENT_GOOD, 10);
        oPC = GetNextFactionMember(GetPCSpeaker(), TRUE);
    }

    // Give the speaker the items
    CreateItemOnObject("innerkeepkey", GetPCSpeaker(), 1);

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "simplegoldsilver");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
