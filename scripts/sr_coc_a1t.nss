#include "nw_i0_tool"
//#include "sr_i0_tools"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        if (GetSkillRank(SKILL_SPOT,oPC) > 3)
        {
            RewardPartyXP(10, oPC);
            FloatingTextStringOnCreature("A trap has been spotted and is marked to avoid.", oPC);
        } else {
            object oWP1 = GetObjectByTag("sr_coc_a1wp1");

            SetLocalInt(GetArea(oPC), "TrapTriggered", TRUE);
            FloatingTextStringOnCreature("A trap has trigger!!!", oPC);
            PlaySound("as_cv_bell2");

            CreateObject(OBJECT_TYPE_CREATURE, "AngryBadger", GetLocation(oWP1));
            DestroyObject(GetObjectByTag("KabaltGoblin1a"));
            DestroyObject(GetObjectByTag("KabaltGoblin1b"));
            DestroyObject(GetObjectByTag("KabaltGoblin1c"));
            CreateObject(OBJECT_TYPE_CREATURE, "KabaltGoblin1",
                GetLocation(GetObjectByTag("sr_coc_a2wp1")));
            CreateObject(OBJECT_TYPE_CREATURE, "KabaltGoblin1",
                GetLocation(GetObjectByTag("sr_coc_a2wp2")));
            CreateObject(OBJECT_TYPE_CREATURE, "KabaltGoblin1",
                GetLocation(GetObjectByTag("sr_coc_a2wp3")));
        }
    }
}
