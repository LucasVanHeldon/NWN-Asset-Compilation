//#include "nw_i0_tool"

void main()
{
    object oPC = GetLastOpenedBy();
    int iJessState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q1_jess");

    if (GetIsPC(oPC) && iJessState == 6)
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        FloatingTextStringOnCreature("As soon as the coffin is opened, you see a weakened Jess crawl out, frightened and battered.", oPC);
        AddJournalQuestEntry("keep_q1_jess", 7, oPC);
        CreateObject(OBJECT_TYPE_CREATURE, "Jess",
            GetLocation(GetObjectByTag("cou_jess_wp1")));
    }
}
