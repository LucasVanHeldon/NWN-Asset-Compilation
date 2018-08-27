// Book of Demons - Blue Slaad
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"

/// this keeps the AI from using it retardly
// by having them all scream the moment they see an enemy.
int ScoreHowl(object oTarget)
{
    int score = 0;
    if(GetIsEnemy(oTarget)) score = score + 1;
    if(!GetHasEffect(EFFECT_TYPE_STUNNED,oTarget)) score = score + 1;
    if(GetDistanceToObject(oTarget) < 5.0) score = score + 5;
    if(GetDistanceToObject(oTarget) < 3.0) score = score + 10;
    if(GetDistanceToObject(oTarget) < 15.0) score = score + 1;
    if(FindStrongestEnemy(OBJECT_SELF) == oTarget) score = score + 1;
    return score;
}

void DEMON_CastStunningHowl()
{
    object oTarget = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    object oBest = OBJECT_INVALID;
    while(GetIsObjectValid(oTarget))
    {
        int n = ScoreHowl(oTarget);
        if(n > score)
        {
            score = n;
            oBest = oTarget;
        }
        oTarget = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(GetIsObjectValid(oBest))
    {
        SetLocalInt(OBJECT_SELF,"bHowl",1);
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_HOWL_STUN,oBest,METAMAGIC_ANY,TRUE);
    }
}

void SpecialAttack()
{
        if(GetLocalInt(OBJECT_SELF,"bHowl")==0)
        {

            DEMON_CastStunningHowl();
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
