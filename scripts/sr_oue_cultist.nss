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
        //OnPercieved
        case 1002:
            SpeakOneLinerConversation();
        break;

        //OnDialog Script that clears I_am_running variable
        case 1004:
            SetLocalInt(oNPC, "I_am_running", 0);
        break;

     }

}
