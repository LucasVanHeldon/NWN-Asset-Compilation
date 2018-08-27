void main()
{
    int iHour = GetTimeHour();
    int iGarfoss = GetLocalInt(OBJECT_SELF, "GarfossLoad");
    int iGarfossState = GetLocalInt(GetFirstPC(), "NW_JOURNAL_ENTRYcoc_q2_barrier");

    if (iHour == 8 && iGarfossState > 4)
    {
        int iRand=d6();

        if (iRand == 1 && iGarfoss < 1)
        {
            location lGarfoss = GetLocation(GetObjectByTag("GarfossWP1"));

            CreateObject(OBJECT_TYPE_CREATURE, "Garfoss", lGarfoss);
            SetLocalInt(OBJECT_SELF, "GarfossLoad", 1);
        } else {
            SetLocalInt(OBJECT_SELF, "GarfossLoad", iGarfoss++);
        }
        if (iGarfoss == 4)
        {
            DestroyObject(GetObjectByTag("Garfoss"));
            SetLocalInt(OBJECT_SELF, "GarfossLoad", 0);
            SetLocalInt(OBJECT_SELF, "WomanLoad", FALSE);
        }
    }
}
