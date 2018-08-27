#include "x2_inc_switches"

void main()
{
     int nSpell=GetSpellId();
     int nSpellDC=GetSpellSaveDC();
     int nCastLevel=GetCasterLevel(OBJECT_SELF);
     object oTarget = GetSpellTargetObject();
     switch (nSpell)
     {
        case SPELL_BLESS:
        case SPELL_PRAYER:
            SignalEvent(oTarget, EventSpellCastAt(OBJECT_SELF, nSpell, TRUE));
            break;
     } // end switch statement
}

