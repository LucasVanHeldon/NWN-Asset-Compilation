
#include "x0_i0_spawncond"
#include "inc_ai"
#include "inc_magic"
#include "inc_mmp"


void MMP_Attack()
{
    object oC = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    object oBest = OBJECT_INVALID;
    int score = 0;

    while(GetIsObjectValid(oC))
    {
        if(GetIsEnemy(oC))
        {
            if(GetHasEffect(EFFECT_TYPE_ENTANGLE,oC))
            {
                if(IsMagicUser(oC) && score < 5)
                {
                    oBest = oC;
                    score = 5;
                }
                if(IsCleric(oC) && score < 3)
                {
                    oBest = oC;
                    score = 3;
                }
                if(GetCurrentHitPoints(oC) <= 10 && score < 10)
                {
                    oBest = oC;
                    score = 10;
                }
                if(score < 1)
                {
                    oBest = oC;
                    score = 1;
                }
            }
        }
        oC = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        ClearAllActions(TRUE);
        ActionAttack(oBest);
    }
}

void MMP_CastWeb(object oTarget = OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_ENTANGLE);

    if(GetIsObjectValid(oTarget) && GetDistanceToObject(oTarget) > 5.0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_WEB,oTarget,METAMAGIC_ANY,TRUE);
    }
}


void main()
{

    if(d6() < 3)
    {
        __TurnCombatRoundOn(TRUE);
        switch(d2())
        {
        case 1:
            MMP_CastWeb();
            break;
        case 2:
            MMP_Attack();
        }
        __TurnCombatRoundOn(FALSE);
    }

}
