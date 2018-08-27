void main()
{
    if (GetEncounterActive()) {
        if (GetIsObjectValid(GetObjectByTag("ogrepillage"))) {
            AssignCommand(GetObjectByTag("ogrepillage"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("ogrepillage"));
        }
    }
}
