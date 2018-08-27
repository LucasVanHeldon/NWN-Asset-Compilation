void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC) && !GetIsInCombat(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);

        FloatingTextStringOnCreature("This room is crisscrossed with rope-thick bands of spiderwebs, although most are towards the high-arching ceiling.", oPC);
    }
}
