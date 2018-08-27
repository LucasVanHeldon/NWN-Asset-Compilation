void main()
{
    object oDoor1 = GetObjectByTag("PortcullisD2b");
    object oPC = GetEnteringObject();

    if (GetIsOpen(oDoor1))
    {
        ActionCloseDoor(oDoor1);
    }
}
