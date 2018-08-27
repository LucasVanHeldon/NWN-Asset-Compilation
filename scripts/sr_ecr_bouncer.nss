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
    //ActionEquipMostDamagingMelee();

    if(GetCurrentHitPoints(GetAttackTarget())<1)
    {
        ClearAllActions();
    }
}


