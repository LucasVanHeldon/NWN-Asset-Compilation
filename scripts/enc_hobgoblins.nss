#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="hobgoblin015,hobgoblin016,hobgoblin017,nw_hobgoblin001";
string sCR1="hobgoblin015,hobgoblin016,hobgoblin017,nw_hobgoblin001";
string sCR2="hobgoblin006,hobgoblin002,hobgoblin011,nw_hobgoblin002";
string sCR3="hobgoblin007,hobgoblin003,hobgoblin018,hobgoblin013";
string sCR4="toee_hobfighter,hobgoblin012";
string sCR5="hobgoblin008,hobgoblin004,toee_hobfight001,hobgoblin019,hobgoblin014";
string sCR6="hobgoblin009,hobgoblin005,hobgoblin020";
string sCR7="toee_hobfight002,toee_hobfight003,hobgoblin145";
string sCR8="hobgoblin010";
string sCR10="toee_hobfight004";


void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {

    case 1:    PopulateVars(o,1,sCR1); break;
    case 2:    PopulateVars(o,2,sCR2); break;
    case 3:    PopulateVars(o,3,sCR3); break;
    case 4:    PopulateVars(o,4,sCR4); break;
    case 5:    PopulateVars(o,5,sCR5); break;
    case 6:    PopulateVars(o,6,sCR6); break;
    case 7:    PopulateVars(o,7,sCR7); break;
    case 8:    PopulateVars(o,8,sCR8); break;
    case 9:
    case 10:
        PopulateVars(o,CR,sCR10);break;
    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Hobgoblins");

    PopulateVars(OBJECT_SELF,0,sCR0);

    int EL = CalcEL(OBJECT_SELF);
    if(EL > 1)
        SpawnCR(0.5);

    Spawn();

}


