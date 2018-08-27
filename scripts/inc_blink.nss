
// blink/mirror image effect

void DoBlink(object oSelf)
{
    int nBlink = GetLocalInt(OBJECT_SELF,"nBlink");
    if(nBlink < 10)
    {
        SetLocalInt(OBJECT_SELF,"nBlink",nBlink+1);
        vector upos = GetPosition(oSelf);
        vector new;
        float x = IntToFloat(Random(15));
        if(d6() < 4) x = x * -1.0;
        float y = IntToFloat(Random(15));
        if(d6() < 4) y = y * -1.0;

        new.x = upos.x +  x;
        new.y = upos.y + y;
        new.z = upos.z;

        location lLoc = Location(GetArea(oSelf),new,GetFacing(oSelf));
        ClearAllActions(TRUE);
        AssignCommand(oSelf,JumpToLocation(lLoc));
        DelayCommand(1.0,DoBlink(oSelf));
    }

}

void DEMON_Blink()
{
    SetLocalInt(OBJECT_SELF,"nBlink",0);
    DoBlink(OBJECT_SELF);
}

