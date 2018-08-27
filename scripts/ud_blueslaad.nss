// Book of Demons - Blue Slaad
// By Weed Wizard

#include "x0_i0_spawncond"
#include "inc_demons"


void SpecialAttack()
{
    DEMON_CastHoldPerson();
}


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();


    switch(nCalledBy)
    {
    case 1003:
        if(d6() < 3)
        {
            SpecialAttack();
        }
        break;
    case 1006:
        if(d6() < 3)
        {
            SpecialAttack();
        }
        break;
    case 1011:
        if(d6() < 6 && GetLastSpellHarmful()) SpecialAttack();
    }
}
