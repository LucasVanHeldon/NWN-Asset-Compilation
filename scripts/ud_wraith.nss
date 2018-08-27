// Wraith
// Touch attack 1d4 constitution (stack)
// By Weed Wizard

#include "x0_i0_spawncond"
#include "ai_inc"

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
       case 1003:
       {

            object oTarget = FindNearestEnemy(OBJECT_SELF);
            float D = GetDistanceToObject(oTarget);
            effect eDrain = GetFirstEffect(oTarget);
            effect eVis = EffectVisualEffect(VFX_COM_HIT_NEGATIVE);

            if(D > 0.0 && D < 5.0)
            {
                if(TouchAttackMelee(oTarget,TRUE))
                {
                    SendMessageToPC(GetFirstPC(),"Touch Attack");

                    int bFound = FALSE;
                    int nCon = GetLocalInt(OBJECT_SELF,"eCon");
                    while(GetIsEffectValid(eDrain))
                    {
                        if(GetEffectType(eDrain) == EFFECT_TYPE_ABILITY_DECREASE)
                        {

                            nCon = nCon + d4();
                            RemoveEffect(OBJECT_SELF,eDrain);
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                            ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                                                SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,nCon)),
                                                oTarget);
                            bFound = TRUE;
                            break;
                        }
                        eDrain = GetNextEffect(oTarget);
                    }
                    if(!bFound)
                    {
                            nCon = nCon + d4();
                            ApplyEffectToObject(DURATION_TYPE_INSTANT,eVis,oTarget);
                            ApplyEffectToObject(DURATION_TYPE_PERMANENT,
                                                SupernaturalEffect(EffectAbilityDecrease(ABILITY_CONSTITUTION,nCon)),
                                                oTarget);
                    }
                }
            }
        }
        break;
    }
}
