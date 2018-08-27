#include "inc_mmp"

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    int nPowers = GetLocalInt(OBJECT_SELF,"nPowers");

    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1011:
         if(GetLastSpellHarmful())
            if(GetIsEnemy(GetLastSpellCaster()))
                MMPC_CastLesserDispelMagic();
        break;
    }
}
