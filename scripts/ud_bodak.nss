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
          object oMax = MaximizeCone(15.0);
          object oNear = FindNearestEnemy(OBJECT_SELF);
          float D = GetDistanceToObject(oNear);
          if(D > 2.0 && D <= 15.0)
          {
            string sCon = "D="+FloatToString(D);
            SendMessageToPC(GetFirstPC(),sCon);
            if(!GetIsObjectValid(oMax)) oMax = oSeen;
            ClearAllActions(TRUE);
            ActionCastSpellAtObject(SPELLABILITY_GAZE_DEATH,oMax,METAMAGIC_ANY,TRUE);
          }
        }
        break;
    }
    case 1005:
        if(d6()==1)
        {
            ClearAllActions(TRUE);
            ActionCastSpellAtObject(SPELLABILITY_GAZE_DEATH,FindNearestEnemy(OBJECT_SELF),METAMAGIC_ANY,TRUE);
        }
        break;
    }
}
