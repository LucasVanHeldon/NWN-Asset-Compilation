// Demonic Template
// By Weed Wizard

#include "inc_demons"

void DEMONIC_SpellCast(object oTarget)
{
    if(!GetIsObjectValid(oTarget))
        oTarget = PickEnemy(OBJECT_SELF);

    switch(d3())
    {
    case 1:
        SendMessageToPC(GetFirstPC(),"Darkeness");
        DEMON_CastDarkness();
        break;
    case 2:
        SendMessageToPC(GetFirstPC(),"Dispel");
        DEMON_DispelSpellCaster();
        break;
    case 3:
        SendMessageToPC(GetFirstPC(),"Teleport");
        DEMON_Teleport();
        break;

    }
}


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();


    switch(nCalledBy)
    {
    case 1011:

            if(GetLastSpellHarmful())
                DEMONIC_SpellCast(GetLastSpellCaster());
            break;

        break;

    }
}
