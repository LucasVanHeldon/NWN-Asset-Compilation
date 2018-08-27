//::///////////////////////////////////////////////
//:: DOPPLEGANGER HENCHMAN v1.0
//:: Associate: Heartbeat
//:: dop_hench_heart.nss
//:: Copyright (c) 2002 Jeremy Sager
//:: Email: Jeremy_21117@hotmail.com
//:: Based on original Henchman OnHeartbeat script
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    This normal seeming henchman is in fact nothing
    less than an evil doppleganger just waiting for
    the chance to crush her "ally" at the worst
    possible moment.

    There are two variables that you may wish to change.

    The Local Int "Countdown" (which is actually set at the
    end of the added code) measures how many 6 second
    intervals will pass before the doppleganger even thinks
    about changing. Default is 10 seconds aka 1 minute

    int iPercentChanceOfChange indicates what percentage
    chance the doppleganger has of spawning at every six
    second tick. If you set this very low, the doppleganger
    may end up as a henchman for hours (or seconds heh heh).
    The default is set to 50% so that she will spawn quickly
    in the test module she ships with.

    If you want to just make it a set time, set it to 100%

    version 1.1 will spawn a foe based on level - I just need
    to create some higher level shapechangers.

    If you have any suggestions or requests, please email me.
    If you improve upon my script, let me know so I can use your
    version!

*/

#include "NW_I0_GENERIC"

