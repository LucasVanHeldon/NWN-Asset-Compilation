//#include "nw_i0_tool"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        if (GetRacialType(oPC) == RACIAL_TYPE_ELF
                || GetRacialType(oPC) == RACIAL_TYPE_HALFELF
                || GetRacialType(oPC) == RACIAL_TYPE_DWARF
                || GetAbilityScore(oPC, ABILITY_INTELLIGENCE) > 13)
        {
            FloatingTextStringOnCreature("Written in goblin, a sign clearly reads: DANGER! CRAWLERS!", oPC);
        } else {
            FloatingTextStringOnCreature("A sign is found on this door written in some unidentifiable language.", oPC);
        }
    }
}
