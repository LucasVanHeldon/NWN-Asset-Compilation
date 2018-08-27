void main()
{
  // enter desired behaviour here
  int nUser = GetUserDefinedEventNumber();

  object oBar = GetWaypointByTag("sr_WP_Bar2");
  object oBartender = GetObjectByTag("Bartender");
  object oGuard = GetObjectByTag("DoorGuard");
  object oBarmaid = GetObjectByTag("Barmaid");
  object oBarmaid2 = GetObjectByTag("Barmaid2");


  // I have two TavernPatron types. Male (TavernPatronM) & Female (TavernPatronF).
  // This random chooses which the Barmaid is looking for.
  string sMorF = "M";
  int nGender = Random(2);
  if (nGender == 1)
    sMorF = "F";
  string sPatron = "TavernPatron" + sMorF;
  object oPatron = GetLocalObject(OBJECT_SELF, sPatron);

  if(nUser == 1001) //On Heartbeat
  {
    // Because the number of creatures in the room is very random,
    // I am using 20 as a base number of creatures that the patrons
    // could be amongst.
    int nRandom = Random(20)+1;

    if (Random(20) == 0)
      ActionMoveToObject(oBar);

    while(nRandom == GetLocalInt(OBJECT_SELF, "LASTCUST"))
        nRandom = Random(20)+1;

    if(!GetIsObjectValid(oPatron) || GetLocalInt(OBJECT_SELF,"PC_BOTHERED") == 1)
    {
      if(GetLocalInt(OBJECT_SELF,"PC_BOTHERED") != 1)
          oPatron = GetNearestCreature(CREATURE_TYPE_PLAYER_CHAR,
                PLAYER_CHAR_NOT_PC, OBJECT_SELF, nRandom);
      if(GetIsObjectValid(oPatron) && oPatron != oBarmaid && oPatron != oBarmaid2
          && oPatron != oBartender && oPatron != oGuard)
      {
        switch(GetLocalInt(OBJECT_SELF, "BARMAID_STATE"))
        {
        case 0:
        case 1: // Move to Customer
          SetLocalInt(OBJECT_SELF, "LASTCUST", nRandom);
          SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 1);
          SetLocalObject(OBJECT_SELF, sPatron, oPatron);
          ActionMoveToObject(oPatron);
          ActionWait(5.0);
//          ActionSpeakString("What will you have?");

        case 2: //Move to Bar
          ActionDoCommand(SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 2));
          ActionMoveToObject(oBar);
          ActionWait(5.0);
//          ActionSpeakString("I have an order to fill.");

        case 3: //Move back to the patron
          ActionDoCommand(SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 3));
          ActionMoveToObject(oPatron);
          ActionWait(5.0);
//          ActionSpeakString("Here's your order.");

          ActionDoCommand(SetLocalObject(OBJECT_SELF, sPatron, OBJECT_INVALID));

        case 4: //Move to Bar
          ActionDoCommand(SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 4));
          ActionMoveToObject(oBar);
          ActionWait(5.0);
//          ActionSpeakString("");

          ActionDoCommand(SetLocalInt(OBJECT_SELF, "PC_BOTHERED", 0));
          ActionDoCommand(SetLocalInt(OBJECT_SELF, "BARMAID_STATE", 0));
        }
      }
    }
  }

  if(nUser == 1004) //OnDialogue
  {
    // This is just in here so you can interrupt her if you want to talk to her
    SetLocalObject (OBJECT_SELF, "CUSTOMER", OBJECT_INVALID);
    SetLocalInt (OBJECT_SELF, "BARMAID_STATE", 0);
  }
}
