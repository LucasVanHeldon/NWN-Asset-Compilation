void main()
{
    if (GetEncounterActive()) {
        if (GetIsObjectValid(GetNearestObjectByTag("a6chest"))) {
            AssignCommand(GetObjectByTag("a6chest"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("a6chest"));
        }
    }
}
