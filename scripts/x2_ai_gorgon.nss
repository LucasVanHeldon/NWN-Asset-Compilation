#include "x0_i0_spawncond"
#include "ai_inc"

void main()
{
      object oSeen=FindNearestEnemy(OBJECT_SELF);
      object oMax = MaximizeCone(15.0);
      object oNear = FindNearestEnemy(OBJECT_SELF);
      float D = GetDistanceToObject(oNear);
      if(D > 2.0 && D < 15.0 && d6() < 3)
      {
        if(!GetIsObjectValid(oMax)) oMax = oSeen;
        if(!GetHasEffect(EFFECT_TYPE_PETRIFY,oMax))
        {
            __TurnCombatRoundOn(TRUE);
            ActionCastSpellAtObject(SPELLABILITY_BREATH_PETRIFY,oMax,METAMAGIC_ANY,TRUE);
            __TurnCombatRoundOn(FALSE);
        }
    }
}
