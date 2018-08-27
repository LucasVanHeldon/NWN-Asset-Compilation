void main()
{
    object oPC = GetEnteringObject();
    ActionCastSpellAtObject(SPELL_WEB, oPC);
    FloatingTextStringOnCreature("A huge spider descends from the ceiling to attack!", oPC);
}
