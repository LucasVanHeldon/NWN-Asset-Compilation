void main()
{
    object oPC = GetEnteringObject();
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    int iTripped2 = GetLocalInt(GetObjectByTag("ShyTowerTrigger"), "Tripped");

    if (GetIsPC(oPC) && !iTripped && iTripped2) {
        SetLocalInt(OBJECT_SELF, "Tripped", TRUE);
        FloatingTextStringOnCreature("As you stand staring at the broken remains of an old tower, it appears whole and foreboding suddenly.  It's image is shimmering and translucent and a glowing portal stands at its entrance.",
                oPC);
    }
}
