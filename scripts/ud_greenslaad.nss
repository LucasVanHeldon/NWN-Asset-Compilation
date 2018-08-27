// Book of Demons - Green Slaad
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"

int NumEnemiesNearTarget(object oTarget)
{
    int nScore = 0;
    object oI = GetFirstObjectInShape(SHAPE_SPHERE,5.0,GetLocation(oTarget));
    while(GetIsObjectValid(oI))
    {
        if(GetIsEnemy(oI)) nScore = nScore+1;
        if(!GetHasEffect(EFFECT_TYPE_FRIGHTENED,oI)) nScore=nScore+1;
        oI = GetFirstObjectInShape(SHAPE_SPHERE,5.0,GetLocation(oTarget));
    }
    return nScore;
}

int ScoreFear(object oTarget)
{
    int score = 0;
    if(GetIsEnemy(oTarget)) score = score + 1;
    if(!GetHasEffect(EFFECT_TYPE_PARALYZE,oTarget)) score = score + 1;
    if(GetDistanceToObject(oTarget) < 3.0) score = score + 1;
    if(FindStrongestEnemy(OBJECT_SELF) == oTarget) score = score + 1;
    score = score + NumEnemiesNearTarget(oTarget);
    return score;
}

void DEMON_CastFear()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;
    while(GetIsObjectValid(oTarget))
    {
        int n = ScoreFear(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_FEAR,oBest,METAMAGIC_ANY,TRUE);
    }
}

void SpecialAttack()
{
    switch(d4())
    {
    case 1:
        DEMON_CastChaosHammer();
        break;
    case 2:
        DEMON_CastDarkness();
        break;
    case 3:
        DEMON_CastFear();
        break;
    case 4:
        DEMON_CastDispelMagic();
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
    case 1003:
        if(d6() < 3)
        {
            SpecialAttack();
        }
        break;
    case 1006:
        if(d6() < 3 )
        {
            SpecialAttack();
        }
        break;
    case 1011:
        if(d6() < 6 && GetLastSpellHarmful()) SpecialAttack();
    }
}
