void main()
{
    object oDoor1 = GetObjectByTag("PortcullisD6");
    object oPC = GetLastUsedBy();

    FloatingTextStringOnCreature("A creaking sound distantly echoes through the corridors.", oPC);

    if (!GetIsOpen(oDoor1))
    {
        ActionUnlockObject(oDoor1);
        ActionOpenDoor(oDoor1);
    } else {
        ActionCloseDoor(oDoor1);
    }
}
