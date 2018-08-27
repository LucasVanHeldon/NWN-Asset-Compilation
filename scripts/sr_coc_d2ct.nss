void main()
{
    object oDoor1 = GetObjectByTag("PortcullisD2c");
    object oPC = GetEnteringObject();

    if (GetIsOpen(oDoor1))
    {
        ActionCloseDoor(oDoor1);
    }
}
