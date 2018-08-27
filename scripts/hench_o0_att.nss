#include "hench_i0_ai"
#include "hench_i0_equip"


void main()
{
    object oIntruder = GetLocalObject(OBJECT_SELF, HENCH_AI_SCRIPT_INTRUDER_OBJ);
    DeleteLocalObject(OBJECT_SELF, HENCH_AI_SCRIPT_INTRUDER_OBJ);

    HenchEquipDefaultWeapons();
    ActionAttack(oIntruder);
}
