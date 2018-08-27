void main()
{
    location lTrans = GetLocation(GetObjectByTag("EntryPortal"));
    object oPC = GetPCSpeaker();
    location lLoc = GetLocation(oPC);

    ApplyEffectAtLocation(DURATION_TYPE_PERMANENT, EffectVisualEffect(VFX_IMP_UNSUMMON), lLoc);
    AssignCommand(oPC, ClearAllActions());
    AssignCommand(oPC, JumpToLocation(lTrans));
}
