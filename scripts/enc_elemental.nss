#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"


string sCR1_16="zep_elemfires,zep_elemmagmas";
string sCR2_16="zep_elemairs,zep_elemashs,zep_elemdusts,zep_elemearths,zep_elemices,zep_elemmins,zep_elemoozes,zep_elemsalts,zep_elemsmokes,zep_elemsteams,zep_elemvacuums,zep_elemwaters";
string sCR3_16="zep_elemradncs,zep_lightnings";
string sCR5_16="nw_air";
string sCR6_16="nw_invstalk,nw_water,water001,zep_belker,zep_elemashm,zep_elemdustm,zep_elemearthm,zep_elemfirem,zep_elemicem,zep_elemmagmam,zep_elemminm,zep_elemoozem,zep_elemsaltm,zep_elemsmokem,zep_elemsteamm,zep_elemvacuumm,zep_elemwaterm,zep_lightningl";
string sCR7_16="toh_halfair,zep_elemradncm";
string sCR8_16="earth001,earth002,nw_earth";
string sCR9_16="air001,fire001,nw_fire,toh_demonicaire";
string sCR10_16="zep_elemairm";
string sCR11_16="zep_elemairl,zep_elemashl,zep_elemfirel,zep_elemicel,zep_elemmagmal,zep_elemradncl,zep_elemsmokel,zep_elemsteaml,zep_elemvacuuml,zep_elemwaterl,zep_lightningh";
string sCR12_16="air004,nw_waterhuge,zep_elemdustl,zep_elemearthl,zep_elemminl,zep_elemoozel,zep_elemsaltl";
string sCR13_16="air002,nw_earthhuge,nw_firehuge,toh_aircleric";
string sCR14_16="earth003,nw_airhuge";
string sCR15_16="nw_s_waterelder,nw_watergreat";
string sCR16_16="nw_earthgreat";
string sCR17_16="air003,nw_firegreat,nw_watelder";
string sCR18_16="earth004";
string sCR19_16="nw_airgreat,nw_eartheld,nw_fireelder,toh_demonicai001";
string sCR22_16="earth005,nw_airelder";
string sCR28_16="toh_demonicai002";
string sCR35_16="toh_demonicai003";
string sCR42_16="toh_demonicai004";

void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {
    case 1:    PopulateVars(o,1,sCR1_16); break;
    case 2:    PopulateVars(o,2,sCR2_16); break;
    case 3:    PopulateVars(o,3,sCR3_16); break;

    case 5:    PopulateVars(o,5,sCR5_16); break;
    case 6:    PopulateVars(o,6,sCR6_16); break;
    case 8:    PopulateVars(o,7,sCR8_16); break;
    case 9:    PopulateVars(o,9,sCR9_16); break;
    case 10:    PopulateVars(o,10,sCR10_16); break;
    case 11:    PopulateVars(o,11,sCR11_16); break;
    case 12:   PopulateVars(o,11,sCR12_16);break;
    case 13:   PopulateVars(o,12,sCR13_16);break;
    case 14:   PopulateVars(o,13,sCR14_16);break;
    case 15:   PopulateVars(o,15,sCR14_16);break;
    case 16:   PopulateVars(o,16,sCR14_16);break;
    case 17:   PopulateVars(o,17,sCR14_16);break;
    case 18:   PopulateVars(o,18,sCR18_16);break;
    case 19:   PopulateVars(o,19,sCR19_16);break;



    case 22:   PopulateVars(o,18,sCR22_16);break;
    case 28:   PopulateVars(o,28,sCR28_16);break;

    case 35:   PopulateVars(o,35,sCR35_16);break;
    case 42:   PopulateVars(o,42,sCR42_16);break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Beasts");
    Spawn();
}


