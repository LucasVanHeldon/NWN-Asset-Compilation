#include "nw_i0_tool"

void main()
{
    // Give the speaker some XP
    RewardPartyXP(50, GetPCSpeaker());
    CreateItemOnObject("07c_chestkey", GetPCSpeaker());

    // Remove items from the player's inventory
    object oItemToTake;
    oItemToTake = GetItemPossessedBy(GetPCSpeaker(), "HobGobChiefHead");
    if(GetIsObjectValid(oItemToTake) != 0)
        DestroyObject(oItemToTake);
}
