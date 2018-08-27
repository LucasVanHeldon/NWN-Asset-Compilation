#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="creature003";
string sCR1="brigand,brigand001,brigand003,brigand006,brigand007";
string sCR2="brigand002,brigandleader,creature004";
string sCR3="brigand074,brigand161";
string sCR4="brigand004,brigand005,creature005,brigand008";
string sCR5="brigand015,creature006";
string sCR6="brigand160,brigand010,brigand162";
string sCR7="brigand035,brigandleader001";
string sCR11="brigand009";










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
    case 11:   PopulateVars(o,11,sCR11);break;
    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Brigands");
    PopulateVars(OBJECT_SELF,0,sCR0);

    int EL = CalcEL(OBJECT_SELF);
    if(EL > 1)
        SpawnCR(1.0);

    Spawn();
}


