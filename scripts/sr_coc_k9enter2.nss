void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();
    int iCallingState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q6_calling");

    if (!iTripped && GetIsPC(oPC) && iCallingState == 0) {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        FloatingTextStringOnCreature("To the Northwest, the Dretch Demon is seen who is the source of all this evil.", oPC);
        AddJournalQuestEntry("coc_q6_calling", 1, oPC);
        AssignCommand(GetObjectByTag("gdretchdemon"),
            ActionSpeakString("The Greater Summoning must be tied off and completed if the gates of hell are to be left open!  Stop them!"));
    }

}
