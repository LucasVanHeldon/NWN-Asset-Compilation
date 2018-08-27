void main()
{
    int iBlood = GetLocalInt(OBJECT_SELF, "Blood");
    int iShrine = GetLocalInt(OBJECT_SELF, "Shrine");
    object oPC;

    if (iBlood>0 && iBlood<10) {
        location lLoc = GetLocation(GetObjectByTag("K3_Blood"+IntToString(iBlood)));
        CreateObject(OBJECT_TYPE_PLACEABLE, "plc_bloodstain", lLoc);
        iBlood++;
        SetLocalInt(OBJECT_SELF, "Blood", iBlood);
        if (iBlood==10) {
            oPC = GetFirstPC();
            while (GetIsObjectValid(oPC)) {
                AddJournalQuestEntry("coc_q4_blood", 99, oPC);
                oPC = GetNextPC();
            } // while
        }
    } // blood
    if (iShrine>0 && iShrine<20) {
        iShrine++;
        SetLocalInt(OBJECT_SELF, "Shrine", iShrine);
        if (iShrine==20) {
            oPC = GetFirstPC();
            while (GetIsObjectValid(oPC)) {
                AddJournalQuestEntry("coc_q5_shrine", 99, oPC);
                oPC = GetNextPC();
                DestroyObject(GetObjectByTag("KScreamWomen1"));
                DestroyObject(GetObjectByTag("KScreamWomen2"));
            } // while
        }
    } // shrine

    // K10 Room of Fire
    oPC = GetFirstPC();
    effect eFire;
    while (GetIsObjectValid(oPC)) {
        eFire = EffectDamage(d6(), DAMAGE_TYPE_FIRE, DAMAGE_POWER_ENERGY);
        if (GetLocalInt(oPC, "K10Fire"))
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, oPC);
        if (GetLocalInt(GetHenchman(oPC), "K10Fire"))
            ApplyEffectToObject(DURATION_TYPE_INSTANT, eFire, GetHenchman(oPC));
        oPC = GetNextPC();
    }
    if (d100()==1)
        SoundObjectStop(GetObjectByTag("ZombieMoansK4"));
    if (d4()==1) {
        int iNth = Random(16);
        object oTarget = GetObjectByTag("FlameK10", iNth);
        ActionCastSpellAtObject(SPELL_FLAME_STRIKE, oTarget, METAMAGIC_ANY, TRUE);
    }
}
