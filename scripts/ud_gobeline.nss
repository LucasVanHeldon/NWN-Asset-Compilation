// Tome of Horrifying Monster - Boggle
// BY Weed Wizard

#include "x0_i0_spawncond"
#include "inc_ai"
#include "inc_demons"
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
        MMP_DancingLights();
        break;
    case 2:
        ClearAllActions(TRUE);
        MMP_Invisibility(OBJECT_SELF);
        break;
    case 3:
        DEMON_CastDispelMagic();
        break;
    }
}

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1003:
     {
        if(d6() == 1)
        {
            Special();
        }
     }

    }
}
