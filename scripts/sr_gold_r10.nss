#include "NW_O2_CONINCLUDE"

void main()
{
    if (GetLocalInt(OBJECT_SELF,"NW_DO_ONCE") != 0)
    {
       return;
    }
    object oLastOpener = GetLastOpener();
    GenerateLowTreasure(oLastOpener, OBJECT_SELF);
    SetLocalInt(OBJECT_SELF,"NW_DO_ONCE",1);
    ShoutDisturbed();
}
