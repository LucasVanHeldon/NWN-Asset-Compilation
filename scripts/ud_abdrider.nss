// Aberration Template

#include "x0_i0_anims"
#include "x0_i0_treasure"
#include "x2_inc_switches"
#include "x0_i0_spawncond"
#include "x3_inc_skin"
#include "inc_ai"
#include "inc_mmp"



void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1011:
        if(d6() < 6) MMPC_CastDispelMagic();
        break;

    }

}
