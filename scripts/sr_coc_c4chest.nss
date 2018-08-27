void main()
{
    if (GetEncounterActive()) {
        if (GetIsObjectValid(GetNearestObjectByTag("c4chest"))) {
            AssignCommand(GetObjectByTag("c4chest"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("c4chest"));
        }
    }
}
