#include "encounter"

string sMinions1="bandit,bandit001,bandit002,bandit003,bandit004,el_bandit1,el_brigand1,m1q02cfguarp1,m1q02cfprish";
string sMinions2="m1q2aescpris002,m1q2_formpris3,nw_bandit001,nw_bandit002,nw_guard,nw_gypfemale,nw_gypmale,nw_gypsy001";
string sMinions3="nw_gypsy002,nw_kurthsold,nw_luskanite,nw_noblfemale,nw_noblmale,nw_plagmale,nw_werecat001,nw_wererat001";
string sMinions4="nw_werewolf001,zep_pygmy_001,zep_pygmy_004,bat001,nw_badger,nw_rat001,nw_ratdire001,zep_cougar";
string sMinions5="zep_flyingsnake,zep_goat_004,zep_ratsewer,zep_tinydesertvi,zep_tinyforestvi,zep_tinyjunglevi";
string sMinions6="zep_tinyswampvi,creature003,creature007,m1q2aescpris02,el_goblinenc,el_goblinenc001,el_goblinenc1_2";
string sMinions7="el_goblinenc1_3,el_orc0,hobgoblin015,hobgoblin016,nw_goblina,nw_goblinb,zep_bugbear_008,zep_goblin";
string sMinions8="m1q2aescpris01,m1q2prisoner001,nw_dwarfmerc001,mmp_dancinglight,zep_myconidsp001,nw_btlfire";
string sMinions9="zep_dspiders,zep_dspidert,zep_gantlarva,zep_mscorps,zep_mspiders,zep_mspidert,zep_shrieker";
string sMinions10="zep_spiderling,zep_sspiders,zep_sspidert,nw_elfranger001,x3_elfmount001,nw_kobold001,nw_kobold002";
string sMinions11="zep_koboldfly,zep_koboldfly2,nw_stirge,sr_stirge,zep_stirge,zep_stirgecave,zep_stirgeg,nw_tiefling02";
string sMinions12="zep_mane,zep_mane2,zep_mane3,zep_monodrone,zep_smiley,nw_wererat,x3_antoine,zep_werefrog,zep_wererata";
string sMinions13="zep_aarakocr_001,zep_aarakocr_002,zep_aarakocr_003,zep_aarakocr_004,zep_gibber_001,zep_gibber_002";
string sMinions14="zep_animtome1,zep_animtome2,zep_animtome3,zep_animtome4,zep_animtome5,zep_animtome6,zep_twigblight";
string sMinions15="zep_bsorca,zep_bsorcb,zep_orc,zep_orc2,zep_orcbloodg,zep_orcmerc,zep_pspiders,zep_pspidert";
string sMinions16="zep_skeldoll2,zep_skeldolls,zep_wspiders,zep_wspidert";

void Fill(int CR,object o = OBJECT_SELF)
{
    if(CR == 0)
    {
        switch(Random(16))
        {
        case 1: PopulateVars(o,0,sMinions1); break;
        case 2: PopulateVars(o,0,sMinions2); break;
        case 3: PopulateVars(o,0,sMinions3); break;
        case 4: PopulateVars(o,0,sMinions4); break;
        case 5: PopulateVars(o,0,sMinions5); break;
        case 6: PopulateVars(o,0,sMinions6); break;
        case 7: PopulateVars(o,0,sMinions7); break;
        case 8: PopulateVars(o,0,sMinions8); break;
        case 9: PopulateVars(o,0,sMinions9); break;
        case 10: PopulateVars(o,0,sMinions10); break;
        case 11: PopulateVars(o,0,sMinions11); break;
        case 12: PopulateVars(o,0,sMinions12); break;
        case 13: PopulateVars(o,0,sMinions13); break;
        case 14: PopulateVars(o,0,sMinions14); break;
        case 15: PopulateVars(o,0,sMinions15); break;
        case 16: PopulateVars(o,0,sMinions16); break;
        }
    }
}

void main()
{
       Fill(0);
       SpawnMinions(0.0);
}
