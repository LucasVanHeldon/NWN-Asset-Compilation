void main()
{
    object oDoor = GetObjectByTag("01_MainGate");
    SetLocked(oDoor, FALSE);
    AssignCommand(oDoor, ActionOpenDoor(oDoor));
}
