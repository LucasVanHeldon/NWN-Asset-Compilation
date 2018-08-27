////////////////////////////////////////////////////
/*
Custom Random Commoner Table for use with the BESIE
Random Encounter Package by Ray Miller
*/
////////////////////////////////////////////////////

void main()
{
int iVarNum = GetLocalInt(OBJECT_SELF, "re_iVarNum");
int END;
int iWeight;
int iCounter1;
int iCounter2;
string sChoice;
object oMod = GetModule();
while(!END)
    {
    sChoice = "";
    switch(iCounter1)
        {
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//DO NOT EDIT ABOVE THIS LINE/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//CUSTOM ENCOUNTER TABLE BELOW:///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////

        case 0:sChoice = "mhuman";// Creature tag goes between the " marks.
        iWeight = 10;        // This is the number of times this mob should be considered for the likelyhood of appearing.
        break;

        case 1:sChoice = "fhuman";
        iWeight = 10;
        break;

        case 2:sChoice = "melf";
        iWeight = 8;
        break;

        case 3:sChoice = "felf";
        iWeight = 8;
        break;

        case 4:sChoice = "mhalfelf";
        iWeight = 8;
        break;

        case 5:sChoice = "fhalfelf";
        iWeight = 8;
        break;

        case 6:sChoice = "mdwarf";
        iWeight = 6;
        break;

        case 7:sChoice = "fhalforc";
        iWeight = 1;
        break;

        case 8:sChoice = "mhalfling";
        iWeight = 4;
        break;

        case 9:sChoice = "fhalfling";
        iWeight = 4;
        break;

        case 10:sChoice = "mgnome";
        iWeight = 3;
        break;

        case 11:sChoice = "fgnome";
        iWeight = 2;
        break;

        case 12:sChoice = "mhalforc";
        iWeight = 2;
        break;

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//END OF CUSTOM ENCOUNTER TABLE!  DO NOT EDIT BELOW THIS LINE//////////////////////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        default:END = TRUE;
        break;
        }
    if(GetStringLowerCase(sChoice) != "")
        {
        for(iCounter2 = 1; iCounter2 <= iWeight; iCounter2++)
            {
            SetLocalString(oMod, "re_sCreatureList" + IntToString(iVarNum), sChoice);
            iVarNum++;
            }
        }
    iCounter1++;
    }
SetLocalInt(OBJECT_SELF, "re_iVarNum", iVarNum);
}
