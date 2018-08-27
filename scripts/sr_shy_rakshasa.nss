#include "NW_I0_GENERIC"

void main()
{
    int iRand = d20();

    switch (iRand) {
        case 1:
            SpeakString("No, you will not have it!");
            break;
        case 2:
            SpeakString("There, there, little one.  The light won't hurt you.  Wait, who are you!?!?  Noooooo!");
            break;
        case 3:
            SpeakString("My poor baby!  You, you!  I'll kill you and all your kind!");
            break;
        case 4:
            SpeakString("Hahahahahahaha, that pathetic fool in his tower!  I'll show him power of death!");
            break;
        case 5:
            SpeakString("Yes, my child, the old one in the tower will see you healed.  Come with me.");
            break;
        case 6:
            SpeakString("Never again shall the living step where you brought death to my child!!!");
            break;
    }
}
