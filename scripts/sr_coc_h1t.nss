#include "nw_i0_tool"
#include "sr_i0_tools"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        if (SkillCheck(oPC, 20, SKILL_SPOT))
        {
            RewardPartyXP(25, oPC);
            FloatingTextStringOnCreature(GetName(oPC) + " spotted a trap and marked it to avoid.", oPC);
        } else {
            FloatingTextStringOnCreature(GetName(oPC) + " triggered a trap!!!", oPC);

            object oPCs = GetFirstFactionMember(oPC);
            while (GetIsObjectValid(oPCs))
            {
                float fDist = GetDistanceBetween(oPCs, oPC);
                if (oPCs == oPC || (fDist > 0.0 && fDist < 5.0))
                {
                    int iResult = ReflexSave(oPCs, 18);
                    if (iResult < 1)
                    {
                        FloatingTextStringOnCreature(GetName(oPCs) + " was struck by a hail of needles.", oPCs);
                        ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                EffectDamage(d4(2), DAMAGE_TYPE_BLUDGEONING), oPCs);
                        int iResult2 = FortitudeSave(oPCs, 13);
                        if (iResult2 < 1)
                        {
                            FloatingTextStringOnCreature(GetName(oPCs) + " failed to save versus poison!", oPCs);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,
                                EffectPoison(POISON_GREENBLOOD_OIL), oPCs);
                        }
                    } else {
                        FloatingTextStringOnCreature(GetName(oPCs) + " avoided the hail of needles.", oPCs);
                    }
                }
                oPCs = GetNextFactionMember(oPC);
            }
        }
    }
}
