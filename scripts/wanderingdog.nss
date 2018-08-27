#include "nw_i0_generic"
void main()
{
    // * if not runnning normal or better Ai then exit for performance reasons
    if (GetAILevel() == AI_LEVEL_VERY_LOW) return;
    if(Random(4) == 0)
        PlayVoiceChat(Random(3) + 1);
    // run towards PC
    if (!GetIsObjectValid(GetAttemptedAttackTarget())
       && !GetIsObjectValid(GetAttemptedSpellTarget())
       && !GetIsObjectValid(GetNearestSeenEnemy()))
    {
       object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
       if(GetDistanceBetween(OBJECT_SELF, oPC) > 0.0
       && GetDistanceBetween(OBJECT_SELF, oPC) < 20.0
       && Random(3) == 0)
       {
          ActionMoveToObject(oPC, TRUE);
          ActionDoCommand(PlayVoiceChat(1));
          return;
       }
       else
       {
            PlayMobileAmbientAnimations();
       }
    }
    // Send the user-defined event signal if specified
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(EVENT_HEARTBEAT));
    }
}

