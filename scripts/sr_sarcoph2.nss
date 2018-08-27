void main()
{
    location lTrans = GetLocation(GetObjectByTag("sr_outside_wp2"));
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(oPC);

    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc);
    AssignCommand(oPC,ClearAllActions());
    AssignCommand(oPC, JumpToLocation(lTrans));
}
