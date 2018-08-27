void main()
{
   object oPC = GetLastUsedBy();
   int iTripped = GetLocalInt(OBJECT_SELF, "Well_Observe");

    if (!iTripped && GetIsPC(oPC))
    {
       SetLocalInt(OBJECT_SELF, "Well_Observe", 1);

       FloatingTextStringOnCreature("This well looks too steep to decend without something to climb down.", oPC);
    }
}
