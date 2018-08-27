#include "inc_mmp"

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    int nPowers = GetLocalInt(OBJECT_SELF,"nPowers");
    object oSC = GetLastSpellCaster();

    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1011:
         if(GetLastSpellHarmful())
            if(GetIsEnemy(oSC))
            switch(d2())
            {
            case 1: MMPC_CastLesserSpellBreach(); break;
            case 2: MMPC_CastDispelMagic(); break;
            }
        break;
    }
}
