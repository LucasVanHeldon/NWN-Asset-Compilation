void main()
{
 object oPC = GetLastUsedBy();
 DestroyObject(OBJECT_SELF, 1.0);
 FloatingTextStringOnCreature("As you touch the gems and jewels, the illusion is dispelled.", oPC);
}
