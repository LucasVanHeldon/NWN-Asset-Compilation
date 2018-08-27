void main()
{
    object oPC = GetEnteringObject();
    AssignCommand(oPC, ClearAllActions());
    DelayCommand(0.5, AssignCommand(oPC, ActionForceMoveToObject(GetObjectByTag("WP_Meditate"))));
    DelayCommand(2.0, AssignCommand(oPC, ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 0.5, RoundsToSeconds(5))));
    DelayCommand(3.0, AssignCommand(oPC, SpeakString("May inner peace fill me as I consider my life.")));
    DelayCommand(3.5, SetCommandable(FALSE, oPC));
    DelayCommand(RoundsToSeconds(5), SetCommandable(TRUE, oPC));
}

