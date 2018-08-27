void main()
{
    object oPC = GetEnteringObject();
    int iBloodState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q4_blood");
    int iShrineState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q5_shrine");
    int iCelestState = GetLocalInt(oPC, "NW_JOURNAL_ENTRYcoc_q3_celestial");
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    int iNumDone = 0;

    if (!iTripped && GetIsPC(oPC)) {
        SetLocalInt(OBJECT_SELF, "Tripped", TRUE);
        CreateObject(OBJECT_TYPE_CREATURE, "gdretchdemon",
            GetLocation(GetObjectByTag("WP_Dretch")));

        if (iBloodState == 3)
            iNumDone++;
        if (iShrineState == 2)
            iNumDone++;
        if (iCelestState > 2)
            iNumDone++;
        if (iNumDone == 0)
            SetLocalInt(GetArea(oPC), "GSummon", 1);
        if (iNumDone <2) {
            CreateObject(OBJECT_TYPE_CREATURE, "dretchdemon",
                GetLocation(GetObjectByTag("WP_Dretch1")));
            CreateObject(OBJECT_TYPE_CREATURE, "dretchdemon",
                GetLocation(GetObjectByTag("WP_Dretch2")));
        }
        if (iNumDone <3)
            CreateObject(OBJECT_TYPE_CREATURE, "quasit",
                GetLocation(GetObjectByTag("WP_Quasit")));


    } //tripped
}
