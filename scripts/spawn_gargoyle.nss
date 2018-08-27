void main()
{
location lLoc = GetLocation(GetObjectByTag("SPAWN_POINT"));
CreateObject(OBJECT_TYPE_CREATURE, "nw_gargoyle", lLoc);
ActionSpeakString("You have spawned a Gargoyle.");
}
