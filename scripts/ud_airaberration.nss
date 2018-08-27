// Aberration Template
#include "inc_mmp"

void main()
{
    int i;
    int nCalledBy = GetUserDefinedEventNumber();
    // enter desired behaviour here
    switch(nCalledBy)
    {
    case 1011:
        MMPC_CastDispelMagic();
        break;

    }

}
