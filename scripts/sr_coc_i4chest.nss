void main()
{
    if (GetEncounterActive()) {
        if (GetIsObjectValid(GetNearestObjectByTag("i4chest"))) {
            AssignCommand(GetObjectByTag("i4chest"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("i4chest"));
        }
        if (GetIsObjectValid(GetNearestObjectByTag("i4torchbracket"))) {
            AssignCommand(GetObjectByTag("i4torchbracket"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("i4torchbracket"));
        }
    }

}
