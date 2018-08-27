#include "nw_i0_tool"

void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 1);
    // Give the speaker some XP
    RewardPartyXP(2, GetPCSpeaker());

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "sskeletonbones");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
