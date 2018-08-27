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
object GetNearestTougherFriend(object oSelf, object oPC) {

    int i = 0;

    object oFriend = oSelf;

    int nEqual = 0;
    int nNear = 0;
    while (GetIsObjectValid(oFriend)) {
      if (GetDistanceBetween(oSelf,oFriend) < 40.0 && oFriend != oSelf) {
        ++nNear;
        if (GetHitDice(oFriend) > GetHitDice(oSelf))
                return oFriend;
        if (GetHitDice(oFriend) == GetHitDice(oSelf))
            ++nEqual;
      }
      ++i;
      oFriend =  GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_FRIEND,
                                         oSelf, i);
    }

    SetLocalInt(OBJECT_SELF,"LocalBoss",FALSE);
    if (nEqual == 0)
        if (nNear > 0 || GetHitDice(oPC)-GetHitDice(OBJECT_SELF) < 2) {
            SetLocalInt(OBJECT_SELF,"LocalBoss",TRUE);
        }

    return OBJECT_INVALID;
}


void main()
{

    // Pausanias: monsters try to find you.

    if (GetGameDifficulty() >= GAME_DIFFICULTY_CORE_RULES) {
        object oPC = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC,
                                    OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION,
                                    PERCEPTION_NOT_SEEN);

        if (GetIsObjectValid(oPC) &&
            GetDistanceToObject(oPC) < 40.0 &&
            !GetIsObjectValid(GetLastHostileActor()) &&
            !GetIsInCombat() &&
            !GetIsFighting(OBJECT_SELF) &&
            d10() > 2 &&
            GetIsEnemy(oPC)) {

            int ScoutMode = GetLocalInt(OBJECT_SELF,"ScoutMode");
            if (ScoutMode == 0) {
               ScoutMode = d2();
               SetLocalInt(OBJECT_SELF,"ScoutMode",ScoutMode);
            }
            object oTarget = GetNearestTougherFriend(OBJECT_SELF,oPC);
            if (!GetLocalInt(OBJECT_SELF,"LocalBoss")) {
                ClearAllActions();
                object oDoor = GetBlockingDoor();
                if (GetIsObjectValid(oDoor)) {
                    if (GetLocked(oDoor))
                        ExecuteScript("henchunlock",oDoor);
                    if (GetIsDoorActionPossible(oDoor,DOOR_ACTION_OPEN) &&
                        !GetLocked(oDoor) && !GetIsTrapped(oDoor)) {
                        ActionOpenDoor(oDoor);
                        SetLocalInt(OBJECT_SELF,"OpenedDoor",TRUE);
                        return;
                    }
                }

                int fDist = 15;
                if (!GetIsObjectValid(oTarget) || ScoutMode == 1) {
                    fDist = 10;
                    oTarget = oPC;
                    if (d10() > 5) fDist = 25;
                }


                location lNew;
                if (GetLocalInt(OBJECT_SELF,"OpenedDoor")) {
                    lNew = GetLocalLocation(OBJECT_SELF,"ScoutZone");
                    SetLocalInt(OBJECT_SELF,"OpenedDoor",FALSE);
                }
                else {
                    vector vLoc = GetPosition(oTarget);
                    vLoc.x += fDist-IntToFloat(Random(2*fDist+1));
                    vLoc.y += fDist-IntToFloat(Random(2*fDist+1));
                    vLoc.z += fDist-IntToFloat(Random(2*fDist+1));
                    lNew = Location(GetArea(oTarget),vLoc,0.);
                    SetLocalLocation(OBJECT_SELF,"ScoutZone",lNew);
                }

                ActionMoveToLocation(lNew);
                return;
            }
        }
    }

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
    if (!GetIsInCombat()) {
        if (GetPercentageHPLoss(OBJECT_SELF) < 75)
            EnemyRest();
    } else if (GetDistanceToObject(GetNearestSeenOrHeardEnemy()) <= 10.0) {

    }
}
