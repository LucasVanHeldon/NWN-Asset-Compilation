//#include "NW_O2_CONINCLUDE"
//#include "NW_I0_GENERIC"

void main()
{
    SetIsDestroyable(FALSE, FALSE, TRUE);
    ApplyEffectToObject(DURATION_TYPE_INSTANT, EffectDeath(), OBJECT_SELF);
}


