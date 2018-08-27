void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 1000);

    if (!GetLocalInt(OBJECT_SELF, "panickedman")) {
        SetLocalInt(OBJECT_SELF, "panickedman", TRUE);
        CreateObject(OBJECT_TYPE_CREATURE, "panickedman", GetLocation(GetObjectByTag("WP_Tharizdun1")));
    }
}
