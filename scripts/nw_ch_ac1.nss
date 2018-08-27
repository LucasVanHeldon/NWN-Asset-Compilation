//::///////////////////////////////////////////////
//:: Associate: Heartbeat
//:: NW_CH_AC1.nss
//:: Copyright (c) 2001 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Move towards master or wait for him
    Modified by Pausanias to improve the Battle AI and include
    nifty's bard song fix.
*/
//:://////////////////////////////////////////////
//:: Created By: Preston Watamaniuk
//:: Created On: Nov 21, 2001
//:://////////////////////////////////////////////
#include "NW_I0_GENERIC"

void main()
{

    // Pausanias: Do not do any heartbeat events if you're in conversation
    // or in combat.
    if (IsInConversation(OBJECT_SELF) || GetIsInCombat(OBJECT_SELF)) return;

    // Nifty's code to detect whether a bard is resting.

    if(!GetAssociateState(NW_ASC_IS_BUSY))
    {
        BardRest();

        object oMaster = GetMaster();
        //Seek out and disable undisabled traps
        object oTrap = GetNearestTrapToObject();
        if (GetSkillRank(SKILL_DISABLE_TRAP) > 0) {
          if(GetIsObjectValid(oTrap) && GetDistanceToObject(oTrap) < 15.0 &&
             GetDistanceToObject(oTrap) > 0.0 && !GetIsDoorInLineOfSight(oTrap))
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
        }
        if (GetCurrentAction(OBJECT_SELF) == ACTION_FOLLOW)
            MyPrintString("****ON HB: FOLLOW****");
        if (GetCurrentAction(OBJECT_SELF) == ACTION_DISABLETRAP)
            MyPrintString("****ON HB: TRAP****");
        if (GetCurrentAction(OBJECT_SELF) == ACTION_OPENLOCK)
            MyPrintString("****ON HB: LOCK****");
        if (GetCurrentAction(OBJECT_SELF) == ACTION_REST)
            MyPrintString("****ON HB: REST****");
        if (GetCurrentAction(OBJECT_SELF) == ACTION_ATTACKOBJECT)
            MyPrintString("****ON HB: ATTACK****");

        if(GetIsObjectValid(oMaster) &&
            GetCurrentAction(OBJECT_SELF) != ACTION_DISABLETRAP &&
            GetCurrentAction(OBJECT_SELF) != ACTION_OPENLOCK &&
            GetCurrentAction(OBJECT_SELF) != ACTION_REST &&
            GetCurrentAction(OBJECT_SELF) != ACTION_ATTACKOBJECT)
        {

            // Pausanias: Hench tends to get stuck on follow.
            if (GetCurrentAction(OBJECT_SELF) == ACTION_FOLLOW) {
                if (GetDistanceToObject(GetMaster()) >= 2.2 &&
                    GetAssociateState(NW_ASC_DISTANCE_2_METERS)) return;
                if (GetDistanceToObject(GetMaster()) >= 4.2 &&
                    GetAssociateState(NW_ASC_DISTANCE_4_METERS)) return;
                if (GetDistanceToObject(GetMaster()) >= 6.2 &&
                    GetAssociateState(NW_ASC_DISTANCE_6_METERS)) return;
                ClearAllActions();
            }

            object oClosest = GetNearestCreature(CREATURE_TYPE_REPUTATION, REPUTATION_TYPE_ENEMY, OBJECT_SELF, 1, CREATURE_TYPE_PERCEPTION, PERCEPTION_SEEN);

            MyPrintString("********* ON HEARTBEAT: ASC IS NOT BUSY *************");
            if(
               !GetIsObjectValid(GetAttackTarget()) &&
               !GetIsObjectValid(GetAttemptedSpellTarget()) &&
               !GetIsObjectValid(GetAttemptedAttackTarget()) &&
               !GetIsObjectValid(oClosest)
              )
            {

                if (GetLocalInt(OBJECT_SELF,"SwitchedToMelee") &&
                    GetAssociateState(NW_ASC_USE_RANGED_WEAPON)) {
                    ClearAllActions();
                    SetLocalInt(OBJECT_SELF,"SwitchedToMelee",FALSE);
                    EquipAppropriateWeapons(OBJECT_SELF);
                    return;
                }
                 MyPrintString("********* ON HEARTBEAT: ASC IS NOT ATTACKING *************");
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
                    if(GetIsObjectValid(oMaster) && !GetLocalInt(OBJECT_SELF,"Scouting"))
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
            else if(GetIsObjectValid(oClosest) &&
                    GetCurrentAction() != ACTION_ATTACKOBJECT &&
                    GetCurrentAction() != ACTION_CASTSPELL &&
                    GetCurrentAction() != ACTION_HEAL &&
                   !GetAssociateState(NW_ASC_MODE_STAND_GROUND))
            {
                MyPrintString("********* ON HEARTBEAT: ASC IDLE, SO ENTER COMBAT *************");
                DetermineCombatRound();
            }
            else
              MyPrintString("********* ON HEARTBEAT: ALREADY IN COMBAT *************");

            if (GetLocalInt(OBJECT_SELF,"Scouting")) {
                if (GetDistanceToObject(GetMaster()) < 6.0)
                    SpeakString("Please get out of my way.");
                ActionForceFollowObject(GetLocalObject(OBJECT_SELF,"ScoutTarget"),1.0);
            }
        }
        if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
        {
            SignalEvent(OBJECT_SELF, EventUserDefined(1001));
        }
    } else
      MyPrintString("********* ON HEARTBEAT: ASC IS BUSY *************");
}



