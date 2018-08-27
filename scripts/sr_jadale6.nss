//::///////////////////////////////////////////////
//:: FileName sr_jadale6
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/13/2002 11:56:12 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("pearlsetring1", GetPCSpeaker(), 1);

    if (!GetLocalInt(OBJECT_SELF, "panickedman")) {
        SetLocalInt(OBJECT_SELF, "panickedman", TRUE);
        CreateObject(OBJECT_TYPE_CREATURE, "panickedman", GetLocation(GetObjectByTag("WP_Tharizdun1")));
    }
}
