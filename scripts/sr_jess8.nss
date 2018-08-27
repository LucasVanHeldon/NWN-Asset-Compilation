//::///////////////////////////////////////////////
//:: FileName sr_jess8
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/11/2002 2:14:21 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker some XP
    RewardPartyXP(50, GetPCSpeaker());

    // Give the speaker the items
    CreateItemOnObject("16_guildkey", GetPCSpeaker(), 1);
    CreateItemOnObject("innerkeepkey", GetPCSpeaker(), 1);

}
