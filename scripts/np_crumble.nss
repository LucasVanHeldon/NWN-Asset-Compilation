void main()
{
 object oPC = GetLastUsedBy();

 DestroyObject(OBJECT_SELF, 1.0);

 FloatingTextStringOnCreature("The body crumples and exposes a wall carving: 'QUASQUETON'", oPC, TRUE);
}
