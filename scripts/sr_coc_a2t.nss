#include "nw_i0_tool"
#include "sr_i0_tools"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        if (SkillCheck(oPC, 20, SKILL_SEARCH))
        {
            RewardPartyXP(10, oPC);
            FloatingTextStringOnCreature(GetName(oPC) + " spotted a trap and marked it to avoid.", oPC);
        } else {
            FloatingTextStringOnCreature(GetName(oPC) + " triggered a trap!!!", oPC);

            object oPCs = GetFirstFactionMember(oPC);
            while (GetIsObjectValid(oPCs))
            {
                float fDist = GetDistanceBetween(oPCs, oPC);
                if (oPCs == oPC || (fDist > 0.0 && fDist < 5.0))
                {
                    int iResult = ReflexSave(oPCs, 12);
                    if (iResult < 1)
                    {
                        FloatingTextStringOnCreature(GetName(oPCs) + " was hit by a tumbling boulder.", oPC);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                EffectDamage(d6(), DAMAGE_TYPE_BLUDGEONING),
                                oPCs);
                    } else {
                        FloatingTextStringOnCreature(GetName(oPCs) + " avoided the tumbling boulder.", oPC);
                    }
                }
                oPCs = GetNextFactionMember(oPC);
            }
        }
    }
}
