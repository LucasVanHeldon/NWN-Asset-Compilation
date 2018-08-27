void main()
{
        int iBarrierState = GetLocalInt(GetPCSpeaker(), "NW_JOURNAL_ENTRYcoc_q2_barrier");

        if (iBarrierState == 1)
                AddJournalQuestEntry("coc_q2_barrier", 10, GetPCSpeaker());
}
