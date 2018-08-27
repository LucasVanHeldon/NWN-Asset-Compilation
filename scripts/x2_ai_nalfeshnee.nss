#include "x0_i0_spawncond"

#include "inc_demons"


void SpecialAttack()
{
    object oEnemy = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    switch(d6())
    {
    case 1: DEMON_Teleport(); break;
    case 2: DEMON_CastFeebleMind(); break;
    case 3: DEMON_CastSlow(); break;
    case 4: DEMON_CastCallLightning(); break;
    case 5: DEMON_CastGreaterDispel(); break;
    case 6: DEMON_CastSmite(); break;
    }
}


// doesn't work right now.
void NALFESHNEE_SpecialAttack()
{
    object oEnemy = GetFirstObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    int score = 0;
    int nBest = -1;

    while(GetIsObjectValid(oEnemy))
    {
        int n = ScoreFeebleMind(oEnemy);
        if(n > score) { score = n; nBest = 2;}
        n = ScoreSlow(oEnemy);
        if(n > score) { score = n; nBest = 3;}
        n = ScoreCallLightning(oEnemy);
        if(n > score) { score = n; nBest = 4;}
        n = ScoreDispelMagic(oEnemy);
        if(n > score) { score = n; nBest = 5;}
        n = ScoreSmite(oEnemy);
        if(n > score) { score = n; nBest = 6;}

        // 30% chance of teleportation
        if(Random(100) < 30) DEMON_Teleport();

        oEnemy = GetNextObjectInShape(SHAPE_SPHERE,30.0,GetLocation(OBJECT_SELF));
    }
    if(nBest > 1)
    {
        switch(nBest)
        {
        case 2: DEMON_CastFeebleMind(); break;
        case 3: DEMON_CastSlow(); break;
        case 4: DEMON_CastCallLightning(); break;
        case 5: DEMON_CastGreaterDispel(); break;
        case 6: DEMON_CastSmite(); break;
        default: DEMON_Teleport(); break;
        }
    }
    else
    {
        switch(d6())
        {
        case 1: DEMON_Teleport(); break;
        case 2: DEMON_CastFeebleMind(); break;
        case 3: DEMON_CastSlow(); break;
        case 4: DEMON_CastCallLightning(); break;
        case 5: DEMON_CastGreaterDispel(); break;
        case 6: DEMON_CastSmite(); break;
        }
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
    if(Random(100) < 50)
    {
        switch(d3())
        {
        case 1:
            Gate("vrock",d4());
            break;
        case 2:
            Gate("hezrou",d4());
            break;
        case 3:
            Gate("glabrezu",1);
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
        __TurnCombatRoundOn(TRUE);
        if(!GateDemons())
            if(d6() < 3) SpecialAttack();
        __TurnCombatRoundOn(FALSE);
    }
    else if(GetLastSpellHarmful() && GetIsEnemy(oSC))
    {
       __TurnCombatRoundOn(TRUE);
       DEMON_DispelSpellCaster(oSC);
       __TurnCombatRoundOn(FALSE);
    }

    else if(d6() < 3)
    {
        __TurnCombatRoundOn(TRUE);
        SpecialAttack();
        __TurnCombatRoundOn(FALSE);
    }
}
