void main()
{
    //Set to NOT WORK by default.  Change this to True and put in appropriate
    //  module name to have it activate.
    if (FALSE)
        StartNewModule("(SR) Temple of Elemental Evil");
    else
        SendMessageToPC(GetPCSpeaker(), "Module Load inactive at this time.");
}
