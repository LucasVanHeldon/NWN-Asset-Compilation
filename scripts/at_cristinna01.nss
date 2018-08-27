//::///////////////////////////////////////////////
//:: FileName at_cristinna01
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 4/3/2003 9:43:55 PM
//:://////////////////////////////////////////////
#include "nw_i0_tool"

void main()
{
    // Give the speaker some XP
    RewardPartyXP(100, GetPCSpeaker());

    // Set the variables
    SetLocalInt(GetPCSpeaker(), "talked to Cristinnah", 1);
    SetLocalInt(GetPCSpeaker(), "momma", 1);

    // Move NPC away from Speaker and disappear
    ActionForceMoveToObject(GetNearestObjectByTag("SlaveExit"),TRUE,2.0);
    ActionMoveAwayFromObject(GetPCSpeaker());
    DestroyObject(OBJECT_SELF,5.0);

}
