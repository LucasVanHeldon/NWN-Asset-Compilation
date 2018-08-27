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
                int n = d12();
                for(i = 0; i < n; i++)
                {
                    int x = Random(3);
                    string bp;
                    switch(x)
                    {
                    case 0:
                        bp = "NW_SKELETON";
                        break;
                    case 1:
                        bp = "NW_ZOMBIE01";
                        break;
                    case 2:
                        bp = "NW_ZOMBIE02";
                        break;
                    }
                    CreateObject(OBJECT_TYPE_CREATURE,bp,GetLocation(OBJECT_SELF));
                }
            }
       }
       break;
    }
    return;

}
