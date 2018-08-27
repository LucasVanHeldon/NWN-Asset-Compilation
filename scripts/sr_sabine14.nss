#include "nw_i0_tool"

void main()
{
    // Give the speaker some gold
    RewardPartyGP(250, GetPCSpeaker());

    // Give the speaker the items
    CreateItemOnObject("innerkeepkey", GetPCSpeaker(), 1);

}
