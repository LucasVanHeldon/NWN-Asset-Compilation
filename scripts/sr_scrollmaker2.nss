#include "nw_i0_tool"
void main()
{
    // Remove items from the player's inventory
    object oItemToTake;
    int nTaken = 0;
    oItemToTake = GetFirstItemInInventory(GetPCSpeaker());
    while (GetIsObjectValid(oItemToTake)) {
        if (GetTag(oItemToTake) == "sskeletonbones") {
            DestroyObject(oItemToTake);
            nTaken++;
        }
        oItemToTake = GetNextItemInInventory(GetPCSpeaker());
    }
    if (nTaken>0) {
        GiveGoldToCreature(GetPCSpeaker(), nTaken);
        RewardPartyXP((nTaken*2), GetPCSpeaker());
    }
}
