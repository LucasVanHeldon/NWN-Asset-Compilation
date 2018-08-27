void main()
{
    location lMyLoc = GetLocation(OBJECT_SELF);
    vector vPos = GetPositionFromLocation(lMyLoc);
    SendMessageToPC(GetFirstPC(),"vPos.z="+FloatToString(vPos.z));
    float lastY = GetLocalFloat(OBJECT_SELF,"fLastY");
    if(lastY < 10.0)
    {
        lastY = lastY + 0.5;
        vPos.z = vPos.z + lastY;
        SetLocalFloat(OBJECT_SELF,"fLastY",lastY);
        lMyLoc = Location(GetArea(OBJECT_SELF),vPos,GetFacing(OBJECT_SELF));
        AssignCommand(OBJECT_SELF,ActionJumpToLocation(lMyLoc));
    }

}
