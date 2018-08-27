//:: SR On Attacked for Water Mephit
#include "NW_I0_GENERIC"

void main()
{
    if(!GetFleeToExit())
    {
        //EquipAppropriateWeapons(OBJECT_SELF);

        if(!GetSpawnInCondition(NW_FLAG_SET_WARNINGS))
        {
            if(!GetIsObjectValid(GetAttemptedAttackTarget()) && !GetIsObjectValid(GetAttemptedSpellTarget()))
            {
                if(GetIsObjectValid(GetLastAttacker()))
                {
                    if(GetBehaviorState(NW_FLAG_BEHAVIOR_SPECIAL))
                    {
                        //AdjustReputation(GetLastAttacker(), OBJECT_SELF, -100);
                        SetSummonHelpIfAttacked();
                        DetermineSpecialBehavior(GetLastAttacker());
                    }
                    else
                    {
                        if(GetArea(GetLastAttacker()) == GetArea(OBJECT_SELF))
                        {
                            SetSummonHelpIfAttacked();
                            DetermineCombatRound();
                        }
                    }
                    //Shout Attack my target, only works with the On Spawn In setup
                    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
                    //Shout that I was attacked
                    SpeakString("NW_I_WAS_ATTACKED", TALKVOLUME_SILENT_TALK);
                }
            }
        }
        else
        {
            //Put a check in to see if this attacker was the last attacker
            //Possibly change the GetNPCWarning function to make the check
            SetSpawnInCondition(NW_FLAG_SET_WARNINGS, FALSE);
        }
    }
    else
    {
        ActivateFleeToExit();
    }
    if(GetSpawnInCondition(NW_FLAG_ATTACK_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1005));
    }

    // Determine whether or not the Mephit can try to Summon Another one.
    int iAttacked = GetLocalInt(OBJECT_SELF, "Attacked");
    int iTime = GetLocalInt(OBJECT_SELF, "Time");
    int iCurrTime = GetTimeMinute() + GetTimeHour()*60
             + GetCalendarDay()*60*24 + (GetCalendarYear()-1000)*365*60*24;

    if ((iTime + (60*24)) < iCurrTime)
        SetLocalInt(OBJECT_SELF, "Attacked", 0);

    if (!iAttacked)
    {
        SetLocalInt(OBJECT_SELF, "Attacked", 1);
        SetLocalInt(OBJECT_SELF, "Time", iCurrTime);

        int iRandom = d100();

        if (iRandom<26)
            CreateObject(OBJECT_TYPE_CREATURE, "glowwatermephit", GetLocation(OBJECT_SELF));
     }
}
