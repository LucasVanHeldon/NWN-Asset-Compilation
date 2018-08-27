//::///////////////////////////////////////////////
//:: FileName at_zeb_xp
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/2/2003 12:17:27 AM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{

object oPC = GetPCSpeaker();

int nInt;
nInt=GetLocalInt(oPC, "zebtalk");

if (nInt == 0) //Check to see if already done once so as not to give XP again
   {
    // Give the speaker some XP
    RewardPartyXP(250, GetPCSpeaker());


    // Modify the player's reputation
    AdjustReputation(GetPCSpeaker(), OBJECT_SELF, 100);

    // Set local Integer
    SetLocalInt(oPC, "zebtalk", 1);

   }
}
