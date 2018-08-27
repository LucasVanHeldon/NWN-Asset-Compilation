void main()
{
    if (GetEncounterActive()) {
        if (GetIsObjectValid(GetNearestObjectByTag("d7drawers"))) {
            AssignCommand(GetObjectByTag("d7dwrawers"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("d7drawers"));
        }
    }
}
