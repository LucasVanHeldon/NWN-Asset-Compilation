void main()
{
    if (GetEncounterActive()) {
        if (GetIsObjectValid(GetNearestObjectByTag("h9chest"))) {
            AssignCommand(GetObjectByTag("h9chest"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("h9chest"));
        }
    }
}
