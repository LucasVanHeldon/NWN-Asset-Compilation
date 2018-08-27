void main()
{
    ActionDoCommand(ActionMoveToObject(GetObjectByTag("SafePath"), TRUE));
    DestroyObject(OBJECT_SELF, 15.0);
}
