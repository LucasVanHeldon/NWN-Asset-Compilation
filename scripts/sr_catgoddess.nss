void main()
{
    if (GetLocalInt(GetModule(), "Werewolf Death") == 1) {
        location lCat = GetLocation(GetObjectByTag("FelineStatue"));
        location lJump = GetLocation(GetObjectByTag("RESPAWNPOINT"));
        AssignCommand(GetObjectByTag("FelineStatue"), JumpToLocation(lJump));
        DestroyObject(GetObjectByTag("FelineStatue"));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, EffectVisualEffect(VFX_FNF_SUMMON_CELESTIAL), lCat);
        CreateObject(OBJECT_TYPE_CREATURE, "CatGoddess", lCat, TRUE);
        SetLocalInt(GetModule(), "Werewolf Death", 2);
    }
}
