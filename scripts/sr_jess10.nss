void main()
{
    location lTrans = GetLocation(GetObjectByTag("keep_guild_wp1"));
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(oPC);

    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc);
    AssignCommand(oPC, JumpToLocation(lTrans));

}
