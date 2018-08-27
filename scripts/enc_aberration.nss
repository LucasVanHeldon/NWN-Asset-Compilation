#include "encounter"
#include "nw_o0_itemmaker"
#include "x0_i0_stringlib"

string sCR0_7="mmp_dancinglight,zep_myconidsp001";
string sCR3_7="carrioncrawler,sr_carrioncrawle,x2_beholder002,zep_blackrosef,zep_blackrosem,zep_meenlock1,zep_meenlock2,zep_myconidspro";
string sCR4_7="zep_myconidki001";
string sCR5_7="nw_ettercap,toh_abccrawle001,zep_chupacabra,zep_flyeye,zep_meenlock3,zep_meenlock4,zep_rustmonster";
string sCR6_7="aberration,aberration005,nw_devour,otyugh,toh_abccrawler,toh_aboozeccrwl,x2_fdrider001,zep_dridmale_c,zep_dridmale_d,zep_dridmale_e,zep_myconid001";
string sCR7_7="drider002,drider003,nw_horror,x2_drider001,x2_fdrider002,zep_aboleth,zep_driderm1,zep_dridmale_b,zep_illithidkid";
string sCR8_7="aberration002,nw_umberhulk,x2_driderw01,x2_mindflayer001,zep_willowisp1,zep_willowisp2,zep_willowisp3,zep_willowisp4,zep_willowisp5";
string sCR9_7="zep_illithid,zep_illithid2,zep_illithid3,zep_illithid4,zep_illithid5";
string sCR10_7="toh_pyschicmf,x2_drider002,zep_dridarmor_a,zep_dridarmor_b,zep_dridarmor_c";
string sCR11_7="aberration004,battdevour001,nw_battdevour,nw_willowisp,toh_demonicdridr,zep_dridfem_a,zep_dridfem_b,zep_illithid1";
string sCR12_7="toh_aberwizar001,zep_beholder";
string sCR13_7="aberration003,zep_bebilithb";
string sCR14_7="zep_dridfem_c,zep_dridfem_d,zep_spiderking";
string sCR15_7="x2_beholder001,x2_mindflayer002";
string sCR16_7="x2_mindfveneratr,zep_aboleth001";

string sCR18_7="x2_drider003,x2_mindfdarkener,x3_gzhorb";
string sCR19_7="aberrationsor001";
string sCR20_7="x2_beholder003";
string sCR21_7="aberration001,toh_aberwizar002";

string sCR24_7="x2_drider004,zep_aboleth002";
string sCR27_7="aberrationsor002,toh_aberwizar003,toh_brainjar";
string sCR28_7="x2_drider005";
string sCR30_7="aberrationsorcer";
string sCR32_7="toh_aberwizar004";
string sCR38_7="toh_aberwizard,zep_aboleth003";
string sCR44_7="eldritchhorror";
string sCR46_7="zep_aboleth004";
string sCR50_7="zep_aboleth005";



void Fill(int CR,object o = OBJECT_SELF)
{
    switch(CR)
    {

    case 0:    PopulateVars(o,0,sCR0_7); break;
    case 3:    PopulateVars(o,3,sCR3_7); break;
    case 4:    PopulateVars(o,4,sCR4_7); break;
    case 5:    PopulateVars(o,5,sCR5_7); break;
    case 6:    PopulateVars(o,6,sCR6_7); break;
    case 7:    PopulateVars(o,7,sCR7_7); break;
    case 8:    PopulateVars(o,8,sCR8_7); break;
    case 9:    PopulateVars(o,9,sCR9_7); break;
    case 10:   PopulateVars(o,10,sCR10_7);break;
    case 11:   PopulateVars(o,11,sCR11_7);break;
    case 12:   PopulateVars(o,12,sCR12_7);break;
    case 13:   PopulateVars(o,13,sCR13_7);break;
    case 14:   PopulateVars(o,14,sCR14_7);break;
    case 15:   PopulateVars(o,15,sCR15_7);break;
    case 16:   PopulateVars(o,16,sCR16_7);break;

    case 18:   PopulateVars(o,18,sCR18_7);break;
    case 19:   PopulateVars(o, 19 ,sCR19_7 );break;
    case 20:   PopulateVars(o, 20 ,sCR20_7 );break;
    case 21:   PopulateVars(o, 21 ,sCR21_7 );break;

    case 24:   PopulateVars(o, 24 ,sCR24_7 );break;
    case 27:    PopulateVars(o, 27 ,sCR27_7 );break;
    case 28:    PopulateVars(o, 28 ,sCR28_7 );break;
    case 30:    PopulateVars(o, 30 ,sCR30_7 );break;
    case 32:    PopulateVars(o, 32 ,sCR32_7 );break;
    case 38: PopulateVars(o, 38 ,sCR38_7 );break;
    case 44: PopulateVars(o, 44 ,sCR44_7 );break;
    case 46: PopulateVars(o, 46 ,sCR46_7 );break;
    case 50: PopulateVars(o, 50 ,sCR50_7 );break;

    }
}



void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Aberration");

    Spawn();

}


