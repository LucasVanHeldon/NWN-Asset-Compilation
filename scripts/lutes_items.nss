void CreateMoney(int max, int min=0)
{
    int iGold = Random(max)+min;
    CreateItemOnObject("nw_it_gold001", OBJECT_SELF, iGold);
}

void CreateGems(int num)
{
    int n = num;
    int i;
    for(i = 0; i < n; i++)
    {
        string tag = "NW_IT_GEM0";
        int x = Random(15)+1;
        if(x < 10) tag = tag + "0";
        tag = tag + IntToString(x);

        object o = CreateItemOnObject(tag,OBJECT_SELF,1);
        if(!GetIsObjectValid(o))
        {
            PrintString("Error creating gem " + tag);
        }

    }
}



// lutes ring 001-010
// lutes amulet 001-010
// these can be enchanted
void CreateJewelry(int num)
{
    int n = num;
    int i;

    for(i = 0; i < n; i++)
    {
        string tag;
        int x = Die(10);

        if(iChestLevel < 5)
        {
            switch(x)
            {
            case 1: tag = "NW_IT_MNECK022"; break;
            case 2: tag = "NW_IT_MNECK021"; break;
            case 3: tag = "NW_IT_MRING021"; break;
            case 4: tag = "NW_IT_MRING022"; break;
            case 5: tag = "lutes_ring001"; break;
            case 6: tag = "lutes_ring002"; break;
            case 7: tag = "lutes_ring003"; break;
            case 8: tag = "lutes_amulet001"; break;
            case 9: tag = "lutes_amulet002"; break;
            case 10: tag = "lutes_amulet003"; break;
            }
        }
        else if(iChestLevel < 10)
        {
            switch(Die(4))
            {
            case 1: tag = "lutes_ring004"; break;
            case 2: tag = "lutes_ring005"; break;
            case 3: tag = "lutes_amulet004"; break;
            case 4: tag = "lutes_amulet005"; break;
            }
        }
        else if(iChestLevel < 15)
        {
            switch(Die(4))
            {
            case 1: tag = "lutes_ring006"; break;
            case 2: tag = "lutes_ring007"; break;
            case 3: tag = "lutes_amulet006"; break;
            case 4: tag = "lutes_amulet007"; break;
            }
        }
        else
        {
            switch(Die(4))
            {
            case 1: tag = "lutes_ring008"; break;
            case 2: tag = "lutes_ring009"; break;
            case 3: tag = "lutes_amulet008"; break;
            case 4: tag = "lutes_amulet009"; break;
            case 5: tag = "lutes_ring010"; break;
            case 6: tag = "lutes_amulet010"; break;
            }
        }

        object o = CreateItemOnObject(tag,OBJECT_SELF,1);
        if(!GetIsObjectValid(o))
        {
            PrintString("Error creating jewelry " + tag);
        }
    }
}





string CreatePoison()
{
    switch(Die(19))
    {
    case 1: return "x2_it_poison020";
    case 2: return "x2_it_poison038";
    case 3: return "x2_it_poison014";
    case 4: return "x2_it_poison026";
    case 5: return "x2_it_poison008";
    case 6: return "x2_it_poison032";
    case 7: return "z_poison001-033";
    case 8: return "x2_it_poison021";
    case 9: return "x2_it_poison039";
    case 10: return "x2_it_poison015";
    case 11: return "x2_it_poison027";
    case 12: return "x2_it_poison033";
    case 13: return "x2_it_poison009";
    case 14: return "x2_it_poison019";
    case 15: return "x2_it_poison037";
    case 16: return "x2_it_poison013";
    case 17: return "x2_it_poison025";
    case 18: return "x2_it_poison031";
    case 19: return "x2_it_poison007";
    }
    return "x2_it_poison020";
}

// create clothing low value
string CreateClothingLow()
{
    switch(Die(32))
    {
    case 1: return "NW_CLOTH027";
    case 2: return "NW_CLOTH017";
    case 3: return "NW_CLOTH015";
    case 4: return "NW_CLOTH021";
    case 5: return "X2_CLOTH008";
    case 6: return "NW_CLOTH022";
    case 7: return "NW_CLOTH024";
    case 8: return "NW_CLOTH012";
    case 9: return "X2_MDUERAR010";
    case 10: return "NW_CLOTH011";
    case 11: return "NW_CLOTH020";
    case 12: return "NW_CLOTH014";
    case 13: return "NW_CLOTH016";
    case 14: return "NW_CLOTH026";
    case 15: return "NW_CLOTH018";
    case 16: return "NW_CLOTH003";
    case 17: return "NW_CLOTH028";
    case 18: return "NW_CLOTH010";
    case 19: return "x2_it_pmrobe";
    case 20: return "NW_CLOTH002";
    case 21: return "NW_CLOTH007";
    case 22: return "NW_MCLOTH006";
    case 23: return "NW_CLOTH004";
    case 24: return "NW_CLOTH019";
    case 25: return "NW_CLOTH008";
    case 26: return "NW_CLOTH013";
    case 27: return "NW_CLOTH009";
    case 28: return "NW_CLOTH023";
    case 29: return "NW_CLOTH006";
    case 30: return "NW_CLOTH025";
    case 31: return "NW_CLOTH005";
    case 32: return "NW_CLOTH001";
    }
    return "NW_CLOTH001";
}


