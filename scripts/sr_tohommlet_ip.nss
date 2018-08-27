void main()
{
    //Set to NOT WORK by default.  Change this to True and put in appropriate
    //  IP address to have it activate.
    if (TRUE)
        ActivatePortal(GetPCSpeaker(), "12.225.125.55:5122", "", "", TRUE);
    else
        SendMessageToPC(GetPCSpeaker(), "IP Address inactive at this time.");
}
