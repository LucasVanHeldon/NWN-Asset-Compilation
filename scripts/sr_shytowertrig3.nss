void main()
{
    int iTripped = GetLocalInt(GetObjectByTag("ShyTowerTrigger"), "Tripped");

    if(iTripped)
    {
        object oEnter = GetLastUsedBy();
        if(GetIsPC(oEnter))
        {
            location lLoc = GetLocation(GetObjectByTag("WP_InsideShy"));
            AssignCommand(oEnter,ClearAllActions());
            AssignCommand(oEnter,JumpToLocation(lLoc));
        }
    }
}
