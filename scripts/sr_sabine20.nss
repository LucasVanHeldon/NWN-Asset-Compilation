void main()
{
    object oPC = GetFirstFactionMember(GetPCSpeaker(), TRUE);
    while (GetIsObjectValid(oPC)) {
        AdjustAlignment(oPC, ALIGNMENT_LAWFUL, 5);
        oPC = GetNextFactionMember(GetPCSpeaker(), TRUE);
    }
}
