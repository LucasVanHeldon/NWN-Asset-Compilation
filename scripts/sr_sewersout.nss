void main()
{
    object oPC = GetLastUsedBy();
    location lTrans = GetLocation(GetObjectByTag("WP_SewersExit"));

    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToLocation(lTrans));
}
