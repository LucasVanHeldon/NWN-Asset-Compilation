#include "x0_i0_spawncond"
#include "inc_demons"
#include "inc_mmp"




void EVOLVED_SpecialAttack()
{
    int nEvolve = GetLocalInt(OBJECT_SELF,"nEvolve");
    if(nEvolve < (GetHitDice(OBJECT_SELF)/5+1))
    {
        SetLocalInt(OBJECT_SELF,"nEvolve",nEvolve+1);
        switch(d12())
        {
        case 1: MMP_CircleOfDeath(); break;
        case 2: MMP_CloudKill(); break;
        case 3: MMP_Confusion(); break;
        case 4: MMP_Contagion(); break;
        case 5: MMP_CreepingDoom(); break;
        case 6: MMPC_CastDispelMagic(); break;
        case 7: MMP_ImprovedInvisibility(OBJECT_SELF); break;
        case 8: MMP_Haste(OBJECT_SELF); break;
        case 9: MMP_ConeOfColdSA(); break;
        case 10: MMP_HoldMonster(); break;
        case 11: MMP_SeeInvisibility(OBJECT_SELF); break;
        case 12: DEMON_CastUnholyBlight(); break;
        }
    }
}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    default:
        if(GetCurrentAction() == ACTION_CASTSPELL) break;
        if(d6() < 4)
            EVOLVED_SpecialAttack();
        break;
    }
}
