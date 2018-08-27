#include "NW_I0_GENERIC"

void main()
{
    if(GetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY))
    {
        if(TalentAdvancedBuff(40.0))
        {
            SetSpawnInCondition(NW_FLAG_FAST_BUFF_ENEMY, FALSE);
            return;
        }
    }

    if(GetSpawnInCondition(NW_FLAG_DAY_NIGHT_POSTING))
    {
        int nDay = FALSE;
        if(GetIsDay() || GetIsDawn())
        {
            nDay = TRUE;
        }
        if(GetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT") != nDay)
        {
            if(nDay == TRUE)
            {
                SetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", TRUE);
            }
            else
            {
                SetLocalInt(OBJECT_SELF, "NW_GENERIC_DAY_NIGHT", FALSE);
            }
            WalkWayPoints();
        }
    }

    if(!GetHasEffect(EFFECT_TYPE_SLEEP))
    {
        if(!GetIsPostOrWalking())
        {
            if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
            {
                if(!GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                {
                    if(!GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL) && !IsInConversation(OBJECT_SELF))
                    {
                        if(GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS) || GetSpawnInCondition(NW_FLAG_AMBIENT_ANIMATIONS_AVIAN))
                        {
                            PlayMobileAmbientAnimations();
                        }
                        else if(GetIsEncounterCreature() &&
                        !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                        {
                            PlayMobileAmbientAnimations();
                        }
                        else if(GetSpawnInCondition(NW_FLAG_IMMOBILE_AMBIENT_ANIMATIONS) &&
                           !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN)))
                        {
                            PlayImmobileAmbientAnimations();
                        }
                    }
                    else
                    {
                        DetermineSpecialBehavior();
                    }
                }
                else
                {
                    //DetermineCombatRound();
                }
            }
        }
    }
    else
    {
        if(GetSpawnInCondition(NW_FLAG_SLEEPING_AT_NIGHT))
        {
            effect eVis = EffectVisualEffect(VFX_IMP_SLEEP);
            if(d10() > 6)
            {
                ApplyEffectToObject(DURATION_TYPE_INSTANT, eVis, OBJECT_SELF);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1001));
    }

    switch (d100()) {
      case 1: SpeakString("I really need to finish up my shopping and get home."); break;
      case 2: ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING); break;
      case 3: ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 6.0); break;
      case 4: ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 6.0); break;
      case 5: ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 1.0, 6.0); break;
      case 6: SpeakString("Oh, what a day I have had!"); break;
      case 7: SpeakString("..and to think I thought having a man would solve my problems!"); break;
      case 8: ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD); break;
      case 9: SpeakString("I need a nap."); break;
      case 10: SpeakString("Oh my, you flatterer!"); break;
      case 11: ActionRandomWalk(); break;
      case 12: ActionRandomWalk(); break;
      case 13: ActionRandomWalk(); break;
      case 14: ActionRandomWalk(); break;
      case 15: ActionRandomWalk(); break;
      case 16: ActionRandomWalk(); break;
      case 17: ActionRandomWalk(); break;
      case 18: ActionRandomWalk(); break;
      case 19: ActionRandomWalk(); break;
      case 20: ActionRandomWalk(); break;
    }

}
