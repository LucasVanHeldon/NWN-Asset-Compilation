void main()
{
    object oDoor1 = GetObjectByTag("PortcullisD2a");
    object oDoor2 = GetObjectByTag("PortcullisD2b");
    object oDoor3 = GetObjectByTag("PortcullisD2c");
    object oPC = GetClickingObject();

    FloatingTextStringOnCreature("The sounds of gears grinding and doors rattling can be heard echoing through the area.", oPC);

    if (!GetIsOpen(oDoor1))
    {
        ActionUnlockObject(oDoor1);
        ActionOpenDoor(oDoor1);
        ActionUnlockObject(oDoor2);
        ActionOpenDoor(oDoor2);
        ActionUnlockObject(oDoor3);
        ActionOpenDoor(oDoor3);
    } else {
        ActionCloseDoor(oDoor1);
        ActionCloseDoor(oDoor2);
        ActionCloseDoor(oDoor3);
    }
}
