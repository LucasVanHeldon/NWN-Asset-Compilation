void main()
{
    int iPatrons = GetLocalInt(GetArea(OBJECT_SELF), "Patrons");

    if (GetTimeMinute()==0 && iPatrons<10 && d10() == 1)
    {
        int iChance = Random(2);
        location lWP = GetLocation(GetWaypointByTag("sr_tav_enter"));

        switch(iChance)
        {
            case 0:
            CreateObject(OBJECT_TYPE_CREATURE, "TavernPatron", lWP);
            break;

            case 1:
            CreateObject(OBJECT_TYPE_CREATURE, "TavernPatron001", lWP);
        }
        iPatrons++;
        SetLocalInt(GetArea(OBJECT_SELF), "Patrons", iPatrons);
        SendMessageToAllDMs("Current Patrons: "+IntToString(iPatrons));
    }
}
