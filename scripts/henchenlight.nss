#include "hench_i0_equip"

void main()
{
    HenchSetAssociateInt(sHenchLightOffHand, TRUE);
    ClearWeaponStates();
    HenchEquipDefaultWeapons(OBJECT_SELF, TRUE);
}
