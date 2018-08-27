void main()
{
    object oPC = GetFirstFactionMember(GetLastOpenedBy());
    while (GetIsObjectValid(oPC)) {
        if (GetDistanceToObject(oPC) < 20.0) {
            ApplyEffectToObject(DURATION_TYPE_TEMPORARY, EffectFrightened(), oPC, RoundsToSeconds(d4(2)));
            SendMessageToPC(oPC, "A feeling of terror and coming death sweeps the whole area.");
        }
        oPC = GetNextFactionMember(GetLastOpenedBy());
    }
}