string CreateCrafting()
{
    switch(Die(103))
    {
    case 1: return "x2_it_cmat_steel";
    case 2: return "x2_it_cfm_bscrl";
    case 3: return "x2_it_lightgem001";
    case 4: return "x2_it_cmat_cloth";
    case 5: return "x2_it_cfm_wand";
    case 6: return "x2_it_dyeC23";
    case 7: return "x2_it_dyeC00";
    case 8: return "x2_it_dyeC02";
    case 9: return "x2_it_dyeC25";
    case 10: return "x2_it_dyeC48";
    case 11: return "x2_it_dyeC44";
    case 12: return "x2_it_dyeC35";
    case 13: return "x2_it_dyeC37";
    case 14: return "x2_it_dyeC29";
    case 15: return "x2_it_dyeC33";
    case 16: return "x2_it_dyeC26";
    case 17: return "x2_it_dyeC31";
    case 18: return "x2_it_dyeC20";
    case 19: return "x2_it_dyeC34";
    case 20: return "x2_it_dyeC36";
    case 21: return "x2_it_dyeC28";
    case 22: return "x2_it_dyeC39";
    case 23: return "x2_it_dyeC41";
    case 24: return "x2_it_dyeC32";
    case 25: return "x2_it_bmt_bshaft";
    case 26: return "x2_it_amt_feath";
    case 27: return "x2_it_cmat_adam";
    case 28: return "x2_it_cmat_iron";
    case 29: return "x2_it_cmat_mith";
    case 30: return "x2_it_lightgem005";
    case 31: return "x2_it_bmt_helm";
    case 32: return "x2_it_amt_iband";
    case 33: return "x2_it_amt_chain";
    case 34: return "x2_it_amt_hhead";
    case 35: return "x2_it_amt_morb";
    case 36: return "x2_it_amt_rings";
    case 37: return "x2_it_amt_spikes";
    case 38: return "x2_it_amt_spikes";
    case 39: return "x2_it_cmat_bone";
    case 40: return "x2_it_amt_lblade";
    case 41: return "x2_it_bmt_ltorso";
    case 42: return "x2_it_dyeL23";
    case 43: return "x2_it_dyeL00";
    case 44: return "x2_it_dyeL25";
    case 45: return "x2_it_dyeL02";
    case 46: return "x2_it_dyeL48";
    case 47: return "x2_it_dyeL44";
    case 48: return "x2_it_dyeL35";
    case 49: return "x2_it_dyeL37";
    case 50: return "x2_it_dyeL29";
    case 51: return "x2_it_dyeL33";
    case 52: return "x2_it_dyeL26";
    case 53: return "x2_it_dyeL31";
    case 54: return "x2_it_dyeL20";
    case 55: return "x2_it_dyeL34";
    case 56: return "x2_it_dyeL36";
    case 57: return "x2_it_dyeL28";
    case 58: return "x2_it_dyeL39";
    case 59: return "x2_it_dyeL41";
    case 60: return "x2_it_dyeL32";
    case 61: return "x2_it_cmat_leath";
    case 62: return "x2_it_amt_lpatch";
    case 63: return "x2_it_amt_lstrng";
    case 64: return "x2_it_pcpotion";
    case 65: return "x2_it_pcwand";
    case 66: return "x2_it_cfm_pbottl";
    case 67: return "x2_it_dyeM03";
    case 68: return "x2_it_dyeM00";
    case 69: return "x2_it_dyeM31";
    case 70: return "x2_it_dyeM16";
    case 71: return "x2_it_dyeM40";
    case 72: return "x2_it_dyeM28";
    case 73: return "x2_it_dyeM24";
    case 74: return "x2_it_dyeM32";
    case 75: return "x2_it_dyeM18";
    case 76: return "x2_it_dyeM10";
    case 77: return "x2_it_dyeM42";
    case 78: return "x2_it_dyeM02";
    case 79: return "x2_it_dyeM25";
    case 80: return "x2_it_dyeM37";
    case 81: return "x2_it_dyeM08";
    case 82: return "x2_it_dyeM36";
    case 83: return "x2_it_dyeM48";
    case 84: return "x2_it_bmt_xbows";
    case 85: return "x2_it_bmt_wpole";
    case 86: return "x2_it_bmt_wshldb";
    case 87: return "x2_it_bmt_oakhlt";
    case 88: return "x2_it_lightgem006";
    case 89: return "x2_it_cmat_elmw";
    case 90: return "x2_it_cmat_oakw";
    case 91: return "x2_it_bmt_proj";
    case 92: return "x2_it_lightgem003";
    case 93: return "x2_it_lightgem004";
    case 94: return "x2_it_amt_blades";
    case 95: return "x2_it_amt_ahead";
    case 96: return "x2_it_bmt_cchst";
    case 97: return "x2_it_bmt_stors2";
    case 98: return "x2_it_bmt_sshld";
    case 99: return "x2_it_bmt_mhlt";
    case 100: return "x2_it_lightgem007";
    case 101: return "x2_it_bmt_cloth";
    case 102: return "x2_it_amt_cpadd";
    case 103: return "x2_it_lightgem002";
    }
    return "x2_it_bmt_cloth";
}

