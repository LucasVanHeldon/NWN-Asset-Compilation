void main()
{
    if (GetEncounterActive()) {
        if (GetIsObjectValid(GetNearestObjectByTag("j4chest"))) {
            AssignCommand(GetObjectByTag("j4chest"), JumpToObject(GetObjectByTag("WP_Garbage")));
            DestroyObject(GetObjectByTag("j4chest"));
        }
    }
}
