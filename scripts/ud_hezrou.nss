// Book of Demons - Hezrou
// By Weed Wizard

#include "inc_demons"


void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    object oSeen=GetLastPerceived();

    int nCurState = GetLocalInt(OBJECT_SELF,"nCurState");

    switch(nCalledBy)
    {
    case 1002:

        // 60% chance it will use blasphemy
        if(Random(100) < 40)
            break;

        switch(nCurState)
        {
        case 0:
            DEMON_Blasphemy();
            nCurState = nCurState+1;
            SetLocalInt(OBJECT_SELF,"nCurState",nCurState);
            break;
        case 1:
            switch(d2())
            {
            case 1:
                DEMON_CastUnholyBlight();
                break;
            case 2:
                DEMON_CastChaosHammer();
                break;
            }
            nCurState = nCurState+1;
            SetLocalInt(OBJECT_SELF,"nCurState",nCurState);
            break;
        case 2:
            DetermineCombatRound();
            break;
        }
        break;
    }
}