void main()
{
// BEGIN CODE ADDED TO THE STANDARD HENCHMAN SCRIPT
    int iPercentChanceOfChange = 5;
    /* Modify this to the percentage
    chance you want the doppleganger
    to expose on each heartbeat */
    if (GetLocalInt (OBJECT_SELF, "Countdown") != 0) //Make sure Countdown is not invalid
        {
        SetLocalInt (OBJECT_SELF, "Countdown", ((GetLocalInt (OBJECT_SELF, "Countdown")-1))); //Decrement Countdown
        if (GetLocalInt (OBJECT_SELF, "Countdown") <= 0
           && (Random (100)+1 <= iPercentChanceOfChange)) // If the countdown is now at 0 or less AND the random number is EQUAL or LESS than the percentage chance, presto chango.
           {
           ClearAllActions ();
           location lDoppSpawnPoint = GetLocation(OBJECT_SELF); //So we know where to spawn the doppleganger
           object oMaster = GetMaster();
           RemoveHenchman(oMaster,OBJECT_SELF); //Gets henchman out of party
           SpeakString ("Your time is done, primate!",TALKVOLUME_TALK); //Talk smack
           EffectVisualEffect (VFX_IMP_HOLY_AID,FALSE); // Go out with a bang!
           DestroyObject (OBJECT_SELF,0.0);
           CreateObject (OBJECT_TYPE_CREATURE, "Doppleganger", lDoppSpawnPoint, TRUE);
           }
       }
    else
        {
        SetLocalInt (OBJECT_SELF, "Countdown", 50);
        /*If Countdown was invalid, set it to however
        many heartbeats you want to wait before there's
        ANY chance of a spawn.
        Default 10 is one minute real time. */
        }
// END CODE ADDED TO THE STANDARD HENCHMAN SCRIPT
    if(!GetAssociateState(NW_ASC_IS_BUSY))
    {
        object oMaster = GetMaster();
        //Seek out and disable undisabled traps
        object oTrap = GetNearestTrapToObject();
        if(GetIsObjectValid(oTrap) && GetDistanceToObject(oTrap) < 15.0 && GetDistanceToObject(oTrap) > 0.0)
        {
            object oTrapSaved = GetLocalObject(OBJECT_SELF, "NW_ASSOCIATES_LAST_TRAP");
            int nTrapDC = GetTrapDisarmDC(oTrap);
            int nSkill = GetSkillRank(SKILL_DISABLE_TRAP);
            nSkill = nSkill + 20 - nTrapDC;

            if(nSkill > 0 && GetSkillRank(SKILL_DISABLE_TRAP) > 0)
            {
                if( GetIsObjectValid(oMaster)
                    && nSkill > 0
                    && !IsInConversation(OBJECT_SELF)
                    && !GetIsInCombat()
                    && GetCurrentAction(OBJECT_SELF) != ACTION_REST
                    && GetCurrentAction(OBJECT_SELF) != ACTION_DISABLETRAP)
                {
                    ClearAllActions();
                    ActionUseSkill(SKILL_DISABLE_TRAP, oTrap);
                    ActionDoCommand(SetCommandable(TRUE));
                    ActionDoCommand(PlayVoiceChat(VOICE_CHAT_TASKCOMPLETE));
                    SetCommandable(FALSE);
                    return;
                }
            }
            else if(oTrap != oTrapSaved && GetSkillRank(SKILL_DISABLE_TRAP) > 0)
            {
                PlayVoiceChat(VOICE_CHAT_CANTDO);
                SetLocalObject(OBJECT_SELF, "NW_ASSOCIATES_LAST_TRAP", oTrap);
            }
        }
        if(GetIsObjectValid(oMaster) &&
            GetCurrentAction(OBJECT_SELF) != ACTION_FOLLOW &&
            GetCurrentAction(OBJECT_SELF) != ACTION_DISABLETRAP &&
            GetCurrentAction(OBJECT_SELF) != ACTION_OPENLOCK &&
            GetCurrentAction(OBJECT_SELF) != ACTION_REST &&
            GetCurrentAction(OBJECT_SELF) != ACTION_ATTACKOBJECT)
        {
            if(
               !GetIsObjectValid(GetAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetIsObjectValid(GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN))
              )
            {
                if(GetDistanceToObject(GetMaster()) > 6.0)
                {
                    if(GetAssociateState(NW_ASC_HAVE_MASTER))
                    {
                        if(!GetIsFighting(OBJECT_SELF))
                        {
                            if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                            {
                                if(GetDistanceToObject(GetMaster()) > GetFollowDistance())
                                {
                                    ClearAllActions();
                                    if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) || GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                    {
                                         if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
                                         {
                                            //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                            //ActionUseSkill(SKILL_MOVE_SILENTLY,OBJECT_SELF);
                                         }
                                         if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                         {
                                            ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                                         }
                                         MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                         ActionForceFollowObject(oMaster, GetFollowDistance());
                                    }
                                    else
                                    {
                                         MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                         ActionForceFollowObject(oMaster, GetFollowDistance());
                                         //ActionForceMoveToObject(GetMaster(), TRUE, GetFollowDistance(), 5.0);
                                    }
                                }
                            }
                        }
                    }
                }
                else if(!GetAssociateState(NW_ASC_MODE_STAND_GROUND))
                {
                    if(GetIsObjectValid(oMaster))
                    {
                        if(GetCurrentAction(oMaster) != ACTION_REST)
                        {
                            ClearAllActions();
                            if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH) || GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                            {
                                 if(GetAssociateState(NW_ASC_AGGRESSIVE_STEALTH))
                                 {
                                    //ActionUseSkill(SKILL_HIDE, OBJECT_SELF);
                                    //ActionUseSkill(SKILL_MOVE_SILENTLY,OBJECT_SELF);
                                 }
                                 if(GetAssociateState(NW_ASC_AGGRESSIVE_SEARCH))
                                 {
                                    ActionUseSkill(SKILL_SEARCH, OBJECT_SELF);
                                 }
                                 MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Command with Search and/or Stealth");
                                 ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                            else
                            {
                                 MyPrintString("GENERIC SCRIPT DEBUG STRING ********** " + "Assigning Force Follow Normal");
                                 ActionForceFollowObject(oMaster, GetFollowDistance());
                            }
                        }
                    }
                }
            }
            else if(!GetIsObjectValid(GetAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetAssociateState(NW_ASC_MODE_STAND_GROUND))
            {
                //DetermineCombatRound();
            }

        }
        if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
        {
            SignalEvent(OBJECT_SELF, EventUserDefined(1001));
        }
    }
}



