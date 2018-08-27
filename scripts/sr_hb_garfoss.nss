#include "NW_I0_GENERIC"

void main()
{
    int iHour = GetTimeHour();
    int iMinute = GetTimeMinute();

    if (iHour == 22 && (iMinute == 0 || iMinute == 1)) {
        if (!GetLocalInt(GetArea(OBJECT_SELF), "WomanLoad")) {
            ActionMoveToObject(GetObjectByTag("GarfossWP2"));
            CreateObject(OBJECT_TYPE_CREATURE, "youngwoman", GetLocation(GetObjectByTag("VictimWP1")));
            SetLocalInt(GetArea(OBJECT_SELF), "WomanLoad", TRUE);
        }
    }
    if (iHour == 22 && (iMinute == 3 || iMinute == 4))
        ActionMoveToObject(GetObjectByTag("GarfossWP3"));
    if (iHour == 22 && (iMinute == 6 || iMinute == 7))
        ActionMoveToObject(GetObjectByTag("GarfossWP4"));
    if (iHour == 22 && (iMinute == 15 || iMinute == 16))
        ActionMoveToObject(GetObjectByTag("GarfossWP5"));

    if (iHour == 22 && iMinute == 30)
        SetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack", 1);

    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") == 1)
    {
        ActionSpeakString("Well, darling, it seems your night is about to come to a sudden end.");
        FloatingTextStringOnCreature("Garfoss attacks the young woman.", OBJECT_SELF);
        SetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack", 2);
    }

    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") == 3)
    {
        ActionSpeakString("Shut up wench, your time is almost over! *slap*");
        SetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack", 4);
    }

    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") == 5)
    {
        ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 12.0);
        FloatingTextStringOnCreature("Garfoss begins to rape the unconcious young woman.", OBJECT_SELF);
        SetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack", 6);
    }

    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") == 6)
    {
        ActionSpeakString("Sweet flesh, yes.  So sweeet.");
        SetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack", 7);
    }

    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") == 7)
    {
        ActionSpeakString("Damn wenches never learn.");
        SetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack", 0);
        ActionMoveToObject(GetObjectByTag("GarfossWP1"), TRUE);
    }

}
