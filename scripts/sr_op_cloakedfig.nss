#include "NW_I0_GENERIC"

void main()
{
    //This is the equivalent of a force conversation bubble, should only be used if you want an NPC
    //to say something while he is already engaged in combat.
    if(GetSpawnInCondition(NW_FLAG_SPECIAL_COMBAT_CONVERSATION) && GetIsPC(GetLastPerceived()) && GetLastPerceptionSeen())
    {
        SpeakOneLinerConversation();
    }
    //If the last perception event was hearing based or if someone vanished then go to search mode
    if ((GetLastPerceptionVanished()) && GetIsEnemy(GetLastPerceived()))
    {
        object oGone = GetLastPerceived();
        if((GetAttemptedAttackTarget() == GetLastPerceived() ||
           GetAttemptedSpellTarget() == GetLastPerceived() ||
           GetAttackTarget() == GetLastPerceived()) && GetArea(GetLastPerceived()) != GetArea(OBJECT_SELF))
        {
           ClearAllActions();
           DetermineCombatRound();
        }
    }
    //Do not bother checking the last target seen if already fighting
    else if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
    {
        //Check if the last percieved creature was actually seen
        if(GetLastPerceptionSeen())
        {
            if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
            {
                DetermineSpecialBehavior();
            }
            else if(GetIsEnemy(GetLastPerceived()))
            {
                if(!GetHasEffect(EFFECT_TYPE_SLEEP))
                {
                    SetFacingPoint(GetPosition(GetLastPerceived()));
                    SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                    DetermineCombatRound();
                }
            }
            //Linked up to the special conversation check to initiate a special one-off conversation
            //to get the PCs attention
            else if(GetSpawnInCondition(NW_FLAG_SPECIAL_CONVERSATION) && GetIsPC(GetLastPerceived()))
            {
                ActionStartConversation(OBJECT_SELF);
            }
        }
    }
    if(GetSpawnInCondition(NW_FLAG_PERCIEVE_EVENT) && GetLastPerceptionSeen())
        SignalEvent(OBJECT_SELF, EventUserDefined(1002));

    // Nihilists talk to those who aren't Lawful or Good (whom they attack on sight)
    if (GetAlignmentGoodEvil(GetLastPerceived()) == ALIGNMENT_GOOD ||
            GetAlignmentLawChaos(GetLastPerceived()) == ALIGNMENT_LAWFUL) {
        SpeakString("Death to those not of Tharizdun!!!");
        SetLocalLocation(GetArea(OBJECT_SELF),"MyLocation",GetLocation(OBJECT_SELF));
        DestroyObject(OBJECT_SELF);
        DestroyObject(GetObjectByTag("CloakedFigure2"));
        DestroyObject(GetObjectByTag("CloakedFigure3"));
        DestroyObject(GetObjectByTag("CloakedFigure4"));
        SignalEvent(GetArea(OBJECT_SELF), EventUserDefined(1010));
    } else {
        ActionStartConversation(OBJECT_SELF);
    }
}
