void main()
{
    ApplyEffectAtLocation(DURATION_TYPE_INSTANT,
            EffectVisualEffect(VFX_FNF_SUNBEAM), GetLocation(OBJECT_SELF));
    DestroyObject(OBJECT_SELF);
}
