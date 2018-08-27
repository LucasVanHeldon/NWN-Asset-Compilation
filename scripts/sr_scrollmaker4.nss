#include "nw_i0_tool"
void main()
{
    // Remove items from the player's inventory
    object oItemToTake;
    int nTaken;
    oItemToTake = GetFirstItemInInventory(GetPCSpeaker());
    while (GetIsObjectValid(oItemToTake) != 0) {
        if (GetTag(oItemToTake) == "sskeletonbones") {
            DestroyObject(oItemToTake);
            nTaken++;
        }
        oItemToTake = GetNextItemInInventory(GetPCSpeaker());
    }
    if (nTaken>0) {
        GiveGoldToCreature(GetPCSpeaker(), nTaken*5);
        RewardPartyXP((nTaken*2), GetPCSpeaker());
    }
}
