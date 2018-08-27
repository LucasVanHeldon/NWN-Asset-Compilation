void main()
{
    if (GetCalendarDay()==1) {
        if (GetLocked(OBJECT_SELF))
            SetLocked(OBJECT_SELF, FALSE);
    } else {
        if (GetIsOpen(OBJECT_SELF))
            DelayCommand(10.0, ActionCloseDoor(OBJECT_SELF));
        if (!GetLocked(OBJECT_SELF) && !GetIsOpen(OBJECT_SELF))
            SetLocked(OBJECT_SELF, TRUE);
    }
}
