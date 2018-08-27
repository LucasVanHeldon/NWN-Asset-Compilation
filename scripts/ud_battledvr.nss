// Battle Devourer
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"


void BTLDEVOUR_Dominate(object oTarget = OBJECT_INVALID)
{

    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_DOMINATED);

    if(GetIsObjectValid(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DOMINATE_MONSTER,oTarget,METAMAGIC_ANY,TRUE);
    }
    else DetermineCombatRound();
}

void BTLDEVOUR_Fear(object oTarget = OBJECT_INVALID)
{

    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_FRIGHTENED);

    if(!GetIsObjectValid(oTarget))
        PickEnemy(oTarget);

    if(GetIsObjectValid(oTarget) && GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELLABILITY_GAZE_FEAR,oTarget,METAMAGIC_ANY,TRUE);
    }
    else DetermineCombatRound();
}



void SpecialAttack()
{
    switch(d2())
    {
    case 1:
        SendMessageToPC(GetFirstPC(),"Battle Devourer uses Domination");
        BTLDEVOUR_Dominate();
        break;
    case 2:
        SendMessageToPC(GetFirstPC(),"Battle Devourer uses gaze of fear");
        BTLDEVOUR_Fear();
        break;

    }
}

void SpellCast(object oTarget)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    switch(d2())
    {
    case 1:
        SendMessageToPC(GetFirstPC(),"Battle Devourer uses Domination");
        BTLDEVOUR_Dominate(oTarget);
        break;
    case 2:
        SendMessageToPC(GetFirstPC(),"Battle Devourer uses gaze of fear");
        BTLDEVOUR_Fear(oTarget);
        break;

    }

}


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();
    int nState = GetLocalInt(OBJECT_SELF,"nState");
    object oNear = FindNearestEnemy(OBJECT_SELF);
    float D = GetDistanceToObject(oNear);

    switch(nCalledBy)
    {
    case 1002:
        ClearAllActions(TRUE);
        SpecialAttack();
        break;

    case 1003:
    case 1006:
        if(d6() < 3)
        {
            SpecialAttack();
        }
        break;
    case 1011:

        object oSC = GetLastSpellCaster();
        if( d6() < 3 )
        {
            SpellCast(oSC);
        }
        break;
    }
}
