#include "NW_I0_PLOT"
void RemoveDoor(object oDoor)
{
    DestroyObject(oDoor,3.0f);
    DeleteLocalInt(OBJECT_SELF,"T1_OBJ_FOUND");
}

void main()
{

if (!GetLocalInt(OBJECT_SELF,"T1_OBJ_FOUND")==TRUE)
{
   object oEnterer = GetEnteringObject();


    if (AutoDC(DC_HARD, SKILL_SEARCH,oEnterer) == TRUE)
    {
         object oTrapdoor = CreateObject(OBJECT_TYPE_PLACEABLE,"gz_obj_trapdoor",GetLocation(OBJECT_SELF),TRUE);
         int iRoll = d4();
         string strSpeak = "";
         switch (iRoll)
         {
            case 1: strSpeak = "Hmmm ... I found a secret door!";break;
            case 2: strSpeak = "Look here ... a secret door!";break;
            case 3: strSpeak = "Here is something ... a secret door!";break;
            case 4: strSpeak = "Guess what ... a secret door!";break;
         }
        AssignCommand(oEnterer,ActionSpeakString(strSpeak));

         SetLocalInt(OBJECT_SELF,"T1_OBJ_FOUND",TRUE);
         DelayCommand(20.0f,RemoveDoor(oTrapdoor));
    }
}

}
