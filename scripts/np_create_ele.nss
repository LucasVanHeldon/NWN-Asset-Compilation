void main()
{
    int iCatCreate = GetLocalInt(OBJECT_SELF, "EleCreate");
    object oPC = GetLastUsedBy();

    if (!iCatCreate && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "EleCreate", 1);
        object oWP1 = GetObjectByTag("WP_CAT");

        FloatingTextStringOnCreature("You have tampered with magic - most foul.", oPC);
        CreateObject(OBJECT_TYPE_CREATURE, "sr_airelem_small", GetLocation(oWP1));

    }
}


