//::///////////////////////////////////////////////
//:: FileName sr_sabine13
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/12/2002 12:22:29 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker some gold
    RewardPartyGP(250, GetPCSpeaker());

    // Give the speaker some XP
    RewardPartyXP(500, GetPCSpeaker());

    // Give the speaker the items
    CreateItemOnObject("innerkeepkey", GetPCSpeaker(), 1);

    DestroyObject(GetObjectByTag("Garfoss"), 12.0);
    FloatingTextStringOnCreature("Garfoss is taken into custody for his crimes.",
        OBJECT_SELF, FALSE);

}
