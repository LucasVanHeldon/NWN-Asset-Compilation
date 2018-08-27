void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    PlaySound("as_pl_screamf3");
    if (!iTripped && GetIsPC(oPC)) {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        int x=1;
        while (x<9) {
            location lWP = GetLocation(GetObjectByTag("WP_K1DH" + IntToString(x)));
            CreateObject(OBJECT_TYPE_CREATURE, "demonhound", lWP);
            x++;
        }
    }
}
