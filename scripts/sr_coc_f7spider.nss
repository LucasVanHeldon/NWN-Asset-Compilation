void main()
{
    int iTripped = GetLocalInt(OBJECT_SELF, "Tripped");
    object oPC = GetEnteringObject();

    if (!iTripped && GetIsPC(oPC))
    {
        SetLocalInt(OBJECT_SELF, "Tripped", 1);
        object oWP1 = GetObjectByTag("WP_F7");

        CreateObject(OBJECT_TYPE_CREATURE, "monstrousblack", GetLocation(oWP1));
        DelayCommand(3.0, AssignCommand(GetObjectByTag("monstrousblack"),
            ActionCastSpellAtObject(SPELL_WEB, oPC, METAMAGIC_ANY, TRUE)));
    }
}
