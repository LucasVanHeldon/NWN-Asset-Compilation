void main()
{
    int iBlood = GetLocalInt(GetArea(OBJECT_SELF), "Blood");

    if (iBlood>0 && iBlood<10)
        ActionCastSpellAtObject(SPELL_FLAME_LASH, OBJECT_SELF, METAMAGIC_ANY,
                TRUE, 0, PROJECTILE_PATH_TYPE_HIGH_BALLISTIC);
    if (iBlood==10)
        ActionCastSpellAtObject(SPELL_FLAME_STRIKE, OBJECT_SELF, METAMAGIC_ANY, TRUE);
}
