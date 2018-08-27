//::///////////////////////////////////////////////
//:: FileName sr_jadale4
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/13/2002 11:49:38 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("nw_it_mring001", GetPCSpeaker(), 1);

    if (!GetLocalInt(OBJECT_SELF, "panickedman")) {
        SetLocalInt(OBJECT_SELF, "panickedman", TRUE);
        CreateObject(OBJECT_TYPE_CREATURE, "panickedman", GetLocation(GetObjectByTag("WP_Tharizdun1")));
    }
}
