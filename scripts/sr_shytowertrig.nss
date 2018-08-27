void main()
{
    object oPC = GetEnteringObject();
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");

    if (GetIsPC(oPC) && GetHitDice(oPC)>2 && !iTripped) {
        object oSound = GetObjectByTag("EntranceMysterious1");
        location lSound = GetLocation(oSound);
        SetLocalInt(OBJECT_SELF, "Tripped", TRUE);

        SignalEvent(oSound, EventActivateItem(oSound, lSound));

        int x;
        for (x=1; x<=4; x++) {
            object oLight = GetObjectByTag("WP_ShyTower" + IntToString(x));
            location lLight = GetLocation(oLight);

            object oShaft = CreateObject(OBJECT_TYPE_PLACEABLE, "shaftoflightcyan",
                    lLight,TRUE);
        }
        location lWP = GetLocation(GetObjectByTag("WP_ShyTower"));
        CreateObject(OBJECT_TYPE_PLACEABLE, "shytowerportal", lWP);
        object oShaft = CreateObject(OBJECT_TYPE_PLACEABLE, "shytowerportal", lWP,TRUE);

        FloatingTextStringOnCreature("To the southeast, a ghostly image shimmers of a tower standing tall and dark where there was none just a short time ago.",
                oPC);
    }
}
