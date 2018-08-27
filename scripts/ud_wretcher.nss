// Tome of Horrifying Monsters
// Wretcher
// By Weed Wizard

#include "x0_i0_spawncond"
#include "ai_inc"

void DoVomitDmg(object oTarget)
{
    int reflex = ReflexSave(oTarget,15,SAVING_THROW_TYPE_DISEASE);
    if(reflex)
    {
        effect eDisease = EffectDisease(DISEASE_BLINDING_SICKNESS);
        effect eVis = EffectVisualEffect(VFX_IMP_DISEASE_S);
        effect eLink = EffectLinkEffects(eVis,eDisease);
        DelayCommand(7.5,ApplyEffectToObject(DURATION_TYPE_PERMANENT, eLink, oTarget));
    }
}

void Vomit(object oTarget)
{
    ClearAllActions(TRUE);
    ActionCastFakeSpellAtObject(SPELL_MESTILS_ACID_BREATH,oTarget);
    object oHit = GetFirstObjectInShape( SHAPE_CONE, 6.0, GetLocation(oTarget));
    while(GetIsObjectValid(oHit))
    {
        DoVomitDmg(oHit);
        oHit = GetNextObjectInShape( SHAPE_CONE, 6.0, GetLocation(oTarget));
    }
}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1003:
        if(d6() == 1)
        {
            object oTarget = FindNearestEnemy(OBJECT_SELF);
            float D = GetDistanceToObject(oTarget);
            if(D < 4.0)
            {
                Vomit(oTarget);
            }
        }
        break;
    }
}
