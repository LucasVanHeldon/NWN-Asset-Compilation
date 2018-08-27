void main()
{
location lLoc = GetLocation(GetObjectByTag("SPAWN_POINT"));
CreateObject(OBJECT_TYPE_CREATURE, "nw_bathorror",lLoc);
ActionSpeakString("You have spawned a Battle Horror.");
}
