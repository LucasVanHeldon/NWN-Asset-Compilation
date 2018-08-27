//::///////////////////////////////////////////////
//:: FileName sr_jadale11
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/17/2002 2:46:37 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("arrowsoftruestri", GetPCSpeaker(), 1);

    if (!GetLocalInt(OBJECT_SELF, "panickedman")) {
        SetLocalInt(OBJECT_SELF, "panickedman", TRUE);
        CreateObject(OBJECT_TYPE_CREATURE, "panickedman", GetLocation(GetObjectByTag("WP_Tharizdun1")));
    }
}
