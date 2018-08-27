#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "x2_inc_switches"
#include "x0_i0_spawncond"
#include "x3_inc_skin"
#include "inc_ai"
#include "inc_magic"
#include "inc_mmpspells"
#include "inc_mmpspells2"
#include "inc_mmpcast"




void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    int nState = GetLocalInt(OBJECT_SELF,"nState");
    int nDoom  = GetLocalInt(OBJECT_SELF,"nDoom");

    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1002:
        if(nDoom > 3) nState = nState+1;
        SetLocalInt(OBJECT_SELF,"nState",nState);
        switch(nState)
        {
        case 0:
            MMP_Doom(PickEnemy(OBJECT_SELF));
            SetLocalInt(OBJECT_SELF,"nDoom",nDoom+1);
        }
        break;
    case 1011:
        if(d6() < 6) MMPC_CastDispelMagic();
        break;
    default:
        if(d6() == 1) MMP_Doom(PickEnemy(OBJECT_SELF));
        break;
    }

}
