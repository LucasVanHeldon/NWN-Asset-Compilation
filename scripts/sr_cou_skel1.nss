void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        object oWP1 = GetObjectByTag("cou_skel_wp1");
        object oWP2 = GetObjectByTag("cou_skel_wp2");
        object oWP3 = GetObjectByTag("cou_skel_wp3");
        object oWP4 = GetObjectByTag("cou_skel_wp4");
        object oWP5 = GetObjectByTag("cou_skel_wp5");
        object oWP6 = GetObjectByTag("cou_skel_wp6");

        FloatingTextStringOnCreature("From the remains of fallen victims rise creatures of bone to protect their eternal home.", oPC);
        CreateObject(OBJECT_TYPE_CREATURE, "CryptSkeleton", GetLocation(oWP1));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptSkeleton", GetLocation(oWP2));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptSkeleton", GetLocation(oWP3));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptSkeleton", GetLocation(oWP4));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptSkeleton", GetLocation(oWP5));
        CreateObject(OBJECT_TYPE_CREATURE, "CryptSkeleton", GetLocation(oWP6));
    }
}
