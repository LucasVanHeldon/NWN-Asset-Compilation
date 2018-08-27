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

    // Harpy Song
    int iSung = GetLocalInt(OBJECT_SELF, "Song");
    if (!iSung) {
        // Singing
        SetLocalInt(OBJECT_SELF, "Song", TRUE);
        object oCreature = GetNearestObject(OBJECT_TYPE_CREATURE);
        int iNum = 1;
        while (GetIsObjectValid(oCreature) && GetDistanceToObject(oCreature) < 30.0 && iNum<10 &&
                GetIsEnemy(oCreature)) {
            // Saving Throw
            if (WillSave(oCreature, 15) == 0) {
                // Failed
                ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectParalyze(), oCreature, 18.0);
                FloatingTextStringOnCreature(GetName(oCreature)+
                        " has been paralyzed by the Harpy's Song!", oCreature, FALSE);
            } else {
                FloatingTextStringOnCreature(GetName(oCreature)+
                        " resisted the Harpy's Song!", oCreature, FALSE);
            }
            iNum++;
            oCreature = GetNearestObject(OBJECT_TYPE_CREATURE, OBJECT_SELF, iNum);
        }
    }
}


