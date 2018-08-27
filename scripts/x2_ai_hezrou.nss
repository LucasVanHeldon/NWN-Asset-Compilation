#include "x0_i0_spawncond"
#include "inc_demons"


void SpecialAttack()
{
    switch(d4())
    {
    case 1:
        DEMON_Blasphemy();
        break;
    case 2:
        DEMON_CastChaosHammer();
        break;
    case 3:
        DEMON_CastUnholyBlight();
        break;
    case 4:
        DEMON_Teleport();
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
    switch(d2())
    {
    case 1:
        num = d10(4);
        bp = "dretch";
        chance = 35;
        break;
    case 2:
        num = 1;
        bp = "hezrou";
        chance = 35;
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
   object oSC = GetLastSpellCaster();

   if(GetLocalInt(OBJECT_SELF,"bGated") == 0 && GetCurrentHitPoints() < 20)
    {
   __TurnCombatRoundOn(TRUE);
        GateDemons();
   __TurnCombatRoundOn(FALSE);
    }
    else if( d6() < 3 && GetLastSpellHarmful())
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
