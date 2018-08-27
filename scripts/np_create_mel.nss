void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Chair_Tripped");
    object oPC = GetLastUsedBy();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Chair_Tripped", 1);
        object oWP3 = GetObjectByTag("NP_MEL");


        CreateObject(OBJECT_TYPE_CREATURE, "mel", GetLocation(oWP3));

    }
}
