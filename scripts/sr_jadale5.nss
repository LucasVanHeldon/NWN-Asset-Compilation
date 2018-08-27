//::///////////////////////////////////////////////
//:: FileName sr_jadale5
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 8/13/2002 11:55:43 AM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker the items
    CreateItemOnObject("wandofcolorsp", GetPCSpeaker(), 1);

    if (!GetLocalInt(OBJECT_SELF, "panickedman")) {
        SetLocalInt(OBJECT_SELF, "panickedman", TRUE);
        CreateObject(OBJECT_TYPE_CREATURE, "panickedman", GetLocation(GetObjectByTag("WP_Tharizdun1")));
    }
}
