//::///////////////////////////////////////////////
//:: Associate: End of Combat End
//:: NW_CH_AC3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////
#include "hench_i0_ai"

void main()
{
//    Jug_Debug("*****" + GetName(OBJECT_SELF) + " end combat round action " + IntToString(GetCurrentAction()) + " busy " + IntToString(GetAssociateState(NW_ASC_IS_BUSY)));

    DeleteLocalInt(OBJECT_SELF, HENCH_AI_SCRIPT_RUN_STATE);

    if (!GetLocalInt(GetModule(),"X3_NO_MOUNTED_COMBAT_FEAT"))
    { // set variables on target for mounted combat
        DeleteLocalInt(OBJECT_SELF,"bX3_LAST_ATTACK_PHYSICAL");
        DeleteLocalInt(OBJECT_SELF,"nX3_HP_BEFORE");
        DeleteLocalInt(OBJECT_SELF,"bX3_ALREADY_MOUNTED_COMBAT");
    } // set variables on target for mounted combat

    if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
        HenchDetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_END_COMBAT_ROUND));
    }
}
