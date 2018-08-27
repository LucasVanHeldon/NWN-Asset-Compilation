#include "inc_mmp"
#include "inc_psychic"

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1011:
        if(d6() < 6) MMPC_CastDispelMagic();
        break;
    default:

        break;


    }

}
