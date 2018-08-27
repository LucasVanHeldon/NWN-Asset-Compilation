//#include "sr_i0_tools"

void main()
{
    object oPC = GetLastOpenedBy();
    effect eCurse = EffectCurse(2,0,2,0,0,0);

    if (GetIsPC(oPC))
        if (!WillSave(oPC, 12))
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, eCurse, oPC, HoursToSeconds(12));
}
