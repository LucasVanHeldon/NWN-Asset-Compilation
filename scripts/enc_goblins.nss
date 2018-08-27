#include "encounter"
#include "nw_o0_itemmaker"

string sCR0="el_goblinenc,el_goblinenc001,el_goblinenc1_2,el_goblinenc1_3,el_orc0,hobgoblin015,hobgoblin016,nw_goblina,nw_goblinb,zep_bugbear_008,zep_goblin";
string sCR1="el_goblinenc003,el_goblinenc1,el_orc1,hobgoblin017,nw_hobgoblin001,toee_gobftr,zep_cmgnoll_001,zep_cmgnoll_002,zep_cmgnoll_003,zep_cmgnoll_004,zep_cmgnoll_005,zep_cmgnoll_006,zep_cmgnoll_007,zep_cmgnoll_008,zep_cmgnoll_009,zep_cmgnoll_010,zep_cmgnoll_011,zep_cmgnoll_012,zep_cmgnoll_013";
string sCR2="bugbeara001,bugbearb001,el_bugbear2,el_gnoll2,el_goblinenc002,el_goblinenc2,el_orc2,gnoll012,gnoll123,goblina004,hobgoblin002,hobgoblin006,hobgoblin011,mmp_flamefistgob,mmp_gobcharmer,mmp_gobgrenadier,mmp_gobmesmer,nw_gnoll001,nw_hobgoblin002,toee_gnoll,toee_gnoll001,toh_goblinrogue,zep_bugbear_001,zep_bugbear_002,zep_bugbear_003,zep_bugbear_004,zep_bugbear_005,zep_bugbear_006,zep_bugbear_007,zep_frostgoblin";
string sCR3="boggle,boggle001,el_bugbear3,el_gnoll3,el_goblinenc004,el_goblinenc3,el_orc3,goblina002,goblina003,hobgoblin003,hobgoblin007,hobgoblin013,hobgoblin018,mmp_gnollftr004,mmp_gnollftr3,mmp_gnollrog,mmp_gnolltrickr,mmp_gobranger,nw_bugbeara,nw_bugbearb,nw_gobchiefb,nw_gobwiza,toee_gnollbarb,toee_gobrogue,toee_hobfighter,toh_gobelin,toh_gobling,toh_goblinrog001,toh_tommyknocker,zep_goblinscout,zep_goblinsha";
string sCR4="boggle002,boggle003,boggle009,bugbeara010,el_bugbear4,el_gnoll4,el_goblinenc4,el_orc4,gnoll002,hobgoblin012,melvingthegoblin,mmp_gnollrog001,mmp_gobranger001,nw_gnoll002,nw_gobchiefa,nw_gobwizb,toee_gnollbar001,toee_gnollfighte,toee_gnollranger,toh_abgnoll,toh_nightgoblin,zep_arcticbugb,zep_frostgobwiz,zep_goblinbargh,zep_goblinbes";
string sCR5="boggle005,bugbeara002,bugbeara006,el_bugbear5,el_gnoll5,el_goblinenc5,el_goblinenc6,el_orc5,goblina001,hobgoblin004,hobgoblin008,hobgoblin014,hobgoblin019,mmp_bugbearsorc,mmp_gnollcleric,mmp_gobranger002,mmp_priestkbargr,mmp_priestkhurgo,mmp_priestmaglub,nw_bugchiefa,nw_bugchiefb,nw_bugwiza,nw_bugwizb,toee_gnollbar002,toee_gnollfig001,toee_gobrogue001,toh_goblinevoker,toh_goblinrog002,zep_goblinworgg,zep_goblinworgrw";
string sCR6="boggle004,bugbeara011,el_bugbear6,el_gnoll6,el_orc6,gnoll003,hobgoblin009,hobgoblin020,mmp_gnollcler004,toee_gnollbar003,toee_gnollfig004,toee_gnollran001,toee_hobfight001,toh_gobelin001,toh_nightgobl001,zep_arcticbugbsh,zep_goblinbarghg,zep_goblinworgr";
string sCR7="bugbeara003,el_bugbear7,el_gnoll7,el_goblinenc7,el_orc7,gnoll004,gobwiza001,hobgoblin005,hobgoblin145,mmp_bugbearso001,mmp_gnollcler001,toee_gnollbar004,toee_gnollfig002,toee_gobrogue002,toee_hobfight002,toh_demonicbugbr,toh_goblinconjur";
string sCR8="bugbeara004,bugbeara007,el_bugbear8,el_gnoll8,el_goblinenc8,el_orc8,gnoll005,hobgoblin010,mmp_gnollcler005,mmp_priestnomog,toee_gnollbar005,toee_gnollfig003,toee_gnollfig005,toee_gnollran002,toee_hobfight003,toh_erlking";
string sCR9="boggle006,bugbeara008,bugbeara012,el_bugbear9,el_gnoll9,el_goblinenc9,mmp_bugbearso002,mmp_gnollcler002,toee_gnollbar006,toee_gnollran003,toh_erlking001,toh_goblintherug,toh_nightgobl002";
string sCR10="bugbeara005,el_bugbear10,el_goblinenc10,mmp_bugbearso003,mmp_bugbearso005,toee_hobfight004,toh_demonicbu001";
string sCR11="boggle007,el_gnoll11,el_goblinenc11,mmp_gnollcler003,nw_bugbearboss,nw_goblinboss,toee_gnollbar007,toh_erlking003,zep_goblinboss";
string sCR12="bugbeara009,zep_arcticbugbch";
string sCR13="el_goblinenc13,toh_erlking002,zep_frostgobchie";
string sCR14="boggle008";
string sCR15="toh_demonicbu003";
string sCR16="x2_s_tynan1";
string sCR17="el_goblinenc17,toh_goblinmagici";

string sCR20="toh_demonicbu004";
string sCR25="toh_demonicbu008";



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
    case 9:    PopulateVars(o,9,sCR9); break;
    case 10:   PopulateVars(o,10,sCR10);break;
    case 11:   PopulateVars(o,11,sCR11);break;
    case 12:PopulateVars(o,CR,sCR12);break;
    case 13:    PopulateVars(o,CR,sCR13);break;
    case 14: PopulateVars(o,CR,sCR14);break;
    case 15: PopulateVars(o,CR,sCR15);break;
    case 16: PopulateVars(o,CR,sCR16);break;
    case 17: PopulateVars(o,CR,sCR17);break;
    case 20: PopulateVars(o,20,sCR20);break;
    case 25: PopulateVars(o,25,sCR25);break;
    }
}


void main()
{
    SendMessageToPC(GetFirstPC(),"ENC Goblins");

    PopulateVars(OBJECT_SELF,0,sCR0);
    int EL = CalcEL(OBJECT_SELF);
    if(EL > 1)
        SpawnCR(0.5);
    Spawn();

}


