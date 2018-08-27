void main()
{
    object oNPC1 = GetObjectByTag("Hrusk");
    object oNPC2 = GetObjectByTag("Egraj");

    FloatingTextStringOnCreature("Egraj, did ya hear that?  Sound like door.  Thoughts you said fishman no come home for days?", oNPC1, FALSE);
    DelayCommand(1.0, FloatingTextStringOnCreature("Darned fool!  Let me concentrate on this here chest lock and shut up.  I tole ya, that old fool gone fishin' with his son-by-law to teach him the fishman ways and ain't being back for days.", oNPC2, FALSE));
    DelayCommand(2.0, FloatingTextStringOnCreature("I not jump at mouse sounds.  I check it out.", oNPC1, FALSE));

    DelayCommand(3.0, AssignCommand(oNPC1, ActionMoveToObject(GetObjectByTag("sr_07a_loc1"))));

    object oObj = GetObjectByTag("07a_BasicOnEnter");
    DestroyObject(oObj);
}
