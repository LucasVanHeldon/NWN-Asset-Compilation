void main()
{
    string sTag = "WP_MAZEOFIUZ00" + IntToString(Random(1)+1);
    AssignCommand(GetLastUsedBy(),JumpToObject(GetWaypointByTag(sTag)));
}
