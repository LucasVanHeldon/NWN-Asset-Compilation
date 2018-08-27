#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0="nw_elfranger001,x3_elfmount001";
string sCR1="nw_drowcler001,nw_drowfight001,nw_drowmage001,nw_drowrogue001";
string sCR2="nw_elfmerc001,zep_halffiend,zep_halffiendf";
string sCR3="nw_drowrogue005";
string sCR4="nw_drowcler005,nw_drowfight005,nw_drowmage005,nw_elfmerc002,nw_elfranger005,x2_drow002";

string sCR6="nw_elfmerc003";
string sCR7="nw_drowmage010,nw_drowrogue010,x2_drow003,x2_mephdrow001";
string sCR8="falrinth,nw_drowcler010,nw_drowfight010,x2_mephdrow004,x2_mephdrow007,x2_mephdrow010,x2_mephdrow013";
string sCR9="nw_elfmerc004";
string sCR10="nw_drowrogue015";
string sCR11="nw_drowcler015,nw_drowfight015,nw_drowmage015,nw_elfmerc005,nw_elfranger015,x2_drow004,x2_mephdrow011";
string sCR12="x2_mephdrow002";
string sCR13="nw_drowrogue020,x2_mephdrow005,x2_mephdrow014";
string sCR14="nw_drowmage020,nw_elfmerc006,x2_mephdrow008";
string sCR15="nw_drowcler020,nw_drowfight020,x2_drow005,x2_mephdrow012";

string sCR18="x2_mephdrow003,x2_mephdrow015";

string sCR20="x2_mephdrow006,x2_mephdrow009";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {
    default:
    case 0:    PopulateVars(o,0,sCR0); break;
    case 1:    PopulateVars(o,1,sCR1); break;
    case 2:    PopulateVars(o,2,sCR2); break;
    case 3:    PopulateVars(o,3,sCR3); break;
    case 4:    PopulateVars(o,4,sCR4); break;

    case 6:    PopulateVars(o,6,sCR6); break;
    case 7:    PopulateVars(o,7,sCR7); break;
    case 8:    PopulateVars(o,8,sCR8); break;
    case 9:    PopulateVars(o,9,sCR9); break;

    case 10:   PopulateVars(o,10,sCR10);break;
    case 11:   PopulateVars(o,11,sCR11);break;
    case 12:   PopulateVars(o,12,sCR12);break;
    case 13:   PopulateVars(o,13,sCR13);break;
    case 14:   PopulateVars(o,14,sCR14);break;
    case 15:   PopulateVars(o,15,sCR15);break;

    case 18:   PopulateVars(o,18,sCR18);break;
    case 20:   PopulateVars(o,20,sCR20);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Construct");
    int EL = CalcEL(OBJECT_SELF);
    if(EL > 1)
        SpawnCR(0.5);

    Spawn();
}


