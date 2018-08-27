void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC)) {
        FloatingTextStringOnCreature("Harsh voices echo from the west.", oPC, FALSE);
        SetLocalInt(OBJECT_SELF, "Tripped", TRUE);
    }
}
