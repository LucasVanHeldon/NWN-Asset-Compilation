void main()
{
    object oTPto = GetObjectByTag("WP_I" + IntToString(d10()));
    AssignCommand(GetEnteringObject(), JumpToObject(oTPto));
}
