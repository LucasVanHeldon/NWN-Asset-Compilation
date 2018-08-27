void main()
{
    int nEvent = GetUserDefinedEventNumber();
    switch(nEvent)
    {
    case 7777:
        if(GetLocked(OBJECT_SELF)) break;
        if(GetIsTrapped(OBJECT_SELF)) break;
        if( GetIsOpen(OBJECT_SELF) ) ActionCloseDoor(OBJECT_SELF);
        else ActionOpenDoor(OBJECT_SELF);
        if(d20() == 1 && !GetIsOpen(OBJECT_SELF)) SetLocked(OBJECT_SELF,TRUE);

        break;
    }
}
