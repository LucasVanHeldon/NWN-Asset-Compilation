void main()
{
    location lTrans = GetLocation(GetObjectByTag("RaiseDead_WP"));
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(oPC);

    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc);
    AssignCommand(oPC, JumpToLocation(lTrans));
}
