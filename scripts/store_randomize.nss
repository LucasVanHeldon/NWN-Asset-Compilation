#include "lutes"
#include "nw_i0_plot"
void main()
{
    object oStore = OBJECT_SELF;
    oObject = oStore;

    int i;
    ExecuteScript("nw_d1_startstore",OBJECT_SELF);
    for(i = 0; i < 5; i++)
    {
        iChestLevel = Random(10)+1;
        switch(d6())
        {
        case 1: PlaceWeapon(1); break;
        case 2: PlaceRangedWeapon(1); break;
        case 3: PlaceAmmo(1); break;
        case 4: PlaceArmor(1); break;
        case 5: PlaceShield(1); break;
        case 6: PlaceHelmet(1); break;
        }
    }


}
