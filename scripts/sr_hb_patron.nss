#include "NW_I0_GENERIC"

void main()
{
    if(GetSpawnInCondition(NW_FLAG_HEARTBEAT_EVENT))
    {
        SignalEvent(OBJECT_SELF, EventUserDefined(1001));
    }

    if(GetTimeMinute()==30)
    {
        int iRand = Random(10);
        int iPatrons = GetLocalInt(GetArea(OBJECT_SELF), "Patrons");

        if (iRand == 0 && iPatrons>0)
        {
            iPatrons--;
            SetLocalInt(GetArea(OBJECT_SELF), "Patrons", iPatrons);
            ActionMoveToObject(GetObjectByTag("sr_tav_enter"));
            DelayCommand(10.0, DestroyObject(OBJECT_SELF));
            SendMessageToAllDMs("Current Patrons: "+IntToString(iPatrons));
        }
    }

    int iSpeak = Random(200);

        switch(iSpeak)
            {
                case 1:
                    ActionSpeakString("Hey, what are you looking at!");
                    ActionPlayAnimation(ANIMATION_FIREFORGET_TAUNT, 1.0, 5.0);
                    break;
                case 2:
                    ActionSpeakString("Something needs to be done, I tell you!");
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0);
                    break;
                case 3:
                    ActionSpeakString("Care to dance?");
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 5.0);
                    break;
                case 4:
                    ActionSpeakString("All that farmland, gone to waste.  It's time for more heroes to arise.  Past time.");
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_NORMAL, 1.0, 5.0);
                    break;
                case 5:
                    ActionPlayAnimation(ANIMATION_FIREFORGET_DRINK, 1.0);
                    break;
                case 6:
                    ActionPlayAnimation(ANIMATION_FIREFORGET_GREETING, 1.0);
                    break;
                case 7:
                    ActionSpeakString("Now that is funny!");
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 5.0);
                    break;
                case 8:
                    ActionPlayAnimation(ANIMATION_FIREFORGET_VICTORY1, 1.0);
                    break;
                case 9:
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_LAUGHING, 1.0, 3.0);
                    break;
                case 10:
                    ActionSpeakString("I wouldn't take stock in that, you know how rumors are.");
                    ActionPlayAnimation(ANIMATION_LOOPING_TALK_FORCEFUL, 1.0, 5.0);
                    break;
                case 11:
                    ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_BORED, 1.0);
                    break;
                case 12:
                    ActionPlayAnimation(ANIMATION_FIREFORGET_PAUSE_SCRATCH_HEAD, 1.0);
                    break;
            }// end switch(d100)

}
