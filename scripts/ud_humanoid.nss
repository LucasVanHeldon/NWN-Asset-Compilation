// Goblin with Morale Check and weapon swap
// OnDamaged can cause goblin to become afraid and attempt to flee

#include "x0_i0_spawncond"
#include "ai_inc"

// goblins are cowardly and will flee if losing
// if this fails it just places a fear effect on it
void MoraleCheck(object oC = OBJECT_SELF)
{
    int willsave = GetWillSavingThrow(oC);
    int DC = 8;
    if( !WillSave(oC, DC, SAVING_THROW_TYPE_FEAR) )
    {
        effect eFear = EffectFrightened();
        effect eVis = EffectVisualEffect(VFX_IMP_FEAR_S);
        effect eLink = EffectLinkEffects(eVis,eFear);
        float fDur = RoundsToSeconds(d6());
        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eLink,oC, fDur);
    }
}

void RangeAttack(object oTarget)
{
    ClearAllActions(TRUE);
    if(d6() < 4) oTarget=FindWeakestEnemy(OBJECT_SELF);
    AssignCommand(OBJECT_SELF,ActionEquipMostDamagingRanged(oTarget));
    DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionAttack(oTarget)));
}

void MeleeAttack(object oTarget)
{
    ClearAllActions(TRUE);
    if(d6() < 4) oTarget=FindWeakestEnemy(OBJECT_SELF);
    AssignCommand(OBJECT_SELF,ActionEquipMostDamagingMelee(oTarget,TRUE));
    DelayCommand(3.0,AssignCommand(OBJECT_SELF,ActionAttack(oTarget)));
}


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here

    object oPercep=OBJECT_INVALID;
    object oNear = FindNearestEnemy(OBJECT_SELF);
    if( !GetIsObjectValid(oNear) ) oPercep = oNear;
    if(d6() < 4) oPercep=FindWeakestEnemy(OBJECT_SELF);

    if(!GetIsObjectValid(oPercep)) return;
    float D = GetDistanceToObject(oNear);



    switch(nCalledBy)
    {

    case 1003:
        if(D > 5.0)
        {
            ClearAllActions(TRUE);
            RangeAttack(oNear);
        }
        break;

    case 1006:
        //MoraleCheck();
        break;
    }
}
