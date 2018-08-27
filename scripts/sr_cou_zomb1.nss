void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        object oWP1 = GetObjectByTag("cou_zomb_wp1");
        object oWP2 = GetObjectByTag("cou_zomb_wp2");
        object oWP3 = GetObjectByTag("cou_zomb_wp3");
        object oWP4 = GetObjectByTag("cou_zomb_wp4");
        object oWP5 = GetObjectByTag("cou_zomb_wp5");
        object oWP6 = GetObjectByTag("cou_zomb_wp6");

        FloatingTextStringOnCreature("Moans of the dead erupt from the mass grave and garbled voices exclaim, 'GET OUT!'", oPC);
        CreateObject(OBJECT_TYPE_CREATURE, "CryptZombie", GetLocation(oWP1));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptZombie", GetLocation(oWP2));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptZombie", GetLocation(oWP3));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptZombie", GetLocation(oWP4));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptZombie", GetLocation(oWP5));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptZombie", GetLocation(oWP6));
    }
}
