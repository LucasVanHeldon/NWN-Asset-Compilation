void main()
{
//    EffectVisualEffect
    AssignCommand(OBJECT_SELF, ActionCastFakeSpellAtObject(SPELL_SUNBEAM, OBJECT_SELF));
    DelayCommand(2.0, DestroyObject(OBJECT_SELF));
}
