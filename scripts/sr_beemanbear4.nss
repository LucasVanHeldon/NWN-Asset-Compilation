void main()
{
    object oMoveTo = GetObjectByTag("sr_outside_wp1");

    ActionMoveToObject(oMoveTo);
    DestroyObject(OBJECT_SELF, 10.0);
}
