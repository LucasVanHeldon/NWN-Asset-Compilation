void main()
{
    object oPC = GetEnteringObject();
    int iBloodState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q4_blood");

    if (iBloodState == 1 && GetIsPC(oPC)) {
        SetLocalInt(GetArea(oPC), "Blood", 1);
        AddJournalQuestEntry("coc_q4_blood", 2, oPC);
        FloatingTextStringOnCreature("You see a grizzly scene before you.  A young woman on an altar, her blood seeping down off of it towards a swirling pool of blackness and fire.",
                oPC);
        PlaySound("as_pl_screamf3");
    }
}
