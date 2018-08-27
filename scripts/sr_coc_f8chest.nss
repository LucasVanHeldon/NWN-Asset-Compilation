void main()
{
    if (GetEncounterActive()) {
        if (GetIsObjectValid(GetNearestObjectByTag("f8chest"))) {
            AssignCommand(GetObjectByTag("f8chest"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("f8chest"));
        }
    }
}
