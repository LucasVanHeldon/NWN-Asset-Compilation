void main()
{
    location lTrans = GetLocation(GetObjectByTag("sr_outside_wp2"));
    object oPC = GetLastUsedBy();
    location lLoc = GetLocation(oPC);

    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc);
    AssignCommand(oPC, JumpToLocation(lTrans));
}
