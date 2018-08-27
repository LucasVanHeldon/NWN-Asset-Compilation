void main()
{
    object oPC = GetLastUsedBy();
    int iJessState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q1_jess");
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");

    if (GetIsPC(oPC) && !iTripped && iJessState == 4)
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        FloatingTextStringOnCreature("You notice that the butterflies are hovering over a group of light-yellow roses.", oPC);
        CreateItemOnObject("pollenmarshrose", oPC);
    }
}
