// Carrions touch attack

#include "x2_inc_switches"
#include "nw_i0_generic"
#include "ai_inc"

void main()
{
    object oEnemy = bkAcquireTarget();
    if (GetIsObjectValid(oEnemy))
    {
        object oSelf = OBJECT_SELF;
        int i;
        int time = d6(2);
        for(i = 0; i < 8; i++)
        {
            float D = GetDistanceToObject(oEnemy);
            if(D > 0.0 && D < 2.5)
            {

                if(TouchAttackMelee(oEnemy,TRUE))
                {
                    if(!FortitudeSave(oEnemy,13,SAVING_THROW_TYPE_POISON))
                    {
                        effect ePar = EffectParalyze();
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,ePar,oEnemy,RoundsToSeconds(time));
                        effect eVis = EffectVisualEffect(VFX_DUR_PARALYZE_HOLD);
                        ApplyEffectToObject(DURATION_TYPE_TEMPORARY,eVis,oEnemy,RoundsToSeconds(time));
                        oEnemy = PickEnemy(OBJECT_SELF);
                    }
                }
            }

        }

    }
}
