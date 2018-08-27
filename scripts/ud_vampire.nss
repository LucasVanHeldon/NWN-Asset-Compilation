#include "x0_i0_spawncond"
#include "ai_inc"

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1002:
    {
        object oSeen=GetLastPerceived();
        if(GetIsPC(oSeen) && GetLastPerceptionSeen())
        {
            if(GetLocalInt(OBJECT_SELF,"bSummons") == 0)
            {
                SetLocalInt(OBJECT_SELF,"bSummons",1);
                int x = Random(2);
                int n = d4(4)+1;
                switch(x)
                {
                case 0:
                    for(i = 0; i < n; i++)
                    {
                        CreateObject(OBJECT_TYPE_CREATURE,"NW_RATDIRE001",GetLocation(OBJECT_SELF));
                    }
                    break;
                case 1:
                    for(i = 0; i < n; i++)
                    {
                        CreateObject(OBJECT_TYPE_CREATURE,"NW_WOLF",GetLocation(OBJECT_SELF));
                    }
                    break;
                }
           }
           else
           {
              object oMax = MaximizeCone(15.0);
              object oNear = FindNearestEnemy(OBJECT_SELF);
              float D = GetDistanceToObject(oNear);
              if(D > 2.0 && D < 15.0)
              {
                string sCon = "D="+FloatToString(D);
                SendMessageToPC(GetFirstPC(),sCon);
                if(!GetIsObjectValid(oMax)) oMax = oSeen;
                if(!GetHasEffect(EFFECT_TYPE_DOMINATED,oMax))
                {
                    ClearAllActions(TRUE);
                    ActionCastSpellAtObject(SPELLABILITY_GAZE_DOMINATE,oMax,METAMAGIC_ANY,TRUE);
                }
              }
            }
       }
       break;
       }
       case 1005:
        {
            object oTarget = FindNearestEnemy(OBJECT_SELF);
            if(!GetIsObjectValid(oTarget)) break;
            if(d6()==1 && !GetHasEffect(EFFECT_TYPE_DOMINATED,oTarget))
            {
                ClearAllActions(TRUE);
                ActionCastSpellAtObject(SPELLABILITY_GAZE_DOMINATE,oTarget,METAMAGIC_ANY,TRUE);
            }
        }
    }
    return;

}
