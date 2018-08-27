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
void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1002:
        object oSeen=GetLastPerceived();
        if(GetIsPC(oSeen) && GetLastPerceptionSeen())
        {
            if(GetLocalInt(OBJECT_SELF,"bSummons") == 0)
            {
                SetLocalInt(OBJECT_SELF,"bSummons",1);
                int n = d4()*2+1;
                for(i = 0; i < n; i++)
                {
                    CreateObject(OBJECT_TYPE_CREATURE,"NW_WIGHT",GetLocation(OBJECT_SELF));
                }
           }
       }
       break;
    }
    return;

}
