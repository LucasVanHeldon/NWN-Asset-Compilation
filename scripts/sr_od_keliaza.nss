#include "NW_I0_GENERIC"
#include "nw_i0_tool"

void main()
{
    int nClass = GetLevelByClass(CLASS_TYPE_COMMONER);
    int nAlign = GetAlignmentGoodEvil(OBJECT_SELF);
    object oKiller = GetLastKiller();

    if(nClass > 0 && (nAlign == ALIGNMENT_GOOD || nAlign == ALIGNMENT_NEUTRAL))
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    if(nAlign == ALIGNMENT_GOOD)
    {
        AdjustAlignment(oKiller, ALIGNMENT_EVIL, 5);
    }

    SpeakString("NW_I_AM_DEAD", TALKVOLUME_SILENT_TALK);
    //Shout Attack my target, only works with the On Spawn In setup
    SpeakString("NW_ATTACK_MY_TARGET", TALKVOLUME_SILENT_TALK);
    if(GetSpawnInCondition(NW_FLAG_DEATH_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1007));
    }

    object oPC = GetFirstFactionMember(oKiller);
    int iBloodState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q4_blood");

    if (iBloodState < 3 && GetIsPC(oPC)) {
        AddJournalQuestEntry("coc_q4_blood", 3, oPC);
        SetLocalInt(GetArea(oKiller), "Blood", 99);
        RewardPartyXP(250, oPC);
        DestroyObject(GetObjectByTag("K3Flame"));
        DestroyObject(GetObjectByTag("KScreamWomen1"));
        DestroyObject(GetObjectByTag("KScreamWomen2"));
    }
}
