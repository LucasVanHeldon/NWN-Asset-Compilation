//#include "nw_i0_tool"

void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();
    int iJessState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q1_jess");

    if (!iTripped && GetIsPC(oPC) && iJessState == 2)
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        FloatingTextStringOnCreature("Ahead, you see the what has happened to Jess.  Her form is now only a Shadow, a creature of undead, and you must consider what can be done.", oPC);
        AddJournalQuestEntry("keep_q1_jess", 3, oPC);
    }
}
