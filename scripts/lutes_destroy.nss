void main()
{
    object o = GetFirstItemInInventory(OBJECT_SELF);
    while( GetIsObjectValid(o))
    {
        DelayCommand(5.0f,DestroyObject(o));
        o = GetNextItemInInventory(OBJECT_SELF);
    }
    DelayCommand(5.0f,DestroyObject(OBJECT_SELF));
}
