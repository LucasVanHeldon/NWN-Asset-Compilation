void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (iTripped<1 && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
    }
}
