// Tome of Horrifying Monster - Boggle
// BY Weed Wizard

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

    switch(d4())
    {
    case 1:
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_COLOR_SPRAY,oTarget,METAMAGIC_ANY,TRUE);
        break;
    case 2:
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_CHARM_PERSON,oTarget,METAMAGIC_ANY,TRUE);
        break;
    case 3:
        TurnInvisible();
        break;
    case 4:
        ClearAllActions(TRUE);
        ActionCastSpellAtObject(SPELL_DAZE,oTarget,METAMAGIC_ANY,TRUE);
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
        if(d6() < 3)
        {
            Special();
        }
     }

    }
}
