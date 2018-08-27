void main()
{
    int nRandom = d100();
    object oPC = GetEnteringObject();

    if(nRandom<21 && GetLocalInt(OBJECT_SELF, "FirstEnter") == 0)
    {
        SetEncounterActive(TRUE, GetObjectByTag("OutsideCaves1"));

        nRandom = d20();
        if(nRandom + GetSkillRank(SKILL_LISTEN, oPC) > 15)
          FloatingTextStringOnCreature("You hear some grunts coming from the northwest.", oPC, FALSE);

       SetLocalInt(OBJECT_SELF, "FirstEnter", 1);
    }
}
