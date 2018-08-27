#include "x0_i0_spawncond"
#include "inc_demons"


void SpecialAttack()
{
    switch(d3())
    {
    case 1:
        SendMessageToPC(GetFirstPC(),"Darkness");
        DEMON_CastDarkness();
        break;
    case 3:
        DEMON_Teleport();
        break;

    }
}

void Gate()
{
    SetLocalInt(OBJECT_SELF,"bGated",1);
    ActionCastFakeSpellAtLocation(SPELL_GATE,GetLocation(OBJECT_SELF));
    int chance = Random(100);
    if(chance < 40)
    {
        effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
        object oD = CreateObject(OBJECT_TYPE_CREATURE,"babau",GetLocation(OBJECT_SELF));
        // summons can't gate
        SetLocalInt(oD,"bGated",1);
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(OBJECT_SELF));
    }
}

void main()
{


    if(GetLocalInt(OBJECT_SELF,"bGated") == 0 && GetCurrentHitPoints() < 20)
    {

        __TurnCombatRoundOn(TRUE);
        Gate();
        __TurnCombatRoundOn(FALSE);

    }
    else if(d6() < 3)
    {
        __TurnCombatRoundOn(TRUE);
        SpecialAttack();
         __TurnCombatRoundOn(FALSE);

    }
}

