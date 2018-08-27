#include "x0_i0_spawncond"
#include "inc_demons"



void SpecialAttack()
{
    switch(Random(5)+1)
    {
    case 1:
        DEMON_CastChaosHammer();
    case 2:
        DEMON_CastUnholyBlight();
        break;
    case 3:
        DEMON_Teleport();
        break;
    case 4:
        DEMON_CastConfusion();
        break;
    case 5:
        DEMON_CastDispelMagic();
        break;
    }
}

void GateDemons()
{
    SetLocalInt(OBJECT_SELF,"bGated",1);
    ClearAllActions(TRUE);
    ActionCastFakeSpellAtLocation(SPELL_GATE,GetLocation(OBJECT_SELF));
    int num = 0;
    string bp = "";
    int chance = 0;
    switch(d3())
    {
    case 1:
        num = d10(4);
        bp = "dretch";
        chance = 50;
        break;
    case 2:
        num = d2();
        bp = "vrock";
        chance = 50;
        break;
    case 3:
        num = 1;
        bp = "glabrezu";
        chance = 20;
        break;
    }
    int roll = Random(100);
    if(roll < chance)
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
}


void main()
{

    if(GetLocalInt(OBJECT_SELF,"bGated") == 0 && GetCurrentHitPoints() < 20)
    {
        __TurnCombatRoundOn(TRUE);
        GateDemons();
        __TurnCombatRoundOn(FALSE);

    }
    else if(d6() < 3)
    {
        __TurnCombatRoundOn(TRUE);
        SpecialAttack();
        __TurnCombatRoundOn(FALSE);
    }
    if(GetLastSpellHarmful())
    {
        object oSC = GetLastSpellCaster();
        if(d6() < 3)
        {
           __TurnCombatRoundOn(TRUE);
            DEMON_DispelSpellCaster(oSC);
            __TurnCombatRoundOn(FALSE);
        }
    }

}
