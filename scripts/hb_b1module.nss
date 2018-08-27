float P_LIGHT_SWARM = 0.005;
float P_EVOLUTION   = 0.005;

float Chance()
{
    return IntToFloat(Random(10000)) / 10000.0;
}

int EvolvePop()
{
    return (Chance() > P_EVOLUTION)? TRUE:FALSE;
}

int TotalObjects()
{
    object oI = GetFirstObjectInArea();
    int nTotal = 0;
    while(GetIsObjectValid(oI))
    {
         nTotal = nTotal+1;
         oI = GetNextObjectInArea();
    }
    return nTotal;
}

object GetObjectNumber(int n)
{
    int i = 0;
    object oI = GetFirstObjectInArea();
    object oFirst = oI;
    int nTotal = 0;
    while(GetIsObjectValid(oI))
    {
        if( i == n) return oI;
        i = i + 1;
        oI = GetNextObjectInArea();
    }
    return oFirst;
}

location RandomLoc()
{

    int nTotal = TotalObjects();
    object oObject = GetObjectNumber(Random(nTotal));
    return GetLocation(oObject);
}

void CreateNewCitizen(location lLoc)
{
    string sTag = "NW_GOBLINA";
    switch(d8(2))
    {
    case 1: sTag = "NW_GOBLINA"; break;
    case 2: sTag = "NW_GOBLINB"; break;
    case 3: sTag = "NW_ORCA"; break;
    case 4: sTag = "NW_ORCB"; break;
    case 5: sTag = "NW_HOBOBLIN"; break;
    case 6: sTag = "NW_KOBOLD001"; break;
    case 7: sTag = "NW_KOBOLD002"; break;
    case 8: sTag = "NW_BUGBEARA"; break;
    case 9: sTag = "NW_BUGBEARB"; break;
    case 10: sTag = "nw_trog001"; break;
    case 11: sTag = "NW_GNOLL001"; break;
    case 12: sTag = "zep_skelflaming"; break;
    case 13: sTag = "zep_skelyellow"; break;
    }
    object o = CreateObject(OBJECT_TYPE_CREATURE,sTag,lLoc);
    AssignCommand(o,ActionMoveToLocation(RandomLoc()));
}

void Evolution()
{
    object oI = GetFirstObjectInArea();
    location lNewLoc = GetLocation(oI);
    while(GetIsObjectValid(oI))
    {
         if(d6() == 1) lNewLoc = GetLocation(oI);
         if(d20() == 1) break;
         oI = GetNextObjectInArea();
    }
    CreateNewCitizen(lNewLoc);
}

int HasTorchInHand(object oC)
{
    object oItem = GetItemInSlot(INVENTORY_SLOT_LEFTHAND,oC);
    if(GetBaseItemType(oItem) == BASE_ITEM_TORCH)
        return TRUE;

    oItem = GetItemInSlot(INVENTORY_SLOT_RIGHTHAND,oC);
    if(GetBaseItemType(oItem) == BASE_ITEM_TORCH)
        return TRUE;

    return FALSE;
}

void StirgeSwarm(object oC)
{
    int i;
    int n = 4+d4();
    location lLoc = GetLocation(oC);
    vector vPos = GetPosition(oC);
    float facing = GetFacing(oC);

    for(i = 0; i < n; i++)
    {
        location lNewLoc;
        vector vNewPos;
        vNewPos.x = vPos.x + IntToFloat(Random(100))/10.0;
        vNewPos.y = vPos.y + IntToFloat(Random(100))/10.0;
        lNewLoc = Location(GetArea(oC),vNewPos,facing);
        CreateObject(OBJECT_TYPE_CREATURE,"sr_stirge",lNewLoc);
    }
}

void BeetleSwarm(object oC)
{
    int i;
    int n = 4+d4();
    location lLoc = GetLocation(oC);
    vector vPos = GetPosition(oC);
    float facing = GetFacing(oC);

    for(i = 0; i < n; i++)
    {
        location lNewLoc;
        vector vNewPos;
        vNewPos.x = vPos.x + IntToFloat(Random(100))/10.0;
        vNewPos.y = vPos.y + IntToFloat(Random(100))/10.0;
        lNewLoc = Location(GetArea(oC),vNewPos,facing);
        CreateObject(OBJECT_TYPE_CREATURE,"NW_BTLFIRE",lNewLoc);
    }
}

void main()
{
    object oPC = GetFirstPC();
    while(GetIsObjectValid(oPC))
    {
        if(GetArea(oPC) == OBJECT_SELF)
        {
            if(HasTorchInHand(oPC))
            {
                if(Chance() < P_LIGHT_SWARM )
                {
                    switch(d2())
                    {
                    case 1:
                        StirgeSwarm(oPC);
                        break;
                    case 2:
                        BeetleSwarm(oPC);
                        break;
                    }
                    break;
                }
            }
        }
        oPC = GetNextPC();
    }
    /*
    if(Random(10000) < 500)
    {
        Evolution();
    }
    */
}
