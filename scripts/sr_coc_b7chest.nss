void main()
{
    if (GetEncounterActive()) {
        if (GetIsObjectValid(GetNearestObjectByTag("b7chest"))) {
            AssignCommand(GetObjectByTag("b7chest"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("b7chest"));
        }
    }
}
