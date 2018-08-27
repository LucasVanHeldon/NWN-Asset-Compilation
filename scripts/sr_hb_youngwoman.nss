#include "NW_I0_GENERIC"

void main()
{
    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") == 2)
    {
        ActionSpeakString("No! Get away! Help!", TALKVOLUME_SHOUT);
        FloatingTextStringOnCreature("The young woman tries to resist but is easily overwhelmed.", OBJECT_SELF);
        SetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack", 3);
    }

    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") == 4)
    {
        ActionSpeakString("Oh please, oh please, no...");
        SetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack", 5);
        ActionPlayAnimation(ANIMATION_LOOPING_SIT_CROSS, 1.0, 18.0);
    }

    if (GetLocalInt(GetArea(OBJECT_SELF), "OnTheAttack") >= 6)
    {
        DestroyObject(OBJECT_SELF);
    }
}
