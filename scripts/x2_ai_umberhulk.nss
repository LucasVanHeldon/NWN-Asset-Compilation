#include "x0_i0_spawncond"
#include "ai_inc"


void main()
{
      object oMax = MaximizeCone(15.0);
      object oNear = FindNearestEnemy(OBJECT_SELF);
      float D = GetDistanceToObject(oNear);
      if(( D > 0.0 && D < 15.0 ) && d6() < 3)
      {
        if(!GetIsObjectValid(oMax)) oMax = FindNearestEnemy(OBJECT_SELF);
        if(!GetHasEffect(EFFECT_TYPE_CONFUSED,oMax))
        {
            ClearAllActions(TRUE);
            ActionCastSpellAtObject(SPELLABILITY_GAZE_CONFUSION,oMax,METAMAGIC_ANY,TRUE);
        }
      }

}
