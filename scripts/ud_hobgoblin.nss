#include "x0_i0_spawncond"
#include "inc_ai"
#include "inc_blink"
#include "inc_mmp"

void TurnInvisible(object oSelf = OBJECT_SELF)
{
    ClearAllActions(TRUE);
    ActionCastSpellAtObject(SPELL_INVISIBILITY,oSelf,METAMAGIC_ANY,TRUE);
}



void Special()
{
    object oTarget = FindNearestEnemy(OBJECT_SELF);
    float D = GetDistanceToObject(oTarget);

    switch(d3())
    {
    case 1:
        MMP_ColorSpray(oTarget);
        break;
    case 2:
        MMP_CharmPerson(OBJECT_SELF);
        break;
    case 3:
        MMP_Daze(oTarget);
        break;
    }
}

void _Summon(int n, string resref)
{
    effect eEff =  EffectVisualEffect(VFX_IMP_UNSUMMON);
    DelayCommand(0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEff,GetLocation(OBJECT_SELF)));
    int i;
    for(i = 0; i < n; i++)
    {
        object oC = CreateObject(OBJECT_TYPE_CREATURE,resref,GetLocation(OBJECT_SELF));
    }
}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    int nState = GetLocalInt(OBJECT_SELF,"nState");
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1002:
        switch(nState)
        {
        case 0:
            if(d6() == 1)
            {
                _Summon(1,"zep_ape");
            }
            break;
        case 1:
            DetermineCombatRound();
            break;
        }
        SetLocalInt(OBJECT_SELF,"nState",nState+1);
        break;
    case 1003:
     {
        if(d6() < 4)
        {
            Special();
        }
     }

    }
}
