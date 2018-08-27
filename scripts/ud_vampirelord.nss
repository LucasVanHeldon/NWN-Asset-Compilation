//::///////////////////////////////////////////////
//:: Default: On User Defined
//:: NW_C2_DEFAULTD
//:: Copyright (c) 2002 Bioware Corp.
//:://////////////////////////////////////////////
/*
    Determines the course of action to be taken
    on a user defined event.
*/
//:://////////////////////////////////////////////
//:: Created By: Don Moar
//:: Created On: April 28, 2002
//:://////////////////////////////////////////////
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
                int n = d12();
                for(i = 0; i < n; i++)
                {
                    int x = Random(5);
                    string bp;
                    switch(x)
                    {
                    case 0:
                        bp = "NW_CURST000";
                        break;
                    case 1:
                        bp = "NW_CURST001";
                        break;
                    case 2:
                        bp = "NW_CURST002";
                        break;
                    case 3:
                        bp = "NW_CURST003";
                        break;
                    case 4:
                        bp = "NW_CURST004";
                        break;
                    }
                    CreateObject(OBJECT_TYPE_CREATURE,bp,GetLocation(OBJECT_SELF));
                }
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
