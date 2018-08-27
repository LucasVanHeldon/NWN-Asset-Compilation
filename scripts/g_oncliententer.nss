#include "g_common"

void main() {
    object oTarget = GetEnteringObject();

    // Start PC-Only Systems
    if (GetIsObjectValid(oTarget) && GetIsPC(oTarget) && !GetIsDM(oTarget)) {
        FoodSys_Initialize(oTarget);    // Start the Food System on the PC
        TorchLight_Initialize(oTarget); // Start the Torch Light System on the PC
        Treasure_GoldForClassAdjust(oTarget);
        Curse_CheckForCurses(oTarget);
    }
}
