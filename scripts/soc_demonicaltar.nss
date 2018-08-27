int NumGhuls()
{
    int n = 0;
    object oG = GetFirstObjectInShape(SHAPE_SPHERE,20.0,GetLocation(OBJECT_SELF));
    while(GetIsObjectValid(oG))
    {
        if(GetTag(oG) == "Ghul") n++;
        oG = GetNextObjectInShape(SHAPE_SPHERE,20.0,GetLocation(OBJECT_SELF));
    }
    return n;
}

void main()
{
    int nHB = GetLocalInt(OBJECT_SELF,"nHB");
    nHB = nHB + 1;
    if(nHB > 50)
    {
        if(NumGhuls() < 12)
            CreateObject(OBJECT_TYPE_CREATURE,"Ghul",GetLocation(OBJECT_SELF));
        nHB = 0;
    }
    SetLocalInt(OBJECT_SELF,"nHB",nHB);
}
