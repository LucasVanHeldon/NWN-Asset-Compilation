
int CreateMinorTrap(object oDoor);

void Msg(string msg)
{
    SendMessageToPC(GetFirstPC(),msg);
}

void CreateBones(location lLoc)
{
    string sTag;
    switch(d3())
    {
    case 1: sTag="x3_plc_skelmage"; break;
    case 2:
    case 3:
    }
}

void CreateBarrel(location lLoc)
{
    CreateObject(OBJECT_TYPE_PLACEABLE,
                        "barrel001",
                        lLoc);
}

void CreateMushroom(location lLoc)
{
    string sTag = "nw_plc_mushroom1";

    switch(d3())
    {
    case 1: sTag = "codisporegroup1"; break;
    case 2: sTag = "codisporegroup2"; break;
    case 3: sTag = "nw_plc_mushroom1"; break;
    }
    CreateObject(OBJECT_TYPE_PLACEABLE,
                        sTag,
                        lLoc);

}

void CreateChest(location lLoc)
{
    string sTag = "treasurechest";
    object oChest = CreateObject(OBJECT_TYPE_PLACEABLE,
                        sTag,
                        lLoc);
    AssignCommand(oChest,SetFacing(180.0));
    if(d6() == 1) SetLocked(oChest,TRUE);
    if(d6() == 1)
    {
        int trap = CreateMinorTrap(oChest);
        CreateTrapOnObject(trap,oChest);
    }

}

void Destroy(string sTag, object oC)
{
    object oB = GetFirstObjectInShape(SHAPE_SPHERE,15.0,GetLocation(oC));
    while(GetIsObjectValid(oB))
    {
        if(GetTag(oB)==sTag) DestroyObject(oB);
        oB = GetNextObjectInShape(SHAPE_SPHERE,15.0,GetLocation(oC));
    }
}

float NewRotation()
{
    return IntToFloat(Random(180));
}

void CreateBarrels(location lLoc, vector vPos, object oC)
{
    int i;
    for(i = 0; i < 4+d4(); i++)
    {

        vector vNew;
        vNew.x = vPos.x + IntToFloat(Random(200))/100.0;
        vNew.y = vPos.y + IntToFloat(Random(200))/100.0;
        vNew.z = 0.0;

        DelayCommand(1.0,
            CreateBarrel(
                Location(
                    GetArea(oC),
                    vNew,
                    NewRotation())));
    }
}

void CreateMushrooms(location lLoc, vector vPos, object oC)
{
    int i;
    for(i = 0; i < d4(2); i++)
    {

        vector vNew;
        vNew.x = vPos.x + IntToFloat(Random(950))/100.0;
        vNew.y = vPos.y + IntToFloat(Random(950))/100.0;
        vNew.z = 0.0;

        DelayCommand(1.0,
            CreateMushroom(
                Location(
                    GetArea(oC),
                    vNew,
                    NewRotation())));
    }
}


int CreateMinorTrap(object oDoor)
{
   return Random(47);
   switch(d12())
   {
   case 1: return TRAP_BASE_TYPE_MINOR_ACID;
   case 2: return TRAP_BASE_TYPE_MINOR_ACID_SPLASH;
   case 3: return TRAP_BASE_TYPE_MINOR_ELECTRICAL;
   case 4: return TRAP_BASE_TYPE_MINOR_FIRE;
   case 5: return TRAP_BASE_TYPE_MINOR_FROST;
   case 6: return TRAP_BASE_TYPE_MINOR_GAS;
   case 7: return TRAP_BASE_TYPE_MINOR_HOLY;
   case 8: return TRAP_BASE_TYPE_MINOR_NEGATIVE;
   case 10: return TRAP_BASE_TYPE_MINOR_SONIC;
   case 11: return TRAP_BASE_TYPE_MINOR_SPIKE;
   case 12: return TRAP_BASE_TYPE_MINOR_TANGLE;
   }
   return 0;
}

void ProcessTraps()
{
    object o = GetFirstObjectInArea();
    while(GetIsObjectValid(o))
    {
        if(d6() == 1 && GetTag(o) == "WP_CORRIDOR")
        {
            CreateTrapAtLocation(
                CreateMinorTrap(o),
                GetLocation(o),
                1.5);
        }
        o = GetNextObjectInArea();
    }
}

void CreateMinorTraps()
{
    object o = GetFirstObjectInArea();
    while(GetIsObjectValid(o))
    {
        if(GetObjectType(o) == OBJECT_TYPE_DOOR)
        {
            if(d6() == 1) SetLocked(o,TRUE);
            if(d6() == 1)
            {
                int trap = CreateMinorTrap(o);
                CreateTrapOnObject(trap,o);
            }
        }
        o = GetNextObjectInArea();
    }
}

void RunOnce()
{


    object oWP;
    if(GetLocalInt(OBJECT_SELF,"bEntered") == 0)
    {
        SendMessageToPC(GetFirstPC(),"Entering");
        SetLocalInt(OBJECT_SELF,"bEntered",1);

        object oC = GetFirstObjectInArea();


        while(GetIsObjectValid(oC))
        {
            oWP = oC;
            location lLoc = GetLocation(oWP);
            vector vPos = GetPosition(oWP);

            if(GetTag(oC) == "WP_BARRELS")
            {
                DelayCommand(1.0,Destroy("MMI_BARREL",oC));
                DelayCommand(1.0,CreateBarrels(lLoc,vPos,oWP));
            }
            if(GetTag(oC) == "WP_MUSHROOMS")
            {
                DelayCommand(1.0,Destroy("nw_plc_mushroom1",oC));
                DelayCommand(1.0,CreateMushrooms(lLoc,vPos,oWP));
            }
            if(GetTag(oC) == "WP_CHEST")
            {
                DelayCommand(1.0,Destroy("TREASURECHEST",oC));
                DelayCommand(1.0,CreateChest(lLoc));
            }
            oC = GetNextObjectInArea();
        }
        DelayCommand(1.0,CreateMinorTraps());
        DelayCommand(1.0,ProcessTraps());
    }

}

void main()
{
    if(GetIsPC(GetEnteringObject())) RunOnce();

    if(GetLocalInt(OBJECT_SELF,"nTreasure")==0 && GetIsPC(GetEnteringObject()))
    {

        int n = 0;
        object oWP = GetFirstObjectInArea();

        SetLocalInt(OBJECT_SELF,"nTreasure",1);
        while(GetIsObjectValid(oWP))
        {
            if(GetLocalInt(oWP,"bSpawn")==FALSE)
            {
                if(GetTag(oWP) == "WP_MEDTRASH" )
                {
                    object o = CreateObject(OBJECT_TYPE_PLACEABLE,"X0_TRES_ANYMED",GetLocation(oWP));
                    SetLocalInt(oWP,"bSpawn",TRUE);
                }
                else if(GetTag(oWP) == "WP_HIGHTRASH")
                {
                    CreateObject(OBJECT_TYPE_PLACEABLE,"X0_TRES_ANYHIGH",GetLocation(oWP));
                    SetLocalInt(oWP,"bSpawn",TRUE);
                }
            }
            oWP = GetNextObjectInArea();
        }
    }
}
