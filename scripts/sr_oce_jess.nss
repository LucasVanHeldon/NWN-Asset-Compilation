//::///////////////////////////////////////////////
//:: Default: End of Combat Round
//:: NW_C2_DEFAULT3
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Calls the end of combat script every round
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Oct 16, 2001
//:://////////////////////////////////////////////

#include "NW_I0_GENERIC"
void main()
{
    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
    {
        DetermineSpecialBehavior();
    }
    else if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
    {
       DetermineCombatRound();
    }
    if(GetSpawnInCondition(NW_FLAG_END_COMBAT_ROUND_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1003));
    }

    if (GetCurrentHitPoints()<20 && !GetLocalInt(OBJECT_SELF, "Flee")) {
        SetLocalInt(OBJECT_SELF, "Flee", TRUE);
        SpeakString("(Whispered voice) Please don't kill me!");
        SurrenderToEnemies();
        ActionMoveToObject(GetObjectByTag("POST_ShadowofJess"), TRUE);
    }
}


