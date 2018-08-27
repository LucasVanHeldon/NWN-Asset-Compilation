void main()
{
    object oClicker = GetClickingObject();
    object oTarget = GetTransitionTarget(OBJECT_SELF);
    location lLoc = GetLocation(oTarget);

    if (GetIsPC(oClicker))
    {
        // SR's KotB plots:
        int iBarrierState = GetLocalInt(oClicker, "NW_JOURNAL_ENTRYcoc_q2_barrier");
        int iUnionState = GetLocalInt(oClicker, "NW_JOURNAL_ENTRYcoc_q1_union");

        if (iBarrierState < 22)
        {
            FloatingTextStringOnCreature("There is a strange barrier preventing your entering of this cave.  It is a force that is both evil and unholy in its feel.", oClicker);
            if (iBarrierState == 0 && iUnionState < 9)
                AddJournalQuestEntry("coc_q2_barrier", 1, oClicker);
            if (iUnionState > 8)
                AddJournalQuestEntry("coc_q2_barrier", 10, oClicker);
        } else {
            AssignCommand(oClicker,JumpToLocation(lLoc));
        }
    }
}
