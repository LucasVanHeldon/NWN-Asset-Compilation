#include "NW_I0_GENERIC"

void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        object oKiller = GetLastKiller();
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    if(nAlign == ALIGNMENT_GOOD)
    {
        object oKiller = GetLastKiller();
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    object oPC = GetFirstPC();

    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") > 0)
    {
        int iGarfossState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYkeep_q2_garfoss");

        if (iGarfossState < 3)
            AddJournalQuestEntry("keep_q2_garfoss", 6, oPC);
    } else {
        AddJournalQuestEntry("keep_q2_garfoss", 99, oPC);
    }

    SetLocalInt(GetArea(OBJECT_SELF), "GarfossLoad", 99);
}
