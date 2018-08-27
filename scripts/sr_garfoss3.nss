//::///////////////////////////////////////////////
//:: FileName sr_garfoss3
//:://////////////////////////////////////////////
//:://////////////////////////////////////////////
//:: Created By: Script Wizard
//:: Created On: 7/12/2002 12:00:38 PM
//:://////////////////////////////////////////////
void main()
{
    // Give the speaker some gold
    GiveGoldToCreature(GetPCSpeaker(), 100);

    // Give the speaker the items
    CreateItemOnObject("innerkeepkey", GetPCSpeaker(), 1);

    SetLocalInt(GetArea(OBJECT_SELF), "GarfossLoad", 99);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_CHAOTIC, 50);
    AdjustAlignment(GetPCSpeaker(), ALIGNMENT_EVIL, 50);
}
