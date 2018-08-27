void ActionCreate(string sCreature, location lLoc)
{
    CreateObject(OBJECT_TYPE_CREATURE, sCreature, lLoc);
}
void main()
{
    object oCreature = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR, PLAYER_CHAR_IS_PC);
    if (GetIsObjectValid(oCreature) == TRUE && GetDistanceToObject(oCreature) < 10.0)
    {
        effect eMind = EffectVisualEffect(VFX_FNF_SUMMON_UNDEAD);
        string sCreature = "CryptSkeleton";

        location lLoc = GetLocation(OBJECT_SELF);
        DelayCommand(0.3, ActionCreate(sCreature, lLoc));
        ApplyEffectAtLocation(DURATION_TYPE_INSTANT, eMind, GetLocation(OBJECT_SELF));
        SetPlotFlag(OBJECT_SELF, FALSE);
        DestroyObject(OBJECT_SELF, 0.5);
    }
}
