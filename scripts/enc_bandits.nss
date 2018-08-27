#include "encounter"

#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR0="bandit001,bandit002,bandit003,bandit004,bandit005,bandit006,nw_bandit002,creature007";
string sCR1="nw_bandit003,bandit010,bandit015";
string sCR2="bandit005,bandit009,bandit014,creature001,creature008";
string sCR3="NW_BANDIT004,bandit007,bandit011,bandit016,creature002";
string sCR4="bandit006,nw_bandit005,bandit012,bandit018,creature009";
string sCR5="bandit008,bandit013,bandit017,creature011";
string sCR6="creature010";
string sCR10="nw_bandit006";










void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {

    case 0:    PopulateVars(o,0,sCR0); break;
    case 1:    PopulateVars(o,1,sCR1); break;
    case 2:    PopulateVars(o,2,sCR2); break;
    case 3:    PopulateVars(o,3,sCR3); break;
    case 4:    PopulateVars(o,4,sCR4); break;
    case 5:    PopulateVars(o,5,sCR5); break;
    case 6:    PopulateVars(o,6,sCR6); break;
    case 7:    PopulateVars(o,7,sCR6); break;
    case 8:    PopulateVars(o,8,sCR6); break;
    case 10:   PopulateVars(o,10,sCR10);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Bandits");
    PopulateVars(OBJECT_SELF,0,sCR0);


    int EL = CalcEL(OBJECT_SELF);
    if(EL > 1)
        SpawnCR(0.5);

    Spawn();

}


