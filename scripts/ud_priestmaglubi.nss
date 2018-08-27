//::///////////////////////////////////////////////
//:: Default: On User Defined
//:: NW_C2_DEFAULTD
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
//:: Created By: Don Moar
//:: Created On: April 28, 2002
//:://////////////////////////////////////////////
#include "x0_i0_spawncond"
#include "ai_inc"

void Summon(int n, string resref)
{
    effect eEff =  EffectVisualEffect(VFX_IMP_UNSUMMON);
    DelayCommand(0.1,ApplyEffectAtLocation(DURATION_TYPE_INSTANT,eEff,GetLocation(OBJECT_SELF)));
    int i;
    for(i = 0; i < n; i++)
    {
        object oC = CreateObject(OBJECT_TYPE_CREATURE,resref,GetLocation(OBJECT_SELF));
    }
}

void State0()
{
    object oSeen=GetLastPerceived();
    SetLocalInt(OBJECT_SELF,"nCurrentState",1);
    ClearAllActions(TRUE);
    Summon(4+d6(),"giantcentipede");
}

void State1()
{
    int nHold = GetLocalInt(OBJECT_SELF,"nHoldPerson");
    ClearAllActions(TRUE);
    SetLocalInt(OBJECT_SELF,"nCurrentState",2);
    Summon(4+d6(),"gianttick");
}

void State2()
{
    int nHold = GetLocalInt(OBJECT_SELF,"nHoldPerson");
    ClearAllActions(TRUE);
    SetLocalInt(OBJECT_SELF,"nCurrentState",3);
    Summon(3+d6(),"mmp_vampbat");
}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();

    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1002:
    {
        int nState = GetLocalInt(OBJECT_SELF,"nCurrentState");
        SendMessageToPC(GetFirstPC(),"State="+IntToString(nState));
        switch(nState)
        {
        case 0:
            State0();
            break;
        case 1:
            State1();
            break;
        case 2:
            State2();
            break;
        default:
            DetermineCombatRound();
        }
        break;
    }
    case 1003:
        if(d6() < 4)
        {
            ClearAllActions(TRUE);
            ActionCastSpellAtObject(SPELL_INFESTATION_OF_MAGGOTS,FindNearestEnemy(OBJECT_SELF),METAMAGIC_ANY,TRUE);
        }
    }
    return;

}
