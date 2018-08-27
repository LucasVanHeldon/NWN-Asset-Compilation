//::///////////////////////////////////////////////
//:: Default On Heartbeat
//:: NW_C2_DEFAULT1
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This script will have people perform default
    animations.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 23, 2001
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"
#include "sr_enemy_resting"

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

    // Resting Rules for Creatures...
    //  - Less than 75% health
    //  - Not in Combat
    if (!GetIsInCombat() && GetDistanceToObject(GetNearestSeenOrHeardEnemy()) > 20.0) {
        float fPerc = 100.0;
        fPerc = IntToFloat(GetCurrentHitPoints()) / IntToFloat(GetMaxHitPoints());
        if (fPerc < 0.75)
            EnemyRest();
    } else if (GetDistanceToObject(GetNearestSeenOrHeardEnemy()) <= 20.0) {

    }

    switch (d100()) {
      case 1: ActionCastFakeSpellAtObject(SPELL_SEE_INVISIBILITY, OBJECT_SELF); break;
      case 2: ActionCastSpellAtObject(SPELL_GHOSTLY_VISAGE, OBJECT_SELF, METAMAGIC_ANY, TRUE); break;
      case 3: ActionCastSpellAtObject(SPELL_MAGE_ARMOR, OBJECT_SELF, METAMAGIC_ANY, TRUE); break;
      case 4: ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING); break;
      case 5: ActionPlayAnimation(ANIMATION_LOOPING_PAUSE_TIRED, 1.0, 6.0); break;
      case 6: ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 60.0); break;
      case 7: ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0, 6.0); break;
      case 8: SpeakString("Travelers come yonder for a quick ride!"); break;
      case 9: SpeakString("This keep needs more flowers."); break;
      case 10: ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD); break;
    }

}
