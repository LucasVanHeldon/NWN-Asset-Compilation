void main()
{
    object oEnter = GetLastUsedBy();
    if(GetIsPC(oEnter)) {
        location lLoc = GetLocation(GetObjectByTag("WP_ShyTowerOut"));
        AssignCommand(oEnter,ClearAllActions());
        AssignCommand(oEnter,JumpToLocation(lLoc));
    }
}

