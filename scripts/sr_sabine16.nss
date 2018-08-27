//::///////////////////////////////////////////////
//:: FileName sr_sabine16
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/23/2002 11:29:35 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 500);
    object oPC = GetFirstPC();
    while (GetIsObjectValid(oPC)) {
        AdjustAlignment(oPC, ALIGNMENT_GOOD, 5);
        oPC = GetNextPC();
    }
    CreateItemOnObject("innerkeepkey", GetPCSpeaker());
}
