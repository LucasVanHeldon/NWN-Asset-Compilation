void main()
{
object oTarget = GetNearestObjectByTag("Locked");
    if (oTarget !=OBJECT_INVALID && (GetLocked(oTarget)))
    {
        ActionDoCommand(SetLocked(oTarget, FALSE));
        AssignCommand(oTarget, SpeakString("Unlocked."));
        SetCustomToken(103, "Unlocked");
    }
      if (oTarget !=OBJECT_INVALID && (!GetLocked(oTarget)))
        {
        ActionDoCommand(SetLocked(oTarget, TRUE));
        AssignCommand(oTarget, SpeakString("Locked."));
        SetCustomToken(103, "Locked");
         }

}

