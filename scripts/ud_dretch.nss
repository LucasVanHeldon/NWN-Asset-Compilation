// Book of Demons - Babau
// By Weed Wizard

#include "x0_i0_spawncond"
#include "ai_inc"

// this is just because the game engine AI will
// have every single dretch use these special abilities
// the moment they see an enemy. They aren't intelligent anyways.
void SpecialAttack()
{
    if(GetLocalInt(OBJECT_SELF,"nStink") == 0)
    {
        SetLocalInt(OBJECT_SELF,"nStink",1);
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_STINKING_CLOUD,PickEnemy(OBJECT_SELF),METAMAGIC_NONE,TRUE);
    }
    else if(GetLocalInt(OBJECT_SELF,"nScare") == 0)
    {
        SetLocalInt(OBJECT_SELF,"nScare",1);
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_SCARE,PickEnemy(OBJECT_SELF),METAMAGIC_NONE,TRUE);
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
        if(d6() < 3) SpecialAttack();
        break;
    case 1006:
        if(GetLocalInt(OBJECT_SELF,"bGated") == 0)
        {

            SetLocalInt(OBJECT_SELF,"bGated",1);
            ClearAllActions(TRUE);
            ActionCastFakeSpellAtLocation(SPELL_GATE,GetLocation(OBJECT_SELF));
            int chance = Random(100);
            if(chance < 30)
            {
                effect eVis = EffectVisualEffect(VFX_FNF_SUMMON_MONSTER_1);
                object oD = CreateObject(OBJECT_TYPE_CREATURE,"dretch",GetLocation(OBJECT_SELF));
                SetLocalInt(oD,"bGated",1);
                ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eVis,GetLocation(OBJECT_SELF));
            }
        }
        break;

    }
}
