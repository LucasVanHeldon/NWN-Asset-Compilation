void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetLastOpenedBy();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        object oWP;
        FloatingTextStringOnCreature("This chamber is a mess of refuse, food scraps, and assorted garbage.  Unfortunately, it appears that you have also disturbed its small residents.", oPC);
        int x=1;
        while (x<6) {
            oWP = GetObjectByTag("WP_Cat" + IntToString(x));
            DestroyObject(GetObjectByTag("DeadCragCat"));
            CreateObject(OBJECT_TYPE_CREATURE, "spectralcat", GetLocation(oWP));
            x++;
        }
    }
}
