#include "x0_i0_spawncond"
#include "inc_demons"

void SpecialAttack()
{
    switch(Random(5)+1)
    {
    case 1:
        SendMessageToPC(GetFirstPC(),"Insanity");
        DEMON_Insanity();
        break;
    case 2:
        SendMessageToPC(GetFirstPC(),"Greater Dispel");
        DEMON_GreaterDispel();
        break;
    case 3:
        SendMessageToPC(GetFirstPC(),"Dominate");
        DEMON_DominateMonster();
        break;
    case 4:
        DEMON_Teleport();
        break;
    case 5:
        SendMessageToPC(GetFirstPC(),"Blasphemy");
        DEMON_Blasphemy();
        break;

    }
}

void SpellCast(object oTarget)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    switch(d6())
    {
    case 1:
        SendMessageToPC(GetFirstPC(),"Insanity");
        DEMON_Insanity(oTarget);
        break;
    case 2:
        SendMessageToPC(GetFirstPC(),"Power Word: Stun");
        DEMON_PowerWordStun(oTarget);
        break;
    case 3:
        SendMessageToPC(GetFirstPC(),"Dominate");
        DEMON_DominateMonster(oTarget);
        break;
    case 4:
        DEMON_Teleport();
        break;
    case 5:
        SendMessageToPC(GetFirstPC(),"Blasphemy");
        DEMON_Blasphemy();
        break;
    case 6:
        SendMessageToPC(GetFirstPC(),"Greater Dispel");
        DEMON_GreaterDispel(oTarget);
        break;
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

void GateDemons()
{
    Gate("dretch",d10(4));
    Gate("hezrou",d4());
}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();
    int nState = GetLocalInt(OBJECT_SELF,"nState");

    switch(nCalledBy)
    {
    case 1002:
        switch(nState)
        {
        case 0:
            GateDemons();
            break;
        default:
            DetermineCombatRound();
        }
        nState = nState + 1;
        SetLocalInt(OBJECT_SELF,"nState",nState);
        break;

    case 1003:
        break;
    case 1006:
        break;
    case 1011:

        object oSC = GetLastSpellCaster();
        if( GetLastSpellHarmful() && GetIsEnemy(oSC) )
        {
            SetLocalInt(OBJECT_SELF,"nSpellID",1);
            SetLocalObject(OBJECT_SELF,"SpellCaster",oSC);
        }
        break;
    }
}
