// Meenlock
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"

void MEENLOCK_RendMind(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_FRIGHTENED);

    if(GetIsObjectValid(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        if(!WillSave(oTarget,14,SAVING_THROW_TYPE_FEAR))
        {
            effect eDrain = EffectAbilityDecrease(ABILITY_WISDOM,d4());
            eDrain = SupernaturalEffect(eDrain);

            effect eVis  = EffectVisualEffect(VFX_DUR_MIND_AFFECTING_FEAR);
            ApplyEffectToObject(DURATION_TYPE_INSTANT,eDrain,oTarget);
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oTarget,2.0);
        }
    }
}

void SpecialAttack()
{
    switch(d3())
    {
    default:
        SendMessageToPC(GetFirstPC(),"Meenlock is using Rend Mind");
        MEENLOCK_RendMind();
        break;
    }
}

void SpellCast(object oTarget)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    switch(d3())
    {
    default:
       SendMessageToPC(GetFirstPC(),"Meenlock is using Rend Mind");
       MEENLOCK_RendMind(oTarget);
       break;
    }
}


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();


    switch(nCalledBy)
    {
    case 1011:
        object oSC = GetLastSpellCaster();
        if( d6() < 4 )
        {
            SpellCast(oSC);
        }
        break;
    }
}
