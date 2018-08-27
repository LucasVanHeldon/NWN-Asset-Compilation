// Book of Demons - Gray Slaad
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"


void GRAYSLAAD_Summon()
{

    string bp;
    int num;
    int nChance = 0;
    switch(d3())
    {
    case 1: bp = "NW_SLAADRED"; num = d2(); nChance=40; break;
    case 2: bp = "NW_SLAADBLUE"; num = 1; nChance = 40; break;
    case 3: bp = "NW_SLAADGRAY"; num = 1; nChance = 20;
    }
    int nGated = GetLocalInt(OBJECT_SELF,"nGated");
    if(nGated < 2)
    {
        SetLocalInt(OBJECT_SELF,"nGated",nGated+1);
        ClearAllActions(TRUE);
        ActionCastFakeSpellAtLocation(SPELL_GATE,GetLocation(OBJECT_SELF));
        int chance = Random(100);
        if(chance < nChance)
        {
            int i;
            for(i = 0; i < num; i++)
                EffectSummonCreature(bp,VFX_FNF_SUMMON_MONSTER_1,1.0);
        }
    }
}

void SpecialAttack()
{
    // don't let it interrupt this is fickle
    if(GetCurrentAction(OBJECT_SELF) == ACTION_CASTSPELL) return;
    switch(d6())
    {
    case 1:
        DEMON_CastLightningBolt();
        break;
    case 2:
        DEMON_AnimateObjects();
        break;
    case 3:
        DEMON_ChaosHammer();
        break;
    case 4:
        DEMON_CastDarkness();
        break;
    case 5:
        DEMON_CastDispelMagic();
        break;
    case 6:
        GRAYSLAAD_Summon();
        break;
    default:
        DEMON_CastCauseBlindness();
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
        if(d6() < 5)
        {
            SpecialAttack();
        }
        break;
    case 1006:
        if(d6() < 5)
        {
            SpecialAttack();
        }
        break;
    case 1011:
        if(d6() < 6 && GetLastSpellHarmful()) SpecialAttack();
    }
}
