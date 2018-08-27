#include "x2_inc_switches"
#include "nw_i0_generic"
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



void main()
{
    object oEnemy = bkAcquireTarget();
    if(GetIsObjectValid(oEnemy) && d6() < 3)
    {
         __TurnCombatRoundOn(TRUE);
        SpecialAttack();
         __TurnCombatRoundOn(FALSE);
    }
    else if(GetLocalInt(OBJECT_SELF,"nSpellID") == 1)
    {
        SetLocalInt(OBJECT_SELF,"nSpellID",0);
        __TurnCombatRoundOn(TRUE);
        DEMON_GreaterDispel(GetLocalObject(OBJECT_SELF,"SpellCaster"));
         __TurnCombatRoundOn(FALSE);

    }


}
