void main()
{
    object o = GetLastUsedBy();
    AssignCommand(o,JumpToLocation(GetLocalLocation(o,"NW_RECALL")));
}
