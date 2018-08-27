#include "x0_i0_spawncond"
#include "ai_inc"

void main()
{
      object oMax = MaximizeCone(15.0);
      object oNear = FindNearestEnemy(OBJECT_SELF);
      float D = GetDistanceToObject(oNear);
      if(D > 2.0 && D < 15.0 && d6() < 2)
      {
        string sCon = "D="+FloatToString(D);
        SendMessageToPC(GetFirstPC(),sCon);
        if(!GetIsObjectValid(oMax)) oMax = FindNearestEnemy(OBJECT_SELF);
        if(!GetHasEffect(EFFECT_TYPE_PETRIFY,oMax))
        {
            __TurnCombatRoundOn(TRUE);
            ActionCastSpellAtObject(SPELLABILITY_GAZE_PETRIFY,oMax,METAMAGIC_ANY,TRUE);
            __TurnCombatRoundOn(FALSE);
        }
      }

}
