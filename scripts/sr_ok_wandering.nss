void CreatureEncountered();

void main()
{
    int iTurnCounter = GetLocalInt(OBJECT_SELF, "TurnCounter");

    if (iTurnCounter == 60 && GetArea(GetFirstPC()) == OBJECT_SELF)
    {
        CreatureEncountered();
        iTurnCounter = -1;
    }

    SetLocalInt(OBJECT_SELF, "TurnCounter", iTurnCounter++);
}

void CreatureEncountered()
{
    if(d6()==1)
    {
        int iDirection=d4();
        float fX;
        float fY;
        switch(iDirection)
        {
            case 1:
                fX=0.0; fY=10.0; break;
            case 2:
                fX=10.0; fY=0.0; break;
            case 3:
                fX=0.0; fY=-10.0; break;
            case 4:
                fX=-10.0; fY=0.0; break;
        }
        vector vStart = GetPosition(GetFirstPC());
        vector vOffset = Vector(fX,fY);
        vector vEndvector=vStart+vOffset;
        location lEnd=Location(GetArea(GetFirstPC()),vEndvector,GetFacing(GetFirstPC()));
        int iPCHD = GetFactionAverageLevel(GetFirstPC());
        int iEncRoll = d4();
        int iEncNumber;
        int iEncCount = 1;
        switch(iEncRoll)
        {
            case 1:
                iEncNumber=d4()+1;
                while (iEncCount<=iEncNumber)
                {
                    CreateObject(OBJECT_TYPE_CREATURE,"direrat",lEnd);
                    iEncCount++;
                }
                break;
            case 2:
                iEncNumber=d4();
                while (iEncCount<=iEncNumber)
                {
                    CreateObject(OBJECT_TYPE_CREATURE,"ruffian",lEnd);
                    iEncCount++;
                }
                break;
            case 3:
                iEncNumber=d4(2);
                while (iEncCount<=iEncNumber)
                {
                    CreateObject(OBJECT_TYPE_CREATURE,"sskeleton",lEnd);
                    iEncCount++;
                }
                break;
            default:
                iEncNumber=d6();
                while (iEncCount<=iEncNumber)
                {
                    CreateObject(OBJECT_TYPE_CREATURE,"ruffian",lEnd);
                    iEncCount++;
                }
                break;
        }
    }
}

