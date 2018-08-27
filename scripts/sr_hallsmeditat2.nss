void main()
{
    object oPC = GetEnteringObject();
    AssignCommand(oPC, ClearAllActions());
    DelayCommand(0.5, AssignCommand(oPC, ActionForceMoveToObject(GetObjectByTag("WP_Meditate2"))));
    DelayCommand(2.0, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_TALK_PLEADING, 0.5, RoundsToSeconds(5))));
    DelayCommand(3.0, AssignCommand(oPC, SpeakString("May the spirits find my soul worthy enough to release to the world again.")));
    DelayCommand(3.5, SetCommandable(FALSE, oPC));
    DelayCommand(RoundsToSeconds(5), SetCommandable(TRUE, oPC));
}

