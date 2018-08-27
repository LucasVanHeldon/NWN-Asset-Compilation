void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC)) {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        int x=1;
        while (x<21) {
            location lWP = GetLocation(GetObjectByTag("WP_K4Z" + IntToString(x)));
            CreateObject(OBJECT_TYPE_CREATURE, "zombie001", lWP);
            x++;
        }
    }
    SoundObjectPlay(GetObjectByTag("ZombieMoansK4"));
}
