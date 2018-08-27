#include "x0_i0_spawncond"
#include "inc_demons"

int DEMON_CastBladeBarrier(object oTarget= OBJECT_INVALID)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = FindNearestEnemyWithoutEffect(OBJECT_SELF,EFFECT_TYPE_DOMINATED);
    if(!GetIsObjectValid(oTarget) || GetCurrentHitPoints(oTarget) <= 0)
        oTarget = PickEnemy(OBJECT_SELF);

    if(GetIsObjectValid(oTarget) || GetCurrentHitPoints(oTarget) > 0)
    {
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_BLADE_BARRIER,oTarget,METAMAGIC_ANY,TRUE);
        return TRUE;
    }
    else
    {

        ClearAllActions(TRUE);
        float fFace = GetFacing(OBJECT_SELF);
        vector vPos = GetPosition(OBJECT_SELF);
        vector fAng;
        fAng.x = cos(fFace) * 2.0;
        fAng.y = cos(fFace) * 2.0;

        vPos.x = vPos.x + fAng.x;
        vPos.y = vPos.y + fAng.y;

        location lLoc = Location(GetArea(OBJECT_SELF),vPos,fFace);

        ActionCastSpellAtLocation(SPELL_BLADE_BARRIER,lLoc,METAMAGIC_ANY,TRUE);
        return TRUE;
    }
    return FALSE;
}

void DEMON_BladeBarrier()
{
    switch(d3())
    {
    case 1:
        DEMON_CastBladeBarrier(FindRangedEnemy());
        break;
    case 2:
        DEMON_CastBladeBarrier(FindSpellCasterEnemy());
        break;
    case 3:
        DEMON_CastBladeBarrier();
        break;
    }
}

void SpecialAttack()
{
    switch(d2())
    {
    case 1: DEMON_Teleport(); break;
    case 2: DEMON_BladeBarrier(); break;
    }
}



void Gate(string bp, int num)
{
    effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
    int i;
    for(i = 0; i < num; i++)
    {
        object oD = CreateObject(OBJECT_TYPE_CREATURE,bp,GetLocation(OBJECT_SELF));
        // summons can't gate
        SetLocalInt(oD,"bGated",1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(OBJECT_SELF));
    }
}

int GateDemons()
{
    if(    Random(100) < 50)
    {
        switch(d2())
        {
        case 1:
            Gate("dretch",d10(4));
            break;
        case 2:
            Gate("hezrou",d4());
            break;
        }
        ClearAllActions(TRUE);
        ActionCastFakeSpellAtLocation(SPELL_GATE,GetLocation(OBJECT_SELF));
        return TRUE;
    }
    return FALSE;
}


void main()
{
    object oSC = GetLastSpellCaster();
    if( GetCurrentHitPoints(OBJECT_SELF) < 20)
    {
        if(!GateDemons())
            if(d6() < 3)
            {
                __TurnCombatRoundOn(TRUE);
                SpecialAttack();
                __TurnCombatRoundOn(FALSE);
            }
    }
    else if(d6() < 3)
    {
        __TurnCombatRoundOn(TRUE);
        SpecialAttack();
        __TurnCombatRoundOn(FALSE);
    }

}
