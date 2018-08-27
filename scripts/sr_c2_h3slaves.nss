void main()
{
    int nEvent = GetUserDefinedEventNumber();
    //Identify the objects we are going to work with
    object oDoor = GetObjectByTag("h3_slavedoor");
    object oNPC = OBJECT_SELF;
    int nIRanTo;
    int nRunWP;

    switch(nEvent)
    {
        //Make Captives run to shrine and dissappear.
        case 100:
            SoundObjectStop(GetObjectByTag("WailsWomen"));
            SoundObjectStop(GetObjectByTag("WailsMen"));
            SoundObjectStop(GetObjectByTag("WailsChildren"));
            ClearAllActions();
            SetLocalInt(oNPC, "I_am_running", 1);

            //Set the 1st waypoint the NPC needs to begin running to.
            if(GetLocalInt(oNPC, "I_ran_to") == 0)
            {
                SetLocalInt(oNPC, "I_ran_to", 1);
                nIRanTo = 1;
            }
            else
            {
                nIRanTo = GetLocalInt(oNPC, "I_ran_to");
            }

            //Run NPCs through their remaining waypoints
            for(nRunWP = nIRanTo;nRunWP <= 1;nRunWP++)
            {
                ActionMoveToObject(GetObjectByTag("WP_CEscape_0" +
                    IntToString(nRunWP)), TRUE);
                ActionDoCommand(SetLocalInt(oNPC, "I_ran_to", nRunWP + 1));
            }
            //Check to see if shrine door is open and if not, open it.
            if(!GetIsOpen(oDoor))
            {
                ActionOpenDoor(oDoor);
            }
            else
            {
                ActionMoveToObject(oDoor, FALSE, 2.0);
            }

            ActionDoCommand(DestroyObject(oNPC));
        break;

        //OnHeartbeat to Signal NPCs to run for Shrine
        case 1001:
            if((GetLocalInt(GetModule(), "prisoner_free") == 1) &&
                !(GetLocalInt(oNPC, "I_am_running") == 1))
            {
                SignalEvent(oNPC, EventUserDefined(100));
            }
        break;

        //OnDialog Script that clears I_am_running variable
        case 1004:
            SetLocalInt(oNPC, "I_am_running", 0);
        break;

     }

}
