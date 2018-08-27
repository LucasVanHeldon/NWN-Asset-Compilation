void main()
{
    object oPC = GetEnteringObject();
    int iBloodState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q4_blood");

    if (iBloodState == 0 && GetIsPC(oPC)) {
        AddJournalQuestEntry("coc_q4_blood", 1, oPC);
        FloatingTextStringOnCreature("SCREAMS of PURE TERROR can be heard echoing through the halls to the south.",
                oPC);
    }
}