string CreateKits()
{
    switch(Die(13))
    {
    case 1: return "NW_IT_TRAP033";
    case 2: return "NW_IT_TRAP013";
    case 3: return "NW_IT_TRAP017";
    case 4: return "NW_IT_TRAP029";
    case 5: return "NW_IT_MEDKIT001";
    case 6: return "NW_IT_MEDKIT002";
    case 7: return "NW_IT_TRAP005";
    case 8: return "NW_IT_TRAP041";
    case 9: return "NW_IT_TRAP037";
    case 10: return "NW_IT_TRAP001";
    case 11: return "NW_IT_TRAP009";
    case 12: return "NW_IT_TRAP035";
    case 13:
        switch(Die(19))
        {
        case 1: return "NW_IT_TRAP015";
        case 2: return "NW_IT_TRAP025";
        case 3: return "NW_IT_TRAP021";
        case 4: return "NW_IT_TRAP034";
        case 5: return "NW_IT_TRAP014";
        case 6: return "NW_IT_TRAP030";
        case 7: return "NW_IT_TRAP006";
        case 8: return "NW_IT_TRAP042";
        case 9: return "NW_IT_TRAP038";
        case 10: return "NW_IT_TRAP002";
        case 11: return "NW_IT_TRAP010";
        case 12: return "NW_IT_MEDKIT003";
        case 13: return "NW_IT_TRAP031";
        case 14: return "NW_IT_TRAP007";
        case 15: return "NW_IT_TRAP043";
        case 16: return "NW_IT_TRAP039";
        case 17: return "NW_IT_TRAP003";
        case 18: return "NW_IT_TRAP011";
        case 19:
            switch(Die(16))
            {
            case 1: return "NW_IT_TRAP027";
            case 2: return "NW_IT_TRAP019";
            case 3: return "NW_IT_TRAP023";
            case 4: return "NW_IT_MEDKIT004";
            case 5: return "NW_IT_TRAP036";
            case 6: return "NW_IT_TRAP016";
            case 7: return "NW_IT_TRAP022";
            case 8: return "NW_IT_TRAP018";
            case 9: return "NW_IT_TRAP030";
            case 10: return "NW_IT_TRAP032";
            case 11: return "NW_IT_TRAP008";
            case 12: return "NW_IT_TRAP044";
            case 13: return "NW_IT_TRAP040";
            case 14: return "NW_IT_TRAP004";
            case 15: return "NW_IT_TRAP012";
            case 16:
                switch(Die(10))
                {
                case 1: return "NW_IT_TRAP024";
                case 2: return "NW_IT_TRAP020";
                case 3: return "NW_IT_TRAP028";
                case 4: return "X2_IT_TRAP003";
                case 5: return "X2_IT_TRAP004";
                case 6:
                    switch(Die(2))
                    {
                    case 1: return "X2_IT_TRAP001";
                    case 2: return "X2_IT_TRAP002";
                    }
                }
           }
        }
     }
    return "NW_IT_TRAP033";
}


string CreateMiscItems()
{
    switch(Die(23))
    {
    case 1: return "NW_IT_CONTAIN001";
    case 2: return "NW_IT_CONTAIN003";
    case 3: return "NW_IT_CONTAIN002";
    case 4: return "X2_IT_PICKS002";
    case 5: return "NW_IT_PICKS001";
    case 6: return "NW_IT_PICKS002";
    case 7: return "NW_IT_TORCH001";
    case 8: return "X3_IT_WYVERNBLD";
    case 9:return "NW_IT_CONTAIN004";
    case 10: return "NW_IT_CONTAIN005";
    case 11: return "NW_IT_PICKS003";
    case 12: return "X2_IT_PICKS001";
    case 13: return "NW_IT_CONTAIN006";
    case 14: return "NW_IT_PICKS004";
    case 15: return "x2_it_acidbomb";
    case 16: return "x1_wmgrenade001";
    case 17: return "x1_wmgrenade002";
    case 18: return "x1_wmgrenade003";
    case 19: return "x1_wmgrenade004";
    case 20: return "x2_it_firebomb";
    case 21: return "x1_wmgrenade005";
    case 22: return "x1_wmgrenade006";
    case 23: return "x1_wmgrenade007";
    }
    return "NW_IT_CONTAIN001";

}

// generates non-magical misc items
void CreateMisc(int num)
{
    int i;
    string tag;
    for(i = 0; i < num; i++)
    {
        switch(Die(5))
        {
        case 1: tag = CreatePoison(); break;
        case 2: tag = CreateClothingLow(); break;
        case 3: tag = CreateCrafting(); break;
        case 4: tag = CreateKits(); break;
        case 5: tag = CreateMiscItems(); break;
        }
        object o = CreateItemOnObject(tag,OBJECT_SELF,1);
        if(!GetIsObjectValid(o))
        {
            PrintString("Error Creating Boots " + tag);
        }
    }
}

