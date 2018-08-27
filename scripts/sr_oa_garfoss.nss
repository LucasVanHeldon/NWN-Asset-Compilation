#include "NW_I0_GENERIC"

void main()
{
    SurrenderToEnemies();
    SpeakString("Please don't kill me!!!", TALKVOLUME_SHOUT);
    object oPC = GetFirstPC();

    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") > 0)
    {
        AddJournalQuestEntry("keep_q2_garfoss", 5, oPC);
        SetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack", 0);
    } else {
        SpeakString("Just leave me be! I have done nothing!", TALKVOLUME_SHOUT);
    }
}
